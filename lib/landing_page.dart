import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xff414141),
            Color(0xff383838),
            Color(0xff303030),
            Color(0xff272727),
            Color(0xff1f1f1f),
            Color(0xff171717),
            Color(0xff0e0e0e),
            Color(0xff000000),
          ],
          tileMode: TileMode.repeated,
        ),
      ),
      child: MaterialApp(
        home: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(),
          ),
        ),
      ),
    );
  }
}
