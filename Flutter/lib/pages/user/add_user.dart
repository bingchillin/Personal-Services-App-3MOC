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
  bool _isMale = false;
  bool _isFemale = false;

  @override
  void initState() {
    super.initState();
    _fieldList = [
      {'Prénom': ''},
      {'Nom': ''},
      {'Sexe': ''},
      {'Email': ''},
      {'Date de naissance (AAAA/MM/JJ)': ''},
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
              _fieldList[i].keys.first == 'Sexe'
                  ? Row(
                children: [
                  Checkbox(
                    value: _isMale,
                    onChanged: (newValue) {
                      setState(() {
                        _isMale = newValue ?? false;
                        if (_isMale) _isFemale = false;
                      });
                    },
                  ),
                  Text('Homme'),
                  Checkbox(
                    value: _isFemale,
                    onChanged: (newValue) {
                      setState(() {
                        _isFemale = newValue ?? false;
                        if (_isFemale) _isMale = false;
                      });
                    },
                  ),
                  Text('Femme'),
                ],
              )
                  : TextField(
                controller: _textControllers[i],
                decoration: InputDecoration(
                    labelText: _fieldList[i].keys.first),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final newUser = User(
                  firstname: _textControllers[0].text,
                  lastname: _textControllers[1].text,
                  sexe: _isMale ? 'male' : (_isFemale ? 'female' : ''),
                  email: _textControllers[3].text,
                  birthdate: _textControllers[4].text,
                  password: _textControllers[5].text,
                );

                await UserWebServices.createUser(newUser);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Utilisateur créé'),
                    backgroundColor: Colors.green,
                  ),
                );

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
