import 'package:flutter/material.dart';
import 'package:toolbox/enums/drawer_itens.dart';
import 'package:toolbox/pages/bitcoin/show_bitcoin_prices.dart';
import 'package:toolbox/pages/home_page.dart';
import 'package:toolbox/pages/quotes/show_quotes.dart';
import 'package:toolbox/widgets/components/drawer_list_tile.dart';

class DrawerView extends StatelessWidget {
  final DrawerKeys currentPage;

  const DrawerView({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Toolbox',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Seu app de ferramentas!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerListTile(
                    currentPage: currentPage,
                    title: 'Página Inicial',
                    drawerKey: DrawerKeys.home,
                    icon: Icons.home,
                    page: const HomePage(),
                  ),
                  DrawerListTile(
                    currentPage: currentPage,
                    title: 'Preço do Bitcoin',
                    drawerKey: DrawerKeys.bitcoin,
                    icon: Icons.monetization_on,
                    page: const ShowBitcoinPrices(),
                  ),
                  DrawerListTile(
                    currentPage: currentPage,
                    title: 'Citações',
                    drawerKey: DrawerKeys.quotes,
                    icon: Icons.chat,
                    page: const ShowDailyQuotes(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
