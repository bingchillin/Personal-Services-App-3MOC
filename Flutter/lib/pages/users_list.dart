import 'package:flutter/material.dart';
import 'package:goldie_studio/widgets/user.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({super.key});

  static const String routeName = '/users';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        UserWidget(),
      ],
    );
  }
}
