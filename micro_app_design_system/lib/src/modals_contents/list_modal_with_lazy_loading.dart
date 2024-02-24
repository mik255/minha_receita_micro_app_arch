import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:micro_app_design_system/src/extensions/scroll_controller.dart';

class DSListModalWithLazyLoading extends StatefulWidget {
  const DSListModalWithLazyLoading(
      {super.key,
      required this.onLazeLoading,
      required this.scrollController,
      required this.items});

  final Future<void> Function() onLazeLoading;
  final ScrollController scrollController;
  final List<Widget> items;

  @override
  State<DSListModalWithLazyLoading> createState() =>
      _DSListModalWithLazyLoadingState();
}

class _DSListModalWithLazyLoadingState
    extends State<DSListModalWithLazyLoading> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.onBottomListener(() async {
      if (!isLoading) {
        setState(() {
          isLoading = true;
        });
        await widget.onLazeLoading();
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    widget.scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Theme.of(context).colorScheme.background,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          height: MediaQuery.of(context).size.height * 0.7,
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: Column(
              children: [
                ...widget.items,
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: AnimatedContainer(
                    color: Theme.of(context).colorScheme.background,
                    height: () {
                      if (isLoading) {
                        return 50.0;
                      }
                      return 0.0;
                    }(),
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear,
                    child: const Center(
                      child: LinearProgressIndicator(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
