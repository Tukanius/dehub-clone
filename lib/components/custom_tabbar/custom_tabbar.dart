import 'package:flutter/material.dart';

class CustomTabbar extends StatefulWidget with PreferredSizeWidget {
  final TabController tabController;
  const CustomTabbar({
    required this.tabController,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTabbar> createState() => _CustomTabbarState();

  @override
  Size get preferredSize => const Size.fromHeight(60);
}

class _CustomTabbarState extends State<CustomTabbar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
