import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterButton({
    super.key,
    required this.onPressed,
    this.iconSize,
    this.color,
    this.backgroundColor,
  });

  final double? iconSize;
  final Color? color;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: IconButton(
        icon: Icon(Icons.filter_alt, size: iconSize, color: color),
        tooltip: 'Filter',
        onPressed: onPressed,
      ),
    );
  }
}
