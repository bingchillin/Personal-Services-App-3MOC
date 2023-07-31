import 'package:flutter/material.dart';

class NavigationRailWidget extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const NavigationRailWidget({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      labelType: NavigationRailLabelType.all,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      selectedIconTheme: Theme.of(context).iconTheme,
      unselectedIconTheme: Theme.of(context).iconTheme,
      unselectedLabelTextStyle:
          Theme.of(context).textTheme.titleSmall?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
      elevation: 5,
      useIndicator: true,
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Accueil'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person_2_outlined),
          selectedIcon: Icon(Icons.person_2_outlined),
          label: Text('Utilisateurs'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.help_center_outlined),
          selectedIcon: Icon(Icons.help_center_outlined),
          label: Text('Requêtes'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.request_page_outlined),
          selectedIcon: Icon(Icons.request_page_outlined),
          label: Text('Missions'),
        )
      ],
    );
  }
}
