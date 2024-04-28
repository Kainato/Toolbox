import 'package:flutter/material.dart';

class TransparentDivider extends StatelessWidget {
  /// A extensão da altura do [Divider].
  /// ### Parâmetros:
  /// * Se também for nulo, o padrão será 16.0.
  final double? height;

  /// Cria um [Divider] transparente com a extensão da altura especificada.
  /// ### Parâmetros:
  /// * [key] é a chave para o [Divider].
  /// * [height] é a extensão da altura do [Divider].
  const TransparentDivider({super.key, this.height});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Colors.transparent,
      height: height,
    );
  }
}
