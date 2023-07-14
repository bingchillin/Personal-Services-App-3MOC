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
                leading: const Icon(Icons.home),
                iconColor: Colors.white,
                title: const Text('Accueil'),
                onTap: () {
                  Navigator.pop(context);
                  //Navigator.pushNamed(context, '/');
                },
              ),
              ListTile(
                leading: const Icon(Icons.person_2_rounded),
                iconColor: Colors.white,
                title: const Text('Profil'),
                onTap: () {
                  Navigator.pop(context);
                  //Navigator.pushNamed(context, '/favorites');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                iconColor: Colors.white,
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
