import 'package:flutter/material.dart';

class AnimationControllerWidget extends StatefulWidget {
  const AnimationControllerWidget({super.key});

  @override
  State<AnimationControllerWidget> createState() =>
      _AnimationControllerWidgetState();
}

class _AnimationControllerWidgetState extends State<AnimationControllerWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _animation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _animation =
        Tween<AlignmentGeometry>(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).animate(
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
          )
          ..addListener(() {
            setState(() {});
          });
    _rotationAnimation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AlignTransition(
      alignment: _animation,
      child: RotationTransition(
        turns: _rotationAnimation,
        child: FlutterLogo(size: 100),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
