import 'package:flutter/material.dart';
import '../../webservices/mission/mission_futurebuilder.dart';

class MissionsWidget extends StatelessWidget {
  const MissionsWidget({super.key});

  static const String routeName = '/missions';

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: MissionFutureBuilder(),
        ),
      ],
    );
  }
}

