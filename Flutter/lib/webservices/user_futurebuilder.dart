import 'package:flutter/material.dart';
import 'package:goldie_studio/pages/details_user.dart';
import 'package:goldie_studio/webservices/user_class.dart';
import 'package:goldie_studio/webservices/user_webservices.dart';
import 'package:goldie_studio/widgets/title.dart';

class UserWebServicesFutureBuilder extends StatefulWidget {
  const UserWebServicesFutureBuilder({Key? key}) : super(key: key);

  @override
  State<UserWebServicesFutureBuilder> createState() => _UserWebServicesFutureBuilderState();
}

class _UserWebServicesFutureBuilderState extends State<UserWebServicesFutureBuilder> {
  Future<List<User>>? _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = UserWebServices.getAllUsers();
  }

  void _deleteUser(int? id) {
    if (id != null) {
      setState(() {
        _usersFuture = UserWebServices.deleteUser(id).then((_) {
          return UserWebServices.getAllUsers();
        });
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: FutureBuilder<List<User>>(
        future: _usersFuture,
        builder: (context, AsyncSnapshot<List<User>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Erreur ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserDetailsWidget(user: user),
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                            color: Colors.blue,
                          ),
                          IconButton(
                            onPressed: () {
                              _deleteUser(user.id);
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
        },
      ),
    );
  }
}
