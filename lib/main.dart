import 'package:flutter/material.dart';
import 'package:you_do_landing_page/landing_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LandingPage();
  }
}
