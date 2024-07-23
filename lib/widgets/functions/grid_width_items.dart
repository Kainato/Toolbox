import 'package:flutter/material.dart';

/// Retorna a quantidade de itens que cabem na largura da tela se baseando
/// no tamanho vertical dos widgets filhos do `GridView`.
int gridWidthItems(BuildContext context, {int widthWidget = 400}) {
  if ((MediaQuery.of(context).size.width ~/ widthWidget).toInt() < 1) {
    return 1;
  } else {
    return (MediaQuery.of(context).size.width ~/ widthWidget).toInt();
  }
}
