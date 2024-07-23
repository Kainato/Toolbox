import 'package:flutter/material.dart';
import 'package:toolbox/enums/drawer_itens.dart';
import 'package:toolbox/pages/bitcoin/show_bitcoin_prices.dart';
import 'package:toolbox/pages/quotes/show_quotes.dart';
import 'package:toolbox/widgets/components/card_grid_tile.dart';
import 'package:toolbox/widgets/functions/grid_width_items.dart';
import 'package:toolbox/widgets/layouts/background_view.dart';
import 'package:toolbox/classes/toolbox_navigator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundView(
      currentPage: DrawerKeys.home,
      title: 'Página Inicial',
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: GridView(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridWidthItems(context),
              mainAxisExtent: 250,
            ),
            children: [
              _gridItensBase(
                context,
                title: 'Preço do Bitcoin',
                icon: Icons.monetization_on_rounded,
                page: const ShowBitcoinPrices(),
              ),
              _gridItensBase(
                context,
                title: 'Citações',
                icon: Icons.chat,
                page: const ShowDailyQuotes(),
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
