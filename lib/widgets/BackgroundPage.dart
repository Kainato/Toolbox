import 'package:flutter/material.dart';

class BackgroundPage extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;

  const BackgroundPage({
    super.key,
    required this.title,
    required this.children,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        children: children,
      ),
    );
  }
}
