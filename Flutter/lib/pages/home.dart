import 'package:flutter/material.dart';
import 'package:goldie_studio/widgets/title.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleWidget(title: "Bienvenue sur Goldie Studio"),
        ],
      ),
    );
  }
}
