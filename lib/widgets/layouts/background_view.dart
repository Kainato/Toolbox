import 'package:flutter/material.dart';
import 'package:toolbox/classes/toolbox_navigator.dart';
import 'package:toolbox/enums/drawer_itens.dart';
import 'package:toolbox/widgets/layouts/drawer_view.dart';

class BackgroundView extends StatefulWidget {
  final String title;
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final DrawerKeys? currentPage;
  final void Function()? onFABPressed;
  final String fabTooltip;
  final IconData? fabIcon;
  final List<Widget>? actions;

  const BackgroundView({
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
    this.actions,
  });

  @override
  State<BackgroundView> createState() => _BackgroundViewState();
}

class _BackgroundViewState extends State<BackgroundView> {
  String get title => widget.title;
  List<Widget> get children => widget.children;
  CrossAxisAlignment get crossAxisAlignment => widget.crossAxisAlignment;
  MainAxisAlignment get mainAxisAlignment => widget.mainAxisAlignment;
  MainAxisSize get mainAxisSize => widget.mainAxisSize;
  DrawerKeys? get currentPage => widget.currentPage;
  void Function()? get onFABPressed => widget.onFABPressed;
  String get fabTooltip => widget.fabTooltip;
  List<Widget>? get actions => widget.actions;
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
        actions: actions,
        actionsIconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      resizeToAvoidBottomInset: true,
      drawerScrimColor: Theme.of(context).colorScheme.primary.withOpacity(0.25),
      backgroundColor: Theme.of(context).colorScheme.background,
      drawer: hasDrawer
          ? DrawerView(
              currentPage: currentPage!,
            )
          : null,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
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
