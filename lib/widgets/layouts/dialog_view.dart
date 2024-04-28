import 'package:flutter/material.dart';

class DialogView extends StatelessWidget {
  final IconData icon;
  final String title;
  final List<Widget> children;
  final List<ElevatedButton> actions;

  const DialogView({
    super.key,
    this.icon = Icons.warning_rounded,
    required this.title,
    required this.children,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      icon: Icon(icon),
      title: Text(title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: children,
      ),
      actions: [
        TextButton(
          child: Text(actions.isEmpty ? 'Fechar' : 'Cancelar'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ...actions,
      ],
    );
  }
}
