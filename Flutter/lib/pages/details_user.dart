import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user_class.dart';

class UserDetailsWidget extends StatelessWidget {
  final User user;

  const UserDetailsWidget({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de ${user.firstname}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('ID: ${user.id}'),
            Text('Prénom: ${user.firstname}'),
            Text('Profession: ${user.profession}'),
            Text('Rôle: ${user.role}'),
            Text('Validé: ${user.validated}'),
          ],
        ),
      ),
    );
  }
}
