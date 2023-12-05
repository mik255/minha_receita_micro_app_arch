import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class DSErrorHandle extends StatelessWidget {
  const DSErrorHandle({
    super.key,
    required this.errorMsg,
    required this.tryAgain,
  });

  final String errorMsg;
  final void Function() tryAgain;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Lottie.asset(
            'lib/design_system/animations/assets/error.json',
            height: 100,
            width: 100,
          ),
        ),
        Text(
          errorMsg,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        TextButton(
          onPressed: tryAgain,
          child: Text(
            'Tentar novamente',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
