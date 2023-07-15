import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/user_futurebuilder.dart';

class UsersWidget extends StatelessWidget {
  const UsersWidget({super.key});

  static const String routeName = '/users';

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //UserWidget(),
        Expanded(
          child: UserWebServicesFutureBuilder(),
        ),
      ],
    );
  }
}
