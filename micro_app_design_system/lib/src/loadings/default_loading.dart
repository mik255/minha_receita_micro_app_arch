import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class DSDefaultLoading extends StatelessWidget {
  const DSDefaultLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'lib/design_system/animations/assets/loading.json',
      height: 200,
      width: 200,
    );
  }
}
