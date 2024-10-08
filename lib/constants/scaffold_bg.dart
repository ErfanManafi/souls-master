import 'package:flutter/material.dart';
import 'package:souls_master/constants/my_color.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraints.maxHeight),
          child: Container(
            decoration: const BoxDecoration(
              gradient: MyColor.scaffoldBgColor,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
