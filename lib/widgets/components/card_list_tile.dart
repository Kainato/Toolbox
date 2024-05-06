import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CardListTile extends StatelessWidget {
  /// O título do item do card que será exibido a esquerda no ListTile
  /// que está sendo utilizado para exibir o item do card.
  /// ## Atributos
  /// * Tipo `String`
  final String title;

  /// A cor do título do item do card que está sendo exibido a esquerda no ListTile.
  /// ## Atributos
  /// * Tipo `Color`
  final Color? titleColor;

  /// O número máximo de linhas que o título do item do card pode ter.
  /// ## Atributos
  /// * Tipo `int`
  final int? titleMaxLines;

  /// O subtítulo do item do card que será exibido abaixo do título no ListTile.
  /// ## Atributos
  /// * Tipo `String`
  final String? subtitle;

  /// O número máximo de linhas que o subtítulo do item do card pode ter.
  /// ## Atributos
  /// * Tipo `int`
  final int? subtitleMaxLines;

  /// A função que será executada ao clicar no item do card.
  /// ## Atributos
  /// * Tipo `Function`
  final void Function()? onTap;

  /// A função que será executada ao pressionar o item do card por um longo tempo.
  /// ## Atributos
  /// * Tipo `Function`
  final void Function()? onLongPress;

  /// A cor do card que será exibido no ListTile.´
  /// ## Atributos
  /// * Tipo `Color`
  final Color? listTileColor;

  /// O estilo do ListTile que está sendo utilizado para exibir o item do card.
  /// Isso define a fonte que será usada para o [title].
  final ListTileStyle style;

  /// A elevação do card que será exibido no ListTile.
  /// ## Atributos
  /// * Tipo `double`
  final double elevation;

  /// O widget que será exibido a esquerda no ListTile.
  /// ## Atributos
  /// * Tipo `Widget`
  final Widget? leading;

  /// O widget que será exibido a direita no ListTile.
  /// ## Atributos
  /// * Tipo `Widget`
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
