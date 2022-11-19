import 'package:flutter/material.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    bool positive = false;
    int value = 0;
    return Drawer(
        child: ToggleButtons(
      children: [],
      isSelected: [],
    ));
  }
}
