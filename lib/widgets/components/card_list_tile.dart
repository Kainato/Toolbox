import 'package:flutter/material.dart';

class CardListTile extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final String? subtitle;
  final void Function()? onTap;
  final Color? listTileColor;
  final ListTileStyle style;
  final double elevation;
  final Widget? leading;
  final Widget? trailing;

  const CardListTile({
    super.key,
    required this.title,
    this.titleColor,
    this.subtitle,
    this.onTap,
    this.listTileColor,
    this.style = ListTileStyle.list,
    this.elevation = 1,
    this.leading,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: listTileColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: ListTile(
          style: style,
          title: Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: subtitle != null ? Text(subtitle!) : null,
          leading: leading,
          trailing: trailing,
        ),
      ),
    );
  }
}
