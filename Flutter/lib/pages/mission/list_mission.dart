import 'package:flutter/material.dart';
import '../../webservices/type/mission_futurebuilder.dart';

class TypesWidget extends StatelessWidget {
  const TypesWidget({super.key});

  static const String routeName = '/missions';

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TypesFutureBuilder(),
        ),
      ],
    );
  }
}

