import 'package:flutter/material.dart';
import 'package:goldie_studio/pages/user/details_user.dart';
import 'package:goldie_studio/webservices/user/user_class.dart';
import 'package:goldie_studio/webservices/user/user_webservices.dart';
import 'package:goldie_studio/widgets/title.dart';

import '../../pages/user/add_user.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({Key? key}) : super(key: key);

  static const String routeName = '/users';

  @override
  Widget build(BuildContext context) {
    return const UserFutureBuilder();
  }
}

class UserFutureBuilder extends StatefulWidget {
  const UserFutureBuilder({Key? key}) : super(key: key);

  @override
  State<UserFutureBuilder> createState() =>
      _UserFutureBuilderState();
}

class _UserFutureBuilderState
    extends State<UserFutureBuilder> {
  List<User> _users = [];
  List<User> _filteredUsers = [];
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  final int _usersPerPage = 10;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() {
    UserWebServices.getAllUsers().then((users) {
      setState(() {
        _users = users;
        _filteredUsers = _users.take(_currentPage * _usersPerPage).toList();
      });
      return users;
    });
  }

  void _deleteUser(int? id) {
    if (id != null) {
      setState(() {
        UserWebServices.deleteUser(id).then((_) {
          _loadUsers();
        });
      });
    }
  }

  void _updateFilteredUsers(String searchText) {
    setState(() {
      _filteredUsers = _users
          .where((user) =>
              user.email.toLowerCase().contains(searchText.toLowerCase()))
          .take(_currentPage * _usersPerPage)
          .toList();
    });
  }

  void _loadMoreUsers() {
    setState(() {
      _currentPage++;
      _filteredUsers = _users.take(_currentPage * _usersPerPage).toList();
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
                onPressed: _loadUsers,
                icon: const Icon(Icons.refresh),
              ),
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddUserWidget(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredUsers.length + 2,
              itemBuilder: (context, index) {
                if (index == 0) {
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
                } else if (index == _filteredUsers.length + 1) {
                  return ElevatedButton(
                    onPressed: _loadMoreUsers,
                    child: const Text('Charger plus'),
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
            ),
          ),
        ],
      ),
    );
  }
}
