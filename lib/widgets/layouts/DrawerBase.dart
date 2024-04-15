import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toolbox/classes/ToolBoxNavigator.dart';
import 'package:toolbox/enums/DrawerItens.dart';
import 'package:toolbox/pages/bitcoin_prices.dart';
import 'package:toolbox/pages/Phrases/daily_quotes_page.dart';
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
      backgroundColor: Theme.of(context).colorScheme.background,
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
                'ToolBox',
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
                    pageFromDrawer: currentPage,
                    drawerItem: DrawerItens.home,
                    title: 'Página Inicial',
                    icon: Icons.home,
                    onTap: () {
                      ToolBoxNavigator.pop(context);
                      if (currentPage == DrawerItens.home) {
                        return;
                      } else {
                        ToolBoxNavigator.pushAndRemoveUntil(
                          context,
                          const HomePage(),
                        );
                      }
                    },
                  ),
                  DrawerListTile(
                    pageFromDrawer: currentPage,
                    drawerItem: DrawerItens.bitcoin,
                    title: 'Preço do Bitcoin',
                    icon: Icons.monetization_on,
                    onTap: () {
                      ToolBoxNavigator.pop(context);
                      if (currentPage == DrawerItens.bitcoin) {
                        return;
                      } else {
                        ToolBoxNavigator.push(
                          context,
                          const BitcoinPricesPage(),
                        );
                      }
                    },
                  ),
                  DrawerListTile(
                    pageFromDrawer: currentPage,
                    drawerItem: DrawerItens.phrases,
                    title: 'Frases do Dia',
                    icon: Icons.chat,
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
            ),
          ),
        ],
      ),
    );
  }
}
