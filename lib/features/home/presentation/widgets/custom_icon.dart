import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1)),
      child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,
            color: Colors.white,
            size: 28,
          )),
    );
  }
}
