import 'package:absen/core/core.dart';
import 'package:flutter/material.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final Color backgroundColor;

  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.maxWidth = 480.0, // Standard mobile width
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              if (context.deviceWidth > maxWidth)
                BoxShadow(
                  color: Colors.black.withValues(alpha: .1),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
            ],
          ),
          height: context.deviceHeight,
          child: child,
        ),
      ),
    );
  }
}