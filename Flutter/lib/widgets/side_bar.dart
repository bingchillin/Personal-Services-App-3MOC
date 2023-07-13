import 'package:flutter/material.dart';

class SideBarWidget extends StatelessWidget {
  const SideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                title: const Text('Accueil'),
                onTap: () {
                  Navigator.pop(context);
                  //Navigator.pushNamed(context, '/');
                },
              ),
              ListTile(
                title: const Text('Profil'),
                onTap: () {
                  Navigator.pop(context);
                  //Navigator.pushNamed(context, '/favorites');
                },
              ),
              ListTile(
                title: const Text('Paramètres'),
                onTap: () {},
              ),
            ],
          ),
        ),
        const Expanded(
          child: Center(
            child: Text('Contenu de l\'écran principal'),
          ),
        ),
      ],
    );
  }
}
