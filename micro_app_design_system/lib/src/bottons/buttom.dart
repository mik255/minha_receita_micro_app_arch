import 'package:flutter/material.dart';

import '../tokens/typography/app_typography.dart';

enum DSCustomButtonTypes { solid, outline }

class DSCustomButton extends StatelessWidget {
  const DSCustomButton({
    super.key,
    this.child,
    this.backgroundColor,
    this.text,
    this.onTap,
    this.isLoading = false,
    this.padding = const EdgeInsets.all(16),
    this.type = DSCustomButtonTypes.solid,
    this.enabled = true,
  });

  final Widget? child;
  final String? text;
  final bool isLoading;
  final Color? backgroundColor;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;
  final DSCustomButtonTypes type;

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isLoading) {
          return null;
        }
        if (onTap == null) {
          return null;
        }
        if (enabled) {
          return onTap;
        }
        return null;
      }(),
      child: Padding(
        padding: padding,
        child: Container(
          decoration: BoxDecoration(
            color: () {
              if (backgroundColor != null) {
                return backgroundColor;
              }
              if (type == DSCustomButtonTypes.outline) {
                return Colors.transparent;
              }

              if (type == DSCustomButtonTypes.solid) {
                return Theme.of(context).colorScheme.primary;
              }

              return Theme.of(context).colorScheme.primary;
            }(),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1,
              color: () {
                if (type == DSCustomButtonTypes.outline) {
                  return Theme.of(context).colorScheme.onSecondary.withOpacity(0.2);
                }
                return Colors.transparent;
              }(),
            ),
          ),
          height: 50,
          child: Center(
            child: Builder(builder: (context) {
              if (isLoading) {
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
                  child: Text(
                    text!,
                    style: AppTypography.button.copyWith(
                      color: () {
                        if (type == DSCustomButtonTypes.outline) {
                          return Theme.of(context).colorScheme.onSecondary;
                        }

                        if (type == DSCustomButtonTypes.solid) {
                          return Colors.white;
                        }

                        return Colors.white;
                      }(),
                    ),
                  ));
            }),
          ),
        ),
      ),
    );
  }
}
