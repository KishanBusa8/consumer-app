
import 'package:flutter/material.dart';

class RoutingWidget extends StatelessWidget {
  const RoutingWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        constraints: BoxConstraints(maxHeight: 53, maxWidth: 53),
        child: new Image.asset(
          'assets/noun_Next_1167113.png',
        ),
      ),
    );
  }
}

