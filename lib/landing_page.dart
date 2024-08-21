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
  late AnimationController _imageController;
  late Animation<Offset> _imageSlideAnimation;
  late Animation<double> _imageOpacityAnimation;
  late AnimationController _featuresController;
  late Animation<double> _featuresOpacityAnimation;
  final List<List<String>> _headerWords = [
    ["Organize", "Smarter,", "Live", "Easier:"],
    ["Your", "Personal,", "Task", "Manager,", "Always", "at", "Hand!"]
  ];
  final List<String> _features = [
    "Create tasks effortlessly",
    "Set task notifications",
    "Complete tasks with satisfaction",
    "Monthly task overview",
    "Daily progress dashboard",
    "Weekly task distribution insights"
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _headerWords.expand((e) => e).length,
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

    _imageController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _imageSlideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeOutCubic,
    ));
    _imageOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _imageController,
      curve: Curves.easeIn,
    ));

    _featuresController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _featuresOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _featuresController,
      curve: Curves.easeIn,
    ));

    _animateWords();
  }

  void _animateWords() async {
    for (var controller in _controllers) {
      await Future.delayed(const Duration(milliseconds: 100));
      controller.forward();
    }
    await Future.delayed(const Duration(milliseconds: 500));
    _imageController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    _featuresController.forward();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _imageController.dispose();
    _featuresController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-1, -1),
          radius: 1.5,
          colors: [
            Color(0xFF3A3A3A),
            Color(0xFF2A2A2A),
            Color(0xFF1A1A1A),
            Color(0xFF000000),
          ],
          stops: [0.0, 0.2, 0.4, 1],
        ),
      ),
      child: MaterialApp(
        home: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Container()),
        ),
      ),
    );
  }
}
