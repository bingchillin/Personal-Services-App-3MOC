import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user_class.dart';

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
              onPressed: () {
                // TODO: Ajouter la logique de mise à jour des informations de l'utilisateur
              },
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
