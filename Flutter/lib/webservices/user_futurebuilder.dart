import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user_class.dart';
import 'package:goldie_studio/webservices/user_webservices.dart';

class UserWebServicesHomeFutureBuilder extends StatelessWidget {
  const UserWebServicesHomeFutureBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exemple FutureBuilder'),
      ),
      body: FutureBuilder<List<User>>(
        future: UserWebServices.getAllUsers(),
        builder: (context, AsyncSnapshot<List<User>> snapShot) {
          if (snapShot.hasError) {
            return const Center(
              child: Text('Erreur'),
            );
          }

          if (snapShot.hasData) {
            final users = snapShot.data;
            if (users == null || users.isEmpty) {
              return const Center(child: Text('No users'));
            }

            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text('${user.firstname}'),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}