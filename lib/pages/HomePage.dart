// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:toolbox/classes/DrawerItens.dart';
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
        ),
      ],
    );
  }
}
