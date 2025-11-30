import 'package:flutter/material.dart';

class AnimatedOpacityWidget extends StatefulWidget {
  const AnimatedOpacityWidget({super.key});

  @override
  State<AnimatedOpacityWidget> createState() => _AnimatedOpacityWidgetState();
}

class _AnimatedOpacityWidgetState extends State<AnimatedOpacityWidget> {
  bool visible = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
          opacity: visible ? 1 : 0,
          duration: const Duration(seconds: 1),
          child: Container(width: 100, height: 100, color: Colors.red),
        ),

        ElevatedButton(
          child: const Text('FadeIn'),
          onPressed: () {
            setState(() {
              visible = !visible;
            });
          },
        ),
      ],
    );
  }
}
