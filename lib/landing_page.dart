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
  final List<List<String>> _headerWords = [
    ["Organize", "Smarter,", "Live", "Easier:"],
    ["Your", "Personal,", "Task", "Manager,", "Always", "at", "Hand!"]
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

    _animateWords();
  }

  void _animateWords() async {
    for (var controller in _controllers) {
      await Future.delayed(const Duration(milliseconds: 100));
      controller.forward();
    }
    await Future.delayed(const Duration(milliseconds: 500));
    _imageController.forward();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _imageController.dispose();
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
        home: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 80),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _headerWords.asMap().entries.map((lineEntry) {
                    return Wrap(
                      spacing: 4,
                      runSpacing: 8,
                      children:
                          lineEntry.value.asMap().entries.map((wordEntry) {
                        int index = lineEntry.key == 0
                            ? wordEntry.key
                            : _headerWords[0].length + wordEntry.key;
                        return FadeTransition(
                          opacity: _animations[index],
                          child: Text(
                            wordEntry.value,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }).toList(),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: FadeTransition(
                    opacity: _imageOpacityAnimation,
                    child: SlideTransition(
                      position: _imageSlideAnimation,
                      child: const Image(
                        image: AssetImage('assets/calendar_view.png'),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
