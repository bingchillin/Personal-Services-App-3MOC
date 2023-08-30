import 'package:flutter/material.dart';
import 'package:goldie_studio/pages/type/add_type.dart';
import 'package:goldie_studio/webservices/type/type_class.dart';
import 'package:goldie_studio/webservices/type/type_webservices.dart';

import '../../widgets/title.dart';

class TypesWidget extends StatelessWidget {
  const TypesWidget({Key? key}) : super(key: key);

  static const String routeName = '/types';

  @override
  Widget build(BuildContext context) {
    return const TypesFutureBuilder();
  }
}

class TypesFutureBuilder extends StatefulWidget {
  const TypesFutureBuilder({Key? key}) : super(key: key);

  @override
  State<TypesFutureBuilder> createState() => _TypesFutureBuilderState();
}

class _TypesFutureBuilderState extends State<TypesFutureBuilder> {
  List<Types> _types = [];
  List<Types> _filteredTypes = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTypes();
  }

  void _loadTypes() {
    TypesWebServices.getAllTypes().then((types) {
      setState(() {
        _types = types;
        _filteredTypes = types;
      });
    }).catchError((error) {
      // Gérer les erreurs lors du chargement des types depuis l'API
      debugPrint('Error loading types: $error');
    });
  }

  void _updateFilteredTypes(String searchText) {
    setState(() {
      _filteredTypes = _types
          .where((type) =>
          type.name.toLowerCase().contains(searchText.toLowerCase()))
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
            onChanged: _updateFilteredTypes,
            decoration: const InputDecoration(
              labelText: 'Rechercher par nom',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: _loadTypes,
                icon: const Icon(Icons.refresh),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TypeAddWidget(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTypes.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const ListTile(
                    title: Row(
                      children: [
                        Expanded(child: TitleWidget(title: 'ID')),
                        Spacer(),
                        Expanded(child: TitleWidget(title: 'Nom')),
                      ],
                    ),
                  );
                }
                final type = _filteredTypes[index - 1];
                return Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        Expanded(child: Text('${type.id}')),
                        const Spacer(),
                        Expanded(child: Text(type.name)),
                        const Spacer(),
                        ButtonBar(
                          children: [
                            IconButton(
                              onPressed: () {
                                /*Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditTypeWidget(type: type)
                                  ),
                                );*/
                              },
                              icon: const Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                            IconButton(
                              onPressed: () async {
                                bool deleted = await TypesWebServices.deleteTypes(type.id);
                                if (deleted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Type supprimé'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                                _loadTypes();
                              },
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
