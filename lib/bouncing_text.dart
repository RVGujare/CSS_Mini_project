import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BouncingText extends StatefulWidget {
  @override
  _BouncingTextState createState() => _BouncingTextState();
}

class _BouncingTextState extends State<BouncingText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0, end: 10),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 10, end: 0),
          weight: 50,
        ),
      ],
    ).animate(_controller);
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_animation.value),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              textAlign: TextAlign.center,
              'DECRYPTIFY',
              // style: TextStyle(
              //   color: Colors.black,
              //   fontSize: 40.0,
              //   fontWeight: FontWeight.bold,
              // ),
              style: GoogleFonts.pressStart2p(
                color: Colors.black,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
