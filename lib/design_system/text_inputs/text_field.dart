import 'package:flutter/material.dart';

enum AppDSTextFieldType { simple, outlined }

class AppDSTextField extends StatefulWidget {
  const AppDSTextField({
    super.key,
    this.labelText,
    this.hintText,
    required this.controller,
    this.maxLines,
    this.onChange,
    this.onValidate,
    this.obscureText = false,
  });

  final String? hintText;
  final String? labelText;
  final TextEditingController controller;
  final int? maxLines;
  final ValueChanged<String>? onChange;
  final String? Function(String?)? onValidate;
  final bool obscureText;
  @override
  State<AppDSTextField> createState() => _AppDSTextFieldState();
}

class _AppDSTextFieldState extends State<AppDSTextField> {
  String? errorMsg;

  @override
  Widget build(BuildContext context) {
    var borderDecoration = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: Theme.of(context).colorScheme.tertiaryContainer,
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
          obscureText: widget.obscureText,
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: widget.onChange,
          validator: (String? value) {
            var error = widget.onValidate?.call(value);
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                errorMsg = error;
              });
            });

            return error;
          },
          decoration: () {
            return InputDecoration(
              focusedBorder: borderDecoration.copyWith(
                borderSide: BorderSide(
                  color: () {
                    if (widget.controller.text.isEmpty) {
                      return Theme.of(context).colorScheme.tertiaryContainer;
                    }

                    if (errorMsg == null) {
                      return Theme.of(context).colorScheme.inversePrimary;
                    }
                    return Theme.of(context).colorScheme.error;
                  }(),
                ),
              ),
              border: borderDecoration,
              disabledBorder: borderDecoration,
              enabledBorder: borderDecoration,
              errorBorder: borderDecoration.copyWith(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.background,
              hintText: widget.hintText,
              suffixIcon: Builder(builder: (context) {
                return Builder(builder: (context) {
                  if (widget.controller.text.isEmpty) {
                    return const SizedBox();
                  }
                  return SizedBox(
                    height: 16,
                    child: Icon(
                      errorMsg == null ? Icons.check : Icons.close,
                      color: errorMsg == null
                          ? Theme.of(context).colorScheme.inversePrimary
                          : Theme.of(context).colorScheme.error,
                    ),
                  );
                });
              }),
            );
          }()),
    );
  }
}
