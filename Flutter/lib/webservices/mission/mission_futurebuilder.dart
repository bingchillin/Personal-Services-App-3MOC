import 'package:flutter/material.dart';
import '../../widgets/title.dart';

class MissionsWidget extends StatelessWidget {
  const MissionsWidget({super.key});

  static const String routeName = '/missions';

  @override
  Widget build(BuildContext context) {
    return const MissionFutureBuilder();
  }
}

class MissionFutureBuilder extends StatefulWidget {
  const MissionFutureBuilder({super.key});

  @override
  State<MissionFutureBuilder> createState() => _MissionFutureBuilderState();
}

class _MissionFutureBuilderState extends State<MissionFutureBuilder> {
  List<Mission> _missions = [];
  List<Mission> _filteredMissions = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMissions();
  }

  void _loadMissions() {
    // Ici, vous pouvez charger vos missions statiques ou supprimer complètement cette méthode
    // et initialiser _missions directement avec vos données statiques
    _missions = [
      Mission(id: 1, title: 'Mission 1', description: 'Description mission 1', date: '2023-07-15'),
      Mission(id: 2, title: 'Mission 2', description: 'Description mission 2', date: '2023-07-16'),
      Mission(id: 3, title: 'Mission 3', description: 'Description mission 3', date: '2023-07-17'),
      // Ajoutez vos autres missions statiques ici
    ];
    _filteredMissions = _missions;
  }

  void _updateFilteredMissions(String searchText) {
    setState(() {
      _filteredMissions = _missions
          .where((mission) =>
          mission.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: _updateFilteredMissions,
            decoration: const InputDecoration(
              labelText: 'Rechercher une mission',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  _loadMissions();
                },
                icon: const Icon(Icons.refresh),
              ),
              IconButton(
                onPressed: () {
                  // Code pour ajouter une nouvelle mission
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredMissions.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const ListTile(
                    title: Row(
                      children: [
                        Expanded(child: TitleWidget(title: 'ID')),
                        Spacer(),
                        Expanded(child: TitleWidget(title: 'Titre')),
                        Spacer(),
                        Expanded(child: TitleWidget(title: 'Description')),
                        Spacer(),
                        Expanded(child: TitleWidget(title: 'Date')),
                        Spacer(),
                      ],
                    ),
                  );
                }
                final mission = _filteredMissions[index - 1];
                return Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        Expanded(child: Text('${mission.id}')),
                        const Spacer(),
                        Expanded(child: Text(mission.title)),
                        const Spacer(),
                        Expanded(child: Text(mission.description)),
                        const Spacer(),
                        Expanded(child: Text(mission.date)),
                        ButtonBar(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Mission {
  final int id;
  final String title;
  final String description;
  final String date;

  Mission({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });
}
