import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlipCard extends StatefulWidget {
  final Widget front;
  final Widget back;

  const FlipCard({super.key, required this.front, required this.back});

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _frontRotation;
  late Animation<double> _backRotation;

  bool _showFront = true;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 420));

    // Front: 0 → -90° (disappear), then back: 90° → 0 (appear) with elastic
    _frontRotation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: -pi / 2)
              .chain(CurveTween(curve: Curves.easeInCubic)),
          weight: 0.45),
      TweenSequenceItem(tween: ConstantTween(pi / 2), weight: 0.1),
      TweenSequenceItem(
          tween: Tween(begin: pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.elasticOut)),
          weight: 0.45),
    ]).animate(_controller);

    _backRotation = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: pi / 2)
              .chain(CurveTween(curve: Curves.easeInCubic)),
          weight: 0.45),
      TweenSequenceItem(tween: ConstantTween(-pi / 2), weight: 0.1),
      TweenSequenceItem(
          tween: Tween(begin: -pi / 2, end: 0.0)
              .chain(CurveTween(curve: Curves.elasticOut)),
          weight: 0.45),
    ]).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flip() {
    HapticFeedback.lightImpact();
    setState(() {
      _showFront = !_showFront;
    });

    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _flip,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(
                  _showFront ? _frontRotation.value : _backRotation.value),
            child: _showFront ? widget.front : widget.back,
          );
        },
      ),
    );
  }
}
