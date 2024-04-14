import 'package:flutter/material.dart';
import 'package:toolbox/classes/ToolBoxNavigator.dart';
import 'package:toolbox/enums/DrawerItens.dart';
import 'package:toolbox/pages/bitcoin_prices.dart';
import 'package:toolbox/pages/Phrases/daily_phrases_page.dart';
import 'package:toolbox/pages/home_page.dart';
import 'package:toolbox/widgets/components/DrawerListTile.dart';

class DrawerBase extends StatelessWidget {
  final DrawerItens currentPage;

  const DrawerBase({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              'Drawer Header',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          DrawerListTile(
            pageFromDrawer: currentPage,
            drawerItem: DrawerItens.home,
            title: 'Home Page',
            icon: Icons.home,
            onTap: () {
              ToolBoxNavigator.pop(context);
              if (currentPage == DrawerItens.home) {
                return;
              } else {
                ToolBoxNavigator.push(
                  context,
                  const HomePage(),
                );
              }
            },
          ),
          DrawerListTile(
            pageFromDrawer: currentPage,
            drawerItem: DrawerItens.bitcoin,
            title: 'Bitcoin Prices',
            icon: Icons.monetization_on,
            onTap: () {
              ToolBoxNavigator.pop(context);
              if (currentPage == DrawerItens.bitcoin) {
                return;
              } else {
                ToolBoxNavigator.push(
                  context,
                  const BitcoinPrices(),
                );
              }
            },
          ),
          DrawerListTile(
            pageFromDrawer: currentPage,
            drawerItem: DrawerItens.phrases,
            title: 'Daily Phrases',
            icon: Icons.article,
            onTap: () {
              ToolBoxNavigator.pop(context);
              if (currentPage == DrawerItens.phrases) {
                return;
              } else {
                ToolBoxNavigator.push(
                  context,
                  const DailyPhrasesPage(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
