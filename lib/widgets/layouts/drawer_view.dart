import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toolbox/enums/drawer_itens.dart';
import 'package:toolbox/pages/bitcoin/show_bitcoin_prices.dart';
import 'package:toolbox/pages/home_page.dart';
import 'package:toolbox/pages/quotes/show_quotes.dart';
import 'package:toolbox/services/auth_service.dart';
import 'package:toolbox/widgets/components/card_list_tile.dart';
import 'package:toolbox/widgets/components/drawer_list_tile.dart';
import 'package:toolbox/widgets/layouts/dialog_view.dart';

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
                  Divider(color: Theme.of(context).colorScheme.onSurface),
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
                  Divider(color: Theme.of(context).colorScheme.onSurface),
                  CardListTile(
                    style: ListTileStyle.drawer,
                    title: 'Sair',
                    elevation: 0,
                    listTileColor:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    leading: const Icon(Icons.logout),
                    onTap: () => _confirmLogout(context),
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

void _confirmLogout(BuildContext context) {
  // Função para exibir um diálogo de confirmação de logout
  showDialog(
    context: context,
    builder: (context) => DialogView(
      title: 'Aviso!',
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            _logout(context);
          },
          child: const Text('Sim, sair'),
        ),
      ],
      children: const [
        Text('Deseja realmente se desconectar e voltar para a tela de login?')
      ],
    ),
  );
}

void _logout(BuildContext context) async {
  try {
    await context.read<AuthService>().logout(context);
  } on AuthException catch (e) {
    // Exibir mensagem de erro
    context.mounted
        ? ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.message),
            ),
          )
        : null;
  }
}
