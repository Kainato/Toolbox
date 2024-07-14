import 'package:flutter/material.dart';

class BackgroundBlank extends StatefulWidget {
  final String title;
  final List<Widget> children;

  const BackgroundBlank({
    super.key,
    required this.title,
    required this.children,
  });

  @override
  State<BackgroundBlank> createState() => _BackgroundBlankState();
}

class _BackgroundBlankState extends State<BackgroundBlank> {
  String get title => widget.title;
  List<Widget> get children => widget.children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        actionsIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      resizeToAvoidBottomInset: true,
      drawerScrimColor: Theme.of(context).colorScheme.primary.withOpacity(0.25),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
