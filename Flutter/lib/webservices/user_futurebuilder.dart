import 'package:flutter/material.dart';
import 'package:goldie_studio/pages/details_user.dart';
import 'package:goldie_studio/webservices/user_class.dart';
import 'package:goldie_studio/webservices/user_webservices.dart';
import 'package:goldie_studio/widgets/title.dart';

import '../pages/add_user.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({Key? key}) : super(key: key);

  static const String routeName = '/users';

  @override
  Widget build(BuildContext context) {
    return const UserWebServicesFutureBuilder();
  }
}

class UserWebServicesFutureBuilder extends StatefulWidget {
  const UserWebServicesFutureBuilder({Key? key}) : super(key: key);

  @override
  State<UserWebServicesFutureBuilder> createState() =>
      _UserWebServicesFutureBuilderState();
}

class _UserWebServicesFutureBuilderState
    extends State<UserWebServicesFutureBuilder> {
  Future<List<User>>? _usersFuture;
  List<User> _users = [];
  List<User> _filteredUsers = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _usersFuture = UserWebServices.getAllUsers().then((users) {
      _users = users;
      _filteredUsers = users;
      return users;
    });
  }

  void _deleteUser(int? id) {
    if (id != null) {
      setState(() {
        _usersFuture = UserWebServices.deleteUser(id).then((_) {
          return UserWebServices.getAllUsers().then((users) {
            _users = users;
            _filteredUsers = users;
            return users;
          });
        });
      });
    }
  }

  void updateUsers() {
    setState(() {
      _usersFuture = UserWebServices.getAllUsers().then((users) {
        _users = users;
        _filteredUsers = users;
        return users;
      });
    });
  }

  void _updateFilteredUsers(String searchText) {
    setState(() {
      _filteredUsers = _users
          .where((user) =>
              user.email?.toLowerCase().contains(searchText.toLowerCase()) ??
              false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: _updateFilteredUsers,
            decoration: const InputDecoration(
              hintText: 'Rechercher par email',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: updateUsers,
                icon: const Icon(Icons.refresh),
              ),
              IconButton(
                onPressed:() {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AddUserWidget(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<User>>(
              future: _usersFuture,
              builder: (context, snapshot) {
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
                  itemCount: _filteredUsers.length + 1, // +1 for the header row
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

                    final user = _filteredUsers[index - 1];
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
                                        builder: (context) =>
                                            UserDetailsWidget(user: user),
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
          ),
        ],
      ),
    );
  }
}
