import 'package:flutter/material.dart';

enum AppDSTextFieldType { onlyText, simple, outlined }

class AppDSTextField extends StatefulWidget {
  const AppDSTextField({
    super.key,
    this.labelText,
    this.hintText,
    required this.controller,
    this.maxLines,
    this.onChange,
    this.onValidate,
    this.type = AppDSTextFieldType.outlined,
    this.obscureText = false,
    this.style,
    this.focusNode,
    this.padding = const EdgeInsets.symmetric(vertical: 8),
  });

  final String? hintText;
  final String? labelText;
  final TextEditingController controller;
  final int? maxLines;
  final ValueChanged<String>? onChange;
  final String? Function(String?)? onValidate;
  final bool obscureText;
  final AppDSTextFieldType type;
  final TextStyle? style;
  final FocusNode? focusNode;
  final EdgeInsets padding;

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

    return Container(
      padding: widget.padding,
      child: TextFormField(
          focusNode: widget.focusNode,
          style: widget.style,
          obscureText: widget.obscureText,
          controller: widget.controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: widget.onChange,
          maxLines: widget.obscureText ? 1 : widget.maxLines,
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
            if (widget.type == AppDSTextFieldType.onlyText) {
              return  InputDecoration(
                hintText: widget.hintText,
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: InputBorder.none, //
              );
            }
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

extension EditText on Text {
  Widget convertToInput({
    required TextEditingController controller,
    required String? Function(String?) onValidate,
    required FocusNode focusNode,
    String? hintText,
  }) {
    return Row(
      children: [
        Expanded(
          child: AppDSTextField(
            hintText: hintText,
            padding: EdgeInsets.zero,
            type: AppDSTextFieldType.onlyText,
            controller: controller,
            onValidate: onValidate,
            style: style,
          ),
        ),
        // IconButton(
        //   color: Colors.black.withOpacity(0.2),
        //   onPressed: () {
        //   //  focusNode.requestFocus();
        //   },
        //   icon: const Icon(Icons.edit),
        // ),
      ],
    );
  }
}
