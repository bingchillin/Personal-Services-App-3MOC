import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user_class.dart';
import 'package:goldie_studio/webservices/user_webservices.dart';
import 'package:goldie_studio/widgets/title.dart';

class UserWebServicesFutureBuilder extends StatelessWidget {
  const UserWebServicesFutureBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<List<User>>(
        future: UserWebServices.getAllUsers(),
        builder: (context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erreur'),
            );
          }

          if (snapshot.hasData) {
            final users = snapshot.data;
            if (users == null || users.isEmpty) {
              return const Center(child: Text('No users'));
            }

            return ListView.builder(
              itemCount: users.length + 1, // +1 for the header row
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Header row
                  return const ListTile(
                    title: Row(
                      children: [
                        Expanded(child: TitleWidget(title: 'ID')),
                        Spacer(),
                        Expanded(child: TitleWidget(title: 'Prénom')),
                        Spacer(),
                        Expanded(child: TitleWidget(title: 'Profession')),
                        Spacer(),
                        Expanded(child: TitleWidget(title: 'Rôle')),
                        Spacer(),
                        Expanded(child: TitleWidget(title: 'Validé')),
                        Spacer(),
                      ],
                    ),
                  );
                }

                final user = users[index - 1];
                return Card(
                  child: ListTile(
                    title: Row(
                      children: [
                        Expanded(child: Text('${user.id}')),
                        const Spacer(),
                        Expanded(child: Text('${user.firstname}')),
                        const Spacer(),
                        Expanded(child: Text('${user.profession}')),
                        const Spacer(),
                        Expanded(child: Text('${user.role}')),
                        const Spacer(),
                        Expanded(child: Text('${user.validated}')),
                        ButtonBar(
                          children: [
                            IconButton(
                              onPressed: () {
                              },
                              icon: const Icon(Icons.edit),
                              color: Colors.blue,
                            ),
                            IconButton(
                              onPressed: () {
                              },
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
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

