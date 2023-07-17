import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user/user_class.dart';
import '../webservices/user/user_webservices.dart';

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
      {'Date de naissance': convertDate(widget.user.birthdate) ?? ''},
      {'Validé': widget.user.validated?.toString() ?? ''},
      {'Note': widget.user.note?.toString() ?? ''},
      {'Profession': widget.user.profession?.toString() ?? ''},
      {'Rôle': widget.user.role?.toString() ?? ''},
      {'Password': widget.user.password?.toString() ?? ''},
      {'Date inscription': convertDate(widget.user.dateSignIn) ?? ''},
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
              _fieldList[i].keys.first == 'Date inscription'
                  ? TextFormField(
                controller: _textControllers[i],
                decoration: InputDecoration(
                  labelText: _fieldList[i].keys.first,
                ),
                enabled: false,
              )
                  : TextField(
                controller: _textControllers[i],
                decoration: InputDecoration(
                  labelText: _fieldList[i].keys.first,
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final updatedUser = User(
                  id: widget.user.id,
                  firstname: _textControllers[0].text,
                  lastname: _textControllers[1].text,
                  email: _textControllers[2].text,
                  birthdate: convertDateBack(_textControllers[3].text),
                  validated: int.tryParse(_textControllers[4].text),
                  note: double.tryParse(_textControllers[5].text),
                  profession: int.tryParse(_textControllers[6].text),
                  role: int.tryParse(_textControllers[7].text),
                  password: _textControllers[8].text,
                  dateSignIn: convertDateBack(_textControllers[9].text),
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

  String? convertDate(String? dateString) {
    if (dateString != null && dateString.isNotEmpty) {
      DateTime dateTime = DateTime.parse(dateString);
      String formattedDate =
          '${dateTime.year}-${_twoDigits(dateTime.month)}-${_twoDigits(dateTime.day)}';
      return formattedDate;
    }
    return null;
  }

  String _twoDigits(int n) {
    if (n >= 10) return '$n';
    return '0$n';
  }

  String? convertDateBack(String? dateString) {
    if (dateString != null && dateString.isNotEmpty) {
      List<String> parts = dateString.split('-');
      if (parts.length == 3) {
        int year = int.tryParse(parts[0]) ?? 0;
        int month = int.tryParse(parts[1]) ?? 0;
        int day = int.tryParse(parts[2]) ?? 0;

        if (year != 0 && month != 0 && day != 0) {
          DateTime dateTime = DateTime(year, month, day);
          return dateTime.toIso8601String();
        }
      }
    }
    return null;
  }
}
