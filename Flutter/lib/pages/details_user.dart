import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user_class.dart';

import '../webservices/user_webservices.dart';

class UserDetailsWidget extends StatefulWidget {
  final User user;

  const UserDetailsWidget({Key? key, required this.user}) : super(key: key);

  @override
  _UserDetailsWidgetState createState() => _UserDetailsWidgetState();
}

class _UserDetailsWidgetState extends State<UserDetailsWidget> {
  late List<Map<String, String>> _fieldList;
  late List<TextEditingController> _textControllers;

  @override
  void initState() {
    super.initState();
    _fieldList = [
      {'Prénom': widget.user.firstname ?? ''},
      {'Nom': widget.user.lastname ?? ''},
      {'Email': widget.user.email ?? ''},
      {'Date de naissance': widget.user.birthdate ?? ''},
      {'Validé': widget.user.validated?.toString() ?? ''},
      {'Note': widget.user.note?.toString() ?? ''},
      {'Profession': widget.user.profession?.toString() ?? ''},
      {'Rôle': widget.user.role?.toString() ?? ''},
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
        title: Text('Détails de ${widget.user.firstname}'),
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
                final updatedUser = User(
                  id: widget.user.id,
                  firstname: _textControllers[0].text,
                  lastname: _textControllers[1].text,
                  email: _textControllers[2].text,
                  birthdate: _textControllers[3].text,
                  validated: int.tryParse(_textControllers[4].text),
                  note: double.tryParse(_textControllers[5].text),
                  profession: int.tryParse(_textControllers[6].text),
                  role: int.tryParse(_textControllers[7].text),
                );

                await UserWebServices.updateUser(updatedUser);

                // Afficher une snackbar ou une boîte de dialogue pour confirmer la mise à jour
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Utilisateur mis à jour')),
                );

                // Naviguer en arrière après la mise à jour
                Navigator.pop(context);
              },
              child: const Text('Enregistrer'),
            ),

          ],
        ),
      ),
    );
  }
}
