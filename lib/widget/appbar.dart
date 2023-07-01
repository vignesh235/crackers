import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String tittle;
  final List<Widget> actions;
  final Widget? leading;

  const MyAppBar({
    Key? key,
    this.actions = const [],
    required this.tittle,
    this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xff4d4d4d),
      centerTitle: true,
      title: Text(
        tittle,
        // style: ThemeText.progressHeader,
      ),
      actions: actions,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
