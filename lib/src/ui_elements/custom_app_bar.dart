import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key,
    required this.title,
  });

  @override
  Size get preferredSize => const Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,

      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 255, 255)),
      ),   // text on top bar

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 7),
          child: IconButton(
            icon: const Icon(Icons.dark_mode),
            onPressed: () {
              context.read<AppTheme>().switchTheme();
            },
          ),
        )
      ],
    );
  }
}