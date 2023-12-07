import 'package:flutter/material.dart';

GlobalKey<NavigatorState> navigateKey = GlobalKey<NavigatorState>();

String get baseUrl => const String.fromEnvironment('baseUrl', defaultValue: 'http://10.0.2.2:8081');