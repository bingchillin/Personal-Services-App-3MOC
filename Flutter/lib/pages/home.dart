import 'package:flutter/material.dart';
import 'package:goldie_studio/widgets/title.dart';
import 'package:goldie_studio/widgets/user.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //const TitleWidget(title: "Bienvenue sur Goldie Studio"),
        UserWidget(),
      ],
    );
  }
}
