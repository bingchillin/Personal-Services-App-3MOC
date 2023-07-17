import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user/user_class.dart';
import 'package:goldie_studio/webservices/user/user_webservices.dart';

class AddUserWidget extends StatefulWidget {
  const AddUserWidget({Key? key}) : super(key: key);

  @override
  _AddUserWidgetState createState() => _AddUserWidgetState();
}

class _AddUserWidgetState extends State<AddUserWidget> {
  late List<Map<String, String>> _fieldList;
  late List<TextEditingController> _textControllers;

  @override
  void initState() {
    super.initState();
    _fieldList = [
      {'Prénom': ''},
      {'Nom': ''},
      {'Email': ''},
      {'Date de naissance': ''},
      {'Profession': ''},
      {'Rôle': ''},
      {'Mot de passe': ''},
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
                final newUser = User(
                  firstname: _textControllers[0].text,
                  lastname: _textControllers[1].text,
                  email: _textControllers[2].text,
                  birthdate: _textControllers[3].text,
                  profession: int.tryParse(_textControllers[4].text),
                  role: int.tryParse(_textControllers[5].text),
                  password: _textControllers[6].text,
                );

                await UserWebServices.createUser(newUser);

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
