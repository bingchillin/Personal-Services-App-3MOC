import 'package:flutter/material.dart';

class TopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const TopBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Goldie STUDIO'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}