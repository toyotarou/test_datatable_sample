import 'package:flutter/material.dart';

class ScrollableWidget extends StatelessWidget {

  const ScrollableWidget({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: child,
      ),
    );
  }
}
