import 'package:flutter/material.dart';
import 'package:minha_receita/core/services/get_widget_size.dart';
import 'package:minha_receita/modules/register_recipe/presenter/components/ds_chip.dart';

class DSSession extends StatefulWidget {
  final IconData icon;
  final String title;
  final Widget? customTitle;
  final String subtitle;
  final Widget? customSubtitle;

  final Widget content;

  final Widget? action;

  final Function(int index)? ontap;
  ValueNotifier<bool>? isOpen;

  DSSession({
    super.key,
    required this.icon,
    required this.title,
    this.customTitle,
    required this.subtitle,
    this.customSubtitle,
    required this.content,
    this.ontap,
    this.action,
    this.isOpen,
  });

  @override
  State<DSSession> createState() => _DSSessionState();
}

class _DSSessionState extends State<DSSession>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late ValueNotifier<bool> isOpen;

  @override
  initState() {
    isOpen = widget.isOpen ?? ValueNotifier<bool>(false);
    super.initState();
  }

  GlobalKey key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var theme = Theme.of(context);
    return Column(
      children: [
        InkWell(
          highlightColor: Colors.transparent,
          onTap: () {
            widget.ontap?.call(0);
            isOpen.value = !isOpen.value;
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    iconWidget(widget.icon),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0)
                            .copyWith(left: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: widget.customTitle?? Text(
                                    widget.title,
                                    style: theme.textTheme.titleLarge,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: widget.customSubtitle??Text(
                                    widget.subtitle,
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              widget.action ?? Container(),
              const Icon(Icons.keyboard_arrow_down_outlined)
            ],
          ),
        ),
        AnimatedBuilder(
            animation: isOpen,
            builder: (context, state) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.ease,
                height: isOpen.value
                    ? () {
                        if (key.currentContext != null) {
                          final box = key.currentContext?.findRenderObject()
                              as RenderBox?;
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            key = GlobalKey();
                          });
                          return box?.size.height;
                        }
                      }()
                    : 0,
                child: SingleChildScrollView(
                 // physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Container(
                        key: key,
                        child: widget.content,
                      ),
                    ],
                  ),
                ),
              );
            })
      ],
    );
  }

  Widget iconWidget(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: const ShapeDecoration(
        color: Color(0xFFF4F4F4),
        shape: OvalBorder(),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          12,
        ),
        child: Center(
          child: Icon(
            icon,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
