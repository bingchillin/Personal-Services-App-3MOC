import 'package:flutter/material.dart';
import '../../webservices/type/type_class.dart';
import '../../webservices/type/type_webservices.dart';

class TypeAddWidget extends StatefulWidget {
  const TypeAddWidget({super.key});

  @override
  State<TypeAddWidget> createState() => _TypeAddWidgetState();
}

class _TypeAddWidgetState extends State<TypeAddWidget> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un type'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nom du type'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final typeName = _nameController.text;

                final newType = Types(name: typeName);

                await TypesWebServices.addTypes(newType);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Type ajouté'),
                    backgroundColor: Colors.green,
                  ),
                );

                Navigator.pop(context);
              },
              child: const Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }
}
