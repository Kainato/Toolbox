import 'package:flutter/material.dart';
import 'package:toolbox/classes/Models/BitcoinModel.dart';
import 'package:toolbox/enums/DrawerItens.dart';
import 'package:toolbox/widgets/components/TransparentDivider.dart';
import 'package:toolbox/widgets/layouts/BackgroundPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BitcoinPrices extends StatefulWidget {
  const BitcoinPrices({super.key});

  @override
  State<BitcoinPrices> createState() => _BitcoinPricesState();
}

class _BitcoinPricesState extends State<BitcoinPrices> {
  String _preco = '0.00';

  _recuperarPreco() async {
    // ROTA DE REQUISIÇÃO
    String url = 'https://blockchain.info/ticker';
    _preco = 'Carregando...';

    // REQUISIÇÃO
    // O GET VAI FAZER A CONSULTA NA WEB E PODE ACABAR DEMORANDO UM POUCO
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
      setState(() {
        _preco = 'Erro ao carregar os dados!';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _recuperarPreco();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      currentPage: DrawerItens.bitcoin,
      title: 'Bitcoin API',
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          'Preço de compra do Bitcoin em Reais',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const TransparentDivider(),
        Text(
          'R\$ $_preco',
          style: const TextStyle(
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
