import 'package:flutter/material.dart';
import 'package:Toolbox/classes/toolbox_navigator.dart';
import 'package:Toolbox/enums/drawer_itens.dart';
import 'package:Toolbox/widgets/components/card_list_tile.dart';

class DrawerListTile extends StatelessWidget {
  /// O título do item do drawer que será exibido no centro no ListTile
  /// que está sendo utilizado para exibir o item do drawer.
  /// ## Atributos
  /// * Tipo `String`
  final String title;

  /// O ícone do item do drawer que será exibido na esquerda no ListTile
  /// que está sendo utilizado para exibir o item do drawer.
  /// ## Atributos
  /// * Tipo `IconData`
  final IconData icon;

  /// A chave do item do drawer que será utilizada para definir de qual
  /// item do drawer se trata. Ela também é utilizada para definir
  /// a cor do texto e do ícone do item do drawer.
  /// ## Atributos
  /// * Tipo `DrawerItens` - Veja mais em [DrawerKeys]
  final DrawerKeys drawerKey;

  /// A página atual a qual a aplicação está exibindo.
  /// Ela é definida no construtor do DrawerView que vem da BackgroundPageView
  /// e é utilizada para definir a cor do texto e do ícone do item do drawer.
  /// ## Atributos
  /// * Tipo `DrawerItens` - Veja mais em [DrawerKeys]
  final DrawerKeys currentPage;

  /// A página que será aberta ao clicar no item do drawer.
  /// ## Atributos
  /// * Tipo `Widget`
  final Widget page;

  /// O principal construtor de cada item do drawer. Ele recebe todos os
  /// atributos necessários de um [ListTile](www.youtube.com/watch?v=l8dj0yPBvgQ) e os utiliza para criar um
  /// item do drawer personalizado.
  /// ### Parâmetros
  /// * title: `String` - O título do item do drawer.
  /// * icon: `IconData` - O ícone do item do drawer.
  /// * drawerKey: `DrawerKeys` - A chave do item do drawer.
  /// * currentPage: `DrawerKeys` - A página atual da aplicação.
  /// * page: `Widget` - A página que será aberta ao clicar no item do drawer.
  const DrawerListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.drawerKey,
    required this.currentPage,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    Color selectedColorOnSurface = drawerKey == currentPage
        ? Theme.of(context).colorScheme.onInverseSurface
        : Theme.of(context).colorScheme.onSurface;
    Color selectedColorSurface = drawerKey == currentPage
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.surfaceVariant;
    return CardListTile(
      title: title,
      titleColor: selectedColorOnSurface,
      elevation: 0,
      listTileColor: selectedColorSurface,
      style: ListTileStyle.drawer,
      onTap: () {
        ToolBoxNavigator.pop(context);
        if (currentPage == drawerKey) {
          return;
        } else {
          ToolBoxNavigator.push(context, page);
        }
      },
      leading: Icon(
        icon,
        color: selectedColorOnSurface,
      ),
    );
  }
}
