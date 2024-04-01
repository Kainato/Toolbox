// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:toolbox/enums/DrawerItens.dart';

class DrawerListTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final void Function() onTap;
  final DrawerItens drawerItem;
  final DrawerItens pageFromDrawer;

  const DrawerListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    required this.drawerItem,
    required this.pageFromDrawer,
  });

  @override
  Widget build(BuildContext context) {
    Color selectedColorOnSurface = drawerItem == pageFromDrawer
        ? Theme.of(context).colorScheme.onInverseSurface
        : Theme.of(context).colorScheme.onSurface;
    Color selectedColorSurface = drawerItem == pageFromDrawer
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.surface;
    return Card(
      color: selectedColorSurface,
      child: ListTile(
        tileColor: selectedColorSurface,
        style: ListTileStyle.drawer,
        onTap: onTap,
        title: Text(
          title,
          style: TextStyle(color: selectedColorOnSurface),
        ),
        leading: Icon(
          icon,
          color: selectedColorOnSurface,
        ),
      ),
    );
  }
}
