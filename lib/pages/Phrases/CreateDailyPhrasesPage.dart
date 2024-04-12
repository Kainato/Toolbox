// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:toolbox/widgets/layouts/BackgroundPage.dart';

class CreateDailyPhrasesPage extends StatelessWidget {
  const CreateDailyPhrasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      title: 'Create Phrase',
      children: [
        TextFormField(),
      ],
    );
  }
}
