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
      {'Date de naissance (AAAA/MM/JJ)': ''},
      {'Email': ''},
      {'Mot de passe': ''},
      {'Profession': ''},
      {'Rôle': ''}
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
                        const Text('Homme'),
                        Checkbox(
                          value: _isFemale,
                          onChanged: (newValue) {
                            setState(() {
                              _isFemale = newValue ?? false;
                              if (_isFemale) _isMale = false;
                            });
                          },
                        ),
                        const Text('Femme'),
                      ],
                    )
                  : TextField(
                      controller: _textControllers[i],
                      decoration: InputDecoration(
                        labelText: _fieldList[i].keys.first,
                        suffixIcon: _fieldList[i].keys.first == 'Profession'
                            ? const Tooltip(
                                message:
                                    '0 pour bénévole\n1 pour assistant médical\n2 pour autre',
                                child: Icon(Icons.help_outline),
                              )
                            : _fieldList[i].keys.first == 'Rôle'
                                ? const Tooltip(
                                    message: '0 pour utilisateur\n1 pour admin',
                                    child: Icon(Icons.help_outline),
                                  )
                                : null,
                      ),
                    ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final newUser = User(
                  firstname: _textControllers[0].text,
                  lastname: _textControllers[1].text,
                  sexe: _isMale ? 'male' : (_isFemale ? 'female' : ''),
                  birthdate: _textControllers[3].text,
                  email: _textControllers[4].text,
                  password: _textControllers[5].text,
                  profession: int.tryParse(_textControllers[6].text),
                  role: int.tryParse(_textControllers[7].text),
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
