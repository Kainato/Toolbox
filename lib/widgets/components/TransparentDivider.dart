import 'package:flutter/material.dart';

class TransparentDivider extends StatelessWidget {
  const TransparentDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: Colors.transparent,
    );
  }
}
