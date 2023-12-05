import 'package:flutter/material.dart';

class AppDSTextField extends StatefulWidget {
  const AppDSTextField({
    super.key,
    this.labelText,
    this.hintText,
    this.controller,
    this.maxLines,
    this.onChange,
  });

  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final int? maxLines;
  final ValueChanged<String>? onChange;

  @override
  State<AppDSTextField> createState() => _AppDSTextFieldState();
}

class _AppDSTextFieldState extends State<AppDSTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
          onChanged: widget.onChange,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.grey[200],
            //label: Text(widget.labelText ?? ''),
            hintText: widget.hintText,
            //prefixIcon: const Icon(Icons.search),
          )),
    );
  }
}
