import 'package:flutter/material.dart';

class DSSession extends StatefulWidget {
  final IconData icon;
  final String title;
  final Widget? customTitle;
  final String subtitle;
  final Widget? customSubtitle;

  final Widget content;

  final Widget? action;

  final double height;

  final Function(int index)? ontap;
  ValueNotifier<bool>? isOpen;

  ScrollPhysics? physics;
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
    this.physics,
    required this.height,
  });

  @override
  State<DSSession> createState() => _DSSessionState();
}

class _DSSessionState extends State<DSSession>
    with AutomaticKeepAliveClientMixin {
  late ValueNotifier<bool> isOpen;
  GlobalKey key = GlobalKey();
  @override
  initState() {
    isOpen = widget.isOpen ?? ValueNotifier<bool>(false);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);

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
              headerWidget(),
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
                height: isOpen.value ?widget.height: 0,
                child: SingleChildScrollView(
                  //physics: widget.physics??const BouncingScrollPhysics(),
                  physics: const NeverScrollableScrollPhysics(),
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

  Widget headerWidget() {
    var theme = Theme.of(context);
    return  Expanded(
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
