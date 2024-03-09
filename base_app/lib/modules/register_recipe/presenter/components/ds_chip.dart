import 'package:flutter/material.dart';

class DSChip extends StatelessWidget {
  const DSChip({
    super.key,
    this.icon,
    required this.title,
    this.onTap,
    this.backgroundColor,
    this.titleColor,
  });

  final IconData? icon;
  final String title;

  final Color? titleColor;

  final void Function()? onTap;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          color: backgroundColor ?? const Color(0x33D9D9D9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  icon,
                  size: 20,
                ),
              ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: titleColor,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
