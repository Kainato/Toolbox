import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CardListTile extends StatelessWidget {
  final String title;
  final Color? titleColor;
  final int? titleMaxLines;
  final String? subtitle;
  final int? subtitleMaxLines;
  final void Function()? onTap;
  final void Function()? onLongPress;
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
    this.onLongPress,
    this.listTileColor,
    this.style = ListTileStyle.list,
    this.elevation = 1,
    this.leading,
    this.trailing,
    this.titleMaxLines,
    this.subtitleMaxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      color: listTileColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        onLongPress: onLongPress,
        child: ListTile(
          tileColor: listTileColor,
          style: style,
          title: AutoSizeText(
            title,
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: titleMaxLines,
          ),
          subtitle: subtitle != null
              ? AutoSizeText(
                  subtitle!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: subtitleMaxLines,
                )
              : null,
          leading: leading,
          trailing: trailing,
        ),
      ),
    );
  }
}
