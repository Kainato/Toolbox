import 'package:flutter/material.dart';
import 'package:toolbox/enums/DrawerItens.dart';
import 'package:toolbox/widgets/components/TransparentDivider.dart';
import 'package:toolbox/widgets/layouts/BackgroundPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackgroundPage(
      currentPage: DrawerItens.home,
      title: 'Home Page',
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Hello World',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        TransparentDivider(),
      ],
    );
  }
}
