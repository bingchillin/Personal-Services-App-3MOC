import 'package:flutter/material.dart';

import '../webservices/request/request_class.dart';
import '../webservices/request/request_webservices.dart';

class RequestAddWidget extends StatefulWidget {
  const RequestAddWidget({super.key});

  @override
  State<RequestAddWidget> createState() => _RequestAddWidgetState();
}

class _RequestAddWidgetState extends State<RequestAddWidget> {
  late List<Map<String, String>> _fieldList;
  late List<TextEditingController> _textControllers;

  @override
  void initState() {
    super.initState();
    _fieldList = [
      {'Client': ''},
      {'Durée': ''},
      {'Type': ''},
      {'Titre': ''},
      {'Place': ''},
      {'Besoin Medical': ''},
    ];

    _textControllers = _fieldList
        .map((field) => TextEditingController(text: field.values.first))
        .toList();
  }

  @override
  void dispose() {
    for (var controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un utilisateur'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (var i = 0; i < _fieldList.length; i++)
              TextField(
                controller: _textControllers[i],
                decoration: InputDecoration(labelText: _fieldList[i].keys.first),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final newRequest = Request(
                  client: int.tryParse(_textControllers[0].text),
                  timer: _textControllers[1].text,
                  type: int.tryParse(_textControllers[2].text),
                  title: _textControllers[3].text,
                  slots: int.tryParse(_textControllers[4].text),
                  medicalNeed: int.tryParse(_textControllers[5].text),
                );

                await RequestWebServices.createRequest(newRequest);

                // Afficher une snackbar ou une boîte de dialogue pour confirmer la création
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Utilisateur créé')),
                );

                // Naviguer en arrière après la création
                Navigator.pop(context);
              },
              child: const Text('Créer'),
            ),
          ],
        ),
      ),
    );
  }
}
