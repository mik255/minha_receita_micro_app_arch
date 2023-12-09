import 'package:flutter/material.dart';

class DSModal extends StatelessWidget {
  const DSModal({
    super.key,
    required this.content,
    this.withScroll = true,
  });

  final Widget content;
  final bool withScroll;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          closeButton(context),
          const SizedBox(height: 16),
          if(withScroll)
          Expanded(
            child: SingleChildScrollView(
              child: content,
            ),
          )else
          content,
        ],
      ),
    );
  }

  Widget closeButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
