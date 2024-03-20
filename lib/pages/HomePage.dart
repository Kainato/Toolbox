import 'package:flutter/material.dart';
import 'package:toolbox/widgets/BackgroundPage.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const BackgroundPage(
      title: 'Home Page',
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Hello World'),
        Divider(),
      ],
    );
  }
}
