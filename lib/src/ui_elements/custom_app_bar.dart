import 'package:flutter/material.dart';
import 'package:imposter_party_game/src/ui_elements/custom_text.dart';
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
    IconData icon = AppTheme.icon;
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.primary,
      iconTheme: IconThemeData(
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      centerTitle: true,
      title: Text(
        widget.title,
        style: AppTextStyles.appBar(context),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 7),
          child: IconButton(
            icon: Icon(
              icon,
              color: Theme.of(context).colorScheme.onPrimary,
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