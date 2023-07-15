import 'package:flutter/material.dart';
import 'package:goldie_studio/widgets/title.dart';

class UserWidget extends StatelessWidget {
  UserWidget({super.key});

  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Charlemagne", "age": 20},
    {"id": 2, "name": "Aurora", "age": 25},
    {"id": 3, "name": "Liam", "age": 30},
    {"id": 4, "name": "Olivia", "age": 22},
    {"id": 5, "name": "Noah", "age": 27},
    {"id": 6, "name": "Isabella", "age": 19},
    {"id": 7, "name": "Lucas", "age": 24},
    {"id": 8, "name": "Sophia", "age": 31},
    {"id": 9, "name": "Mason", "age": 26},
    {"id": 10, "name": "Ava", "age": 23},
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitleWidget(title: "Utilisateurs"),
            Expanded(
              child: ListView.builder(
                itemCount: _allUsers.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(_allUsers[index]['name']),
                      subtitle: Text(_allUsers[index]['age'].toString()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
