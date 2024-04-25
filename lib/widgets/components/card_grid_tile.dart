import 'package:flutter/material.dart';

class CardGridTile extends StatelessWidget {
  final Widget child;
  final Widget footer;
  final void Function()? onTap;
  final Color? gridColor;

  const CardGridTile({
    super.key,
    required this.child,
    required this.footer,
    this.onTap,
    this.gridColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: gridColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: GridTile(
          footer: footer,
          child: child,
        ),
      ),
    );
  }
}
