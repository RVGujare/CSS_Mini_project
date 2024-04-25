import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HoverCursor extends StatefulWidget {
  final Widget child;

  HoverCursor({required this.child});

  @override
  _HoverCursorState createState() => _HoverCursorState();
}

class _HoverCursorState extends State<HoverCursor> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: widget.child,
      cursor: _isHovered ? SystemMouseCursors.click : SystemMouseCursors.basic,
    );
  }
}
