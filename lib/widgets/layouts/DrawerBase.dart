// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:toolbox/classes/DrawerItens.dart';
import 'package:toolbox/pages/DailyPhrasesPage.dart';
import 'package:toolbox/pages/HomePage.dart';
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
              Navigator.pop(context);
              if (currentPage == DrawerItens.home) {
                return;
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomePage(),
                  ),
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
              Navigator.pop(context);
              if (currentPage == DrawerItens.phrases) {
                return;
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const DailyPhrasesPage(),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
