import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key,
    required this.title,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  
  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    IconData icon = AppTheme.getIcon();
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,

      centerTitle: true,
      title: Text(
        widget.title,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 7),
          child: IconButton(
            icon: Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            onPressed: () {
              context.read<AppTheme>().switchTheme();
            },
          ),
        )
      ],
    );
  }
}