import 'package:flutter/material.dart';

import '../tokens/colors/colors.dart';
import '../tokens/typography/app_typography.dart';

class AppDSButtom extends StatelessWidget {
  const AppDSButtom({
    super.key,
    this.child,
    this.backgroundColor,
    this.text,
    this.onTap,
    this.isLoading,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget? child;
  final String? text;
  final bool? isLoading;
  final Color? backgroundColor;
  final void Function()? onTap;
  final EdgeInsetsGeometry padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:padding,
      child: SizedBox(
        height: 50,
        child: ElevatedButton(
          onPressed: isLoading != null && isLoading == true ? null : onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? Theme.of(context).colorScheme.primary,
            // Cor de fundo do botão
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10), // Borda arredondada
            ),
            shadowColor: Colors.black.withOpacity(0.12),
            // Cor e opacidade da sombra
            elevation: 10, // Altura da sombra
          ),
          child: Builder(
              builder: (context) {
                if (isLoading != null && isLoading == true) {
                  return const SizedBox(
                    height: 20,
                    width: 20,
                    child: Center(child: CircularProgressIndicator()),);
                }
                return Ink(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: text != null
                      ? Text(
                    text!,
                    style: AppTypography.button.copyWith(
                      color: AppDSColors.white,
                    ),
                  )
                      : child, // Seu conteúdo dentro do botão
                );
              }
          ),
        ),
      ),
    );
  }
}
