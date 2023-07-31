import 'package:flutter/material.dart';
import '../../widgets/title.dart';

class MissionsWidget extends StatelessWidget {
  const MissionsWidget({super.key});

  static const String routeName = '/missions';

  @override
  Widget build(BuildContext context) {
    return const MissionFutureBuilder();
  }
}


class MissionFutureBuilder extends StatefulWidget {
  const MissionFutureBuilder({super.key});

  @override
  State<MissionFutureBuilder> createState() => _MissionFutureBuilderState();
}

class _MissionFutureBuilderState extends State<MissionFutureBuilder> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Rechercher une mission',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.refresh),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.add),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
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
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
