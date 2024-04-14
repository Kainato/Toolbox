import 'package:flutter/material.dart';
import 'package:toolbox/classes/ToolBoxNavigator.dart';
import 'package:toolbox/enums/DrawerItens.dart';
import 'package:toolbox/pages/Phrases/daily_phrases_page.dart';
import 'package:toolbox/pages/bitcoin_prices.dart';
import 'package:toolbox/widgets/components/CardGridTile.dart';
import 'package:toolbox/widgets/layouts/BackgroundPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      currentPage: DrawerItens.home,
      title: 'Home Page',
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              _gridItensBase(
                context,
                title: 'Preço do Bitcoin',
                icon: Icons.monetization_on_rounded,
                page: const BitcoinPricesPage(),
              ),
              _gridItensBase(
                context,
                title: 'Frases do Dia',
                icon: Icons.chat,
                page: const DailyPhrasesPage(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _gridItensBase(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget page,
  }) {
    return CardGridTile(
      gridColor: Theme.of(context).colorScheme.primary,
      footer: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Theme.of(context).colorScheme.onInverseSurface,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      child: Icon(
        icon,
        color: Theme.of(context).colorScheme.onInverseSurface,
        size: 48,
      ),
      onTap: () => ToolBoxNavigator.push(context, page),
    );
  }
}
