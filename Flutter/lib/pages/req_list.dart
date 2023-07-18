import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/request/request_futurebuilder.dart';

class RequestsWidget extends StatelessWidget {
  const RequestsWidget({super.key});

  static const String routeName = '/requests';

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: RequestWebServicesFutureBuilder(),
        ),
      ],
    );
  }
}
