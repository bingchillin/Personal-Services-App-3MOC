import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goldie_studio/webservices/user/user_class.dart';
import '../../webservices/user/user_webservices.dart';

class UserDetailsWidget extends StatefulWidget {
  final User user;

  const UserDetailsWidget({Key? key, required this.user}) : super(key: key);

  @override
  _UserDetailsWidgetState createState() => _UserDetailsWidgetState();
}

class _UserDetailsWidgetState extends State<UserDetailsWidget> {
  late List<Map<String, String>> _fieldList;
  late List<TextEditingController> _textControllers;
  bool _isMale = false; // État de la case à cocher "Male"
  bool _isFemale = false; // État de la case à cocher "Female"

  @override
  void initState() {
    super.initState();
    _fieldList = [
      {'Prénom': widget.user.firstname ?? ''},
      {'Nom': widget.user.lastname ?? ''},
      {'Sexe': widget.user.sexe ?? ''},
      {'Email': widget.user.email},
      {
        'Date de naissance (AAAA/MM/JJ)':
            convertDate(widget.user.birthdate) ?? ''
      },
      {'Validé': widget.user.validated?.toString() ?? ''},
      {'Note': widget.user.note?.toString() ?? ''},
      {'Profession': widget.user.profession?.toString() ?? ''},
      {'Rôle': widget.user.role?.toString() ?? ''},
      {'Password': widget.user.password.toString()},
      {'Date inscription': convertDate(widget.user.dateSignIn) ?? ''},
    ];

    _textControllers = _fieldList
        .map((field) => TextEditingController(text: field.values.first))
        .toList();

    // Définir les états des cases à cocher en fonction du sexe de l'utilisateur
    _isMale = widget.user.sexe == 'male';
    _isFemale = widget.user.sexe == 'female';
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
              _fieldList[i].keys.first == 'Date inscription' ||
                      _fieldList[i].keys.first == "Password"
                  ? TextFormField(
                      controller: _textControllers[i],
                      decoration: InputDecoration(
                        labelText: _fieldList[i].keys.first,
                      ),
                      enabled: false,
                    )
                  : _fieldList[i].keys.first == 'Rôle' ||
                          _fieldList[i].keys.first == 'Profession' ||
                          _fieldList[i].keys.first == 'Sexe'
                      ? Row(
                          children: [
                            Expanded(
                              child: _fieldList[i].keys.first == 'Sexe'
                                  ? Row(
                                      children: [
                                        Checkbox(
                                          value: _isMale,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _isMale = newValue ?? false;
                                              _isFemale = !_isMale;
                                            });
                                          },
                                        ),
                                        Text('Male'),
                                        Checkbox(
                                          value: _isFemale,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _isFemale = newValue ?? false;
                                              _isMale = !_isFemale;
                                            });
                                          },
                                        ),
                                        Text('Female'),
                                      ],
                                    )
                                  : TextField(
                                      controller: _textControllers[i],
                                      decoration: InputDecoration(
                                        labelText: _fieldList[i].keys.first,
                                      ),
                                    ),
                            ),
                            if (_fieldList[i].keys.first == 'Profession')
                              const Tooltip(
                                message:
                                    '0 pour bénévole \n1 pour assistant médical \n2 pour autre',
                                child: Icon(Icons.help_outline),
                              ),
                            if (_fieldList[i].keys.first == 'Rôle')
                              const Tooltip(
                                message: '0 pour utilisateur \n1 pour admin',
                                child: Icon(Icons.help_outline),
                              ),
                          ],
                        )
                      : TextField(
                          controller: _textControllers[i],
                          inputFormatters:
                              _getInputFormatters(_fieldList[i].keys.first),
                          // Utiliser les inputFormatters pour restreindre les champs aux nombres
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
                  sexe: _isMale ? 'male' : 'female',
                  email: _textControllers[3].text,
                  birthdate: convertDateBack(_textControllers[4].text),
                  validated: int.tryParse(_textControllers[5].text),
                  note: double.tryParse(_textControllers[6].text),
                  profession: int.tryParse(_textControllers[7].text),
                  role: int.tryParse(_textControllers[8].text),
                  password: _textControllers[9].text,
                  dateSignIn: convertDateBack(_textControllers[10].text),
                );

                await UserWebServices.updateUser(updatedUser);

                // Afficher une snackbar ou une boîte de dialogue pour confirmer la mise à jour
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Utilisateur mis à jour'),
                    backgroundColor: Colors.blue,
                  ),
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

  List<TextInputFormatter> _getInputFormatters(String fieldName) {
    if (fieldName == 'Validé' ||
        fieldName == 'Note' ||
        fieldName == 'Profession' ||
        fieldName == 'Rôle') {
      return [FilteringTextInputFormatter.digitsOnly];
    }
    return [];
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
