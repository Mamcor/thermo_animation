import 'package:flutter/material.dart';

class ThermoIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const ThermoIcon({
    required this.icon,
    required this.color,
    required this.onTap,
    required this.selected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 64,
        height: 64,
        child: Center(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: selected ? 64 : 48,
            height: selected ? 64 : 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selected ? color.withOpacity(.3) : Colors.grey.shade200,
            ),
            child: Center(
              child: Icon(
                icon,
                size: selected ? 52 : 32,
                color: selected ? color : Colors.grey.shade300,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
