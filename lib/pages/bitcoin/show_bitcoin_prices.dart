import 'package:flutter/material.dart';
import 'package:Toolbox/classes/Models/bitcoin_model.dart';
import 'package:Toolbox/enums/drawer_itens.dart';
import 'package:Toolbox/widgets/components/transparent_divider.dart';
import 'package:Toolbox/widgets/layouts/background_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ShowBitcoinPrices extends StatefulWidget {
  const ShowBitcoinPrices({super.key});

  @override
  State<ShowBitcoinPrices> createState() => _ShowBitcoinPricesState();
}

class _ShowBitcoinPricesState extends State<ShowBitcoinPrices> {
  String _preco = '0.00';

  _recuperarPreco() async {
    // ROTA DE REQUISIÇÃO
    String url = 'https://blockchain.info/ticker';
    setState(() => _preco = '...');

    // REQUISIÇÃO
    // O GET VAI FAZER A CONSULTA NA WEB E PODE ACABAR DEMORANDO UM POUCO
    Future.delayed(
      const Duration(milliseconds: 500),
      () async {
        try {
          http.Response response = await http.get(Uri.parse(url));

          // RECUPERAR DADOS
          // O JSON DECODER VAI CONVERTER O JSON PARA UM MAPA
          Map<String, dynamic> retorno = json.decode(response.body);

          setState(() {
            // RECUPERAR O PREÇO DO BITCOIN
            BitcoinModel bitcoinModel = BitcoinModel.fromJson(retorno);
            _preco = bitcoinModel.brl['buy'].toString();
          });
        } catch (e) {
          setState(() => _preco = 'Erro ao carregar os dados!');
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _recuperarPreco();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundView(
      currentPage: DrawerKeys.bitcoin,
      title: 'Preço do Bitcoin',
      fabIcon: Icons.refresh,
      fabTooltip: 'Atualizar Preço',
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Preço de compra do Bitcoin em Reais',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const TransparentDivider(),
        Text(
          'R\$ $_preco',
          style: const TextStyle(
            fontSize: 24,
          ),
          textAlign: TextAlign.center,
        ),
      ],
      onFABPressed: () => _recuperarPreco(),
    );
  }
}
