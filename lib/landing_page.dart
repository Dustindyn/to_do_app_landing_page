import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  final List<String> _headerWords = [
    "Lorem",
    "ipsum",
    "dolor",
    "sit",
    "amet,",
    "consectetur",
    "adipiscing",
    "elit.",
    "Sed",
    "do",
    "eiusmod",
    "tempor",
    "incididunt",
    "ut",
    "labore",
    "et",
    "dolore",
    "magna",
    "aliqua."
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _headerWords.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 800),
        vsync: this,
      )..addListener(() => setState(() {})),
    );
    _animations = _controllers
        .map((controller) => Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(parent: controller, curve: Curves.easeInOut),
            ))
        .toList();

    _animateWords();
  }

  void _animateWords() async {
    for (var controller in _controllers) {
      await Future.delayed(const Duration(milliseconds: 100));
      controller.forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Wrap(
                  spacing: 4,
                  runSpacing: 8,
                  children: List.generate(_headerWords.length, (index) {
                    return FadeTransition(
                      opacity: _animations[index],
                      child: Text(
                        _headerWords[index],
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    );
                  }),
                ),
                // Hier können Sie den Rest Ihres Contents hinzufügen
              ],
            ),
          ),
        ),
      ),
    );
  }
}
