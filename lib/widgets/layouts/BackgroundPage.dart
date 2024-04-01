// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:toolbox/enums/DrawerItens.dart';
import 'package:toolbox/widgets/layouts/DrawerBase.dart';

class BackgroundPage extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final DrawerItens currentPage;

  const BackgroundPage({
    super.key,
    required this.title,
    required this.children,
    required this.currentPage,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
  });

  @override
  State<BackgroundPage> createState() => _BackgroundPageState();
}

class _BackgroundPageState extends State<BackgroundPage> {
  String get title => widget.title;
  List<Widget> get children => widget.children;
  CrossAxisAlignment get crossAxisAlignment => widget.crossAxisAlignment;
  MainAxisAlignment get mainAxisAlignment => widget.mainAxisAlignment;
  MainAxisSize get mainAxisSize => widget.mainAxisSize;
  DrawerItens get currentPage => widget.currentPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      drawer: DrawerBase(currentPage: currentPage),
      body: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          20,
          20,
          20 + MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          children: children,
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        tooltip: 'Increment',
        label: const Text('Increment'),
        icon: const Icon(Icons.add),
        isExtended: false,
        onPressed: () {},
      ),
    );
  }
}
