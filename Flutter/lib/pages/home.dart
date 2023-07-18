import 'package:flutter/material.dart';
import 'package:goldie_studio/widgets/title.dart';
import 'package:goldie_studio/webservices/user/user_class.dart';
import 'package:goldie_studio/webservices/user/user_webservices.dart';

import '../webservices/request/request_class.dart';
import '../webservices/request/request_webservices.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  static const String routeName = '/';

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<User>>? _usersFuture;
  Future<List<Request>>? _requestsFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = UserWebServices.getAllUsers();
    _requestsFuture = RequestWebServices.getAllRequests();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(title: "Bienvenue sur Goldie STUDIO"),
            const SizedBox(height: 16),
            const Text(
              "Liste des derniers utilisateurs",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            FutureBuilder<List<User>>(
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
                  return const Center(child: Text('Aucun utilisateur trouvé'));
                }

                final itemCount = users.length < 5 ? users.length : 5;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return Card(
                      child: ListTile(
                        title: Text(user.firstname ?? ''),
                        subtitle: Text(user.email),
                      ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 16),
            const Text(
              "Liste des dernières requêtes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            FutureBuilder<List<Request>>(
              future: _requestsFuture,
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

                final requests = snapshot.data;
                if (requests == null || requests.isEmpty) {
                  return const Center(child: Text('Aucune requête trouvée'));
                }

                final itemCount = requests.length < 5 ? requests.length : 5;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    final request = requests[index];
                    return Card(
                      child: ListTile(
                        title: Text(request.title ?? ''),
                        subtitle: Text(request.timer ?? ''),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
