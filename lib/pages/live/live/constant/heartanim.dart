import 'dart:math' as math;

import 'package:flutter/material.dart';

class HeartAnim extends StatefulWidget {
  final double top, left, opacity;

  const HeartAnim({super.key, required this.top, required this.left, required this.opacity});

  @override
  State<HeartAnim> createState() => _HeartAnimState();
}

class _HeartAnimState extends State<HeartAnim> {
  @override
  Widget build(BuildContext context) {
    final random = math.Random();
    final hearts = Container(
      margin: EdgeInsets.only(left: widget.left, top: widget.top / 1000),
      color: Colors.transparent,
      child: Opacity(
        opacity: 0.75,
        child: Icon(
          Icons.favorite,
          color: Colors.red,
          size: (18 + random.nextInt(18)).toDouble(),
        ),
      ),
    );
    return hearts;

    return Container();
  }
}
