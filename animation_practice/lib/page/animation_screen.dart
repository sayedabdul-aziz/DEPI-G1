import 'package:animation_practice/page/another_screen.dart';
import 'package:animation_practice/widgets/animated_container.dart';
import 'package:animation_practice/widgets/animated_opacity.dart';
import 'package:animation_practice/widgets/animation_controller.dart';
import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({super.key});

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animation')),
      body: Column(
        children: [
          AnimatedContainerWidget(),
          Divider(height: 20),
          AnimatedOpacityWidget(),
          Divider(height: 20),
          AnimationControllerWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.navigate_next),
        onPressed: () {
          Navigator.push(context, _createRoute());
        },
      ),
    );
  }

  Route<void> _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const AnotherScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const double begin = 0;
        const double end = 1;
        final tween = Tween<double>(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return ScaleTransition(scale: offsetAnimation, child: child);
      },
    );
  }
}
