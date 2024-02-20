import 'package:flutter/material.dart';

class DSCheckBox extends StatefulWidget {
  const DSCheckBox({super.key, this.description, required this.onChanged});

  final String? description;
  final Function(bool value ) onChanged;
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
          widget.onChanged(isChecked);
        });
      },
      child: Row(
        children: [
          Checkbox(
            visualDensity: VisualDensity.compact,
            value: isChecked,
            activeColor: Theme.of(context).colorScheme.primaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onChanged: (value) {
              setState(() {
                isChecked = value ?? false;
                widget.onChanged(isChecked);
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
