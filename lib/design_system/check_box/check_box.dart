import 'package:flutter/material.dart';

class DSCheckBox extends StatefulWidget {
  const DSCheckBox({super.key, this.description});

  final String? description;

  @override
  State<DSCheckBox> createState() => _DSCheckBoxState();
}

class _DSCheckBoxState extends State<DSCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
      },
      child: Row(
        children: [
          Checkbox(
            value: isChecked,
            activeColor: Theme.of(context).colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onChanged: (value) {
              setState(() {
                isChecked = value ?? false;
              });
            },
          ),
          Text(
            widget.description ?? '',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
