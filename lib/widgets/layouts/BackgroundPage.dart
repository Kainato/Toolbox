import 'package:flutter/material.dart';
import 'package:toolbox/classes/ToolBoxNavigator.dart';
import 'package:toolbox/enums/DrawerItens.dart';
import 'package:toolbox/widgets/layouts/DrawerBase.dart';

class BackgroundPage extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final DrawerItens? currentPage;
  final void Function()? onFABPressed;
  final String fabTooltip;
  final IconData? fabIcon;

  const BackgroundPage({
    super.key,
    required this.title,
    required this.children,
    this.currentPage,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.onFABPressed,
    this.fabTooltip = '',
    this.fabIcon,
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
  DrawerItens? get currentPage => widget.currentPage;
  void Function()? get onFABPressed => widget.onFABPressed;
  String get fabTooltip => widget.fabTooltip;
  IconData get fabIcon => widget.fabIcon ?? Icons.add;

  @override
  Widget build(BuildContext context) {
    bool hasDrawer = currentPage != null;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Text(
          title,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
        ),
        leading: !hasDrawer
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => ToolBoxNavigator.pop(context),
              )
            : null,
        actionsIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      drawerScrimColor: Theme.of(context).colorScheme.primary.withOpacity(0.25),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: hasDrawer
          ? DrawerBase(
              currentPage: currentPage!,
            )
          : null,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            20,
            20,
            20,
            8 + MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            mainAxisAlignment: mainAxisAlignment,
            mainAxisSize: mainAxisSize,
            children: children,
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: onFABPressed != null,
        child: FloatingActionButton(
          tooltip: fabTooltip,
          onPressed: onFABPressed,
          child: Icon(fabIcon),
        ),
      ),
    );
  }
}
