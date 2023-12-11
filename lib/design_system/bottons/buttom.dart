import 'package:flutter/material.dart';

import '../tokens/colors/colors.dart';
import '../tokens/typography/app_typography.dart';

enum DSCustomButtonTypes { solid, outline }

class DSCustomButton extends StatelessWidget {
  const DSCustomButton({
    super.key,
    this.child,
    this.backgroundColor,
    this.text,
    this.onTap,
    this.isLoading,
    this.padding = const EdgeInsets.all(16),
    this.type = DSCustomButtonTypes.solid,
  });

  final Widget? child;
  final String? text;
  final bool? isLoading;
  final Color? backgroundColor;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;
  final DSCustomButtonTypes type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: isLoading != null && isLoading == true ? null : onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: () {

              if (type == DSCustomButtonTypes.outline) {
                return Colors.transparent;
              }
              if (backgroundColor != null) {
                return backgroundColor;
              }

              if (type == DSCustomButtonTypes.solid) {
                return backgroundColor ??
                    Theme.of(context).colorScheme.primary;
              }

              return Theme.of(context).colorScheme.primary;
            }(),
            // Cor de fundo do botão
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: () {
                  if (type == DSCustomButtonTypes.outline) {
                    return BorderSide(
                      color: Theme.of(context).colorScheme.onSecondary,
                      width: 1,
                    );
                  }
                  return BorderSide.none;
                }()),
            shadowColor: Colors.black.withOpacity(0.12),
            // Cor e opacidade da sombra
            elevation: 0, // Altura da sombra
          ),
          child: Builder(builder: (context) {
            if (isLoading != null && isLoading == true) {
              return const SizedBox(
                height: 20,
                width: 20,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            return Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: text != null
                  ? Text(
                      text!,
                      style: AppTypography.button.copyWith(
                        color: (){
                          if (type == DSCustomButtonTypes.outline) {
                            return Theme.of(context).colorScheme.onSecondary;
                          }
                          return Theme.of(context).colorScheme.background;
                        }(),
                      ),
                    )
                  : child,
            );
          }),
        ),
      ),
    );
  }
}
