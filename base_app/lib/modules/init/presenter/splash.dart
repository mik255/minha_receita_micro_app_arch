import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:micro_app_design_system/micro_app_design_system.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Modular.to.pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DSLogo().get(),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 120,
                  child: LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                    theme.primaryColor,
                  )),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
