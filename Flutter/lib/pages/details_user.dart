import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user_class.dart';

class UserDetailsWidget extends StatelessWidget {
  final User user;

  const UserDetailsWidget({Key? key, required this.user}) : super(key: key);

  static const String routeName = '/user_details';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${user.id}'),
            Text('Prénom: ${user.firstname}'),
            Text('Profession: ${user.profession}'),
            Text('Rôle: ${user.role}'),
            Text('Validé: ${user.validated}'),
          ],
        ),
      );
  }
}
