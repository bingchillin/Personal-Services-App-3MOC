import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/request/request_class.dart';
import 'package:goldie_studio/webservices/request/request_webservices.dart';
import '../../widgets/title.dart';

class RequestsWidget extends StatelessWidget {
  const RequestsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const RequestWebServicesFutureBuilder();
  }
}

class RequestWebServicesFutureBuilder extends StatefulWidget {
  const RequestWebServicesFutureBuilder({Key? key}) : super(key: key);

  @override
  State<RequestWebServicesFutureBuilder> createState() =>
      _RequestWebServicesFutureBuilderState();
}

class _RequestWebServicesFutureBuilderState
    extends State<RequestWebServicesFutureBuilder> {
  Future<List<Request>>? _requestsFuture;
  List<Request> _requests = [];
  List<Request> _filteredRequests = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _requestsFuture = RequestWebServices.getAllRequests().then((requests) {
      debugPrint('requests: $requests');
      _requests = requests;
      _filteredRequests = requests;
      return requests;
    });
  }

  void _deleteRequest(int? id) {
    if (id != null) {
      setState(() {
        _requestsFuture = RequestWebServices.deleteRequest(id).then((_) {
          return RequestWebServices.getAllRequests().then((requests) {
            _requests = requests;
            _filteredRequests = requests;
            return requests;
          });
        });
      });
    }
  }

  void updateRequests() {
    setState(() {
      _requestsFuture = RequestWebServices.getAllRequests().then((requests) {
        _requests = requests;
        _filteredRequests = requests;
        return requests;
      });
    });
  }

  void _updateFilteredRequests(String searchText) {
    setState(() {
      _filteredRequests = _requests
          .where((request) =>
              request.title?.toLowerCase().contains(searchText.toLowerCase()) ??
              false)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            onChanged: _updateFilteredRequests,
            decoration: const InputDecoration(
              hintText: 'Rechercher par titre',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: updateRequests,
                icon: const Icon(Icons.refresh),
              ),
              IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         AddRequestWidget(),
                  //   ),
                  // );
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: FutureBuilder<List<Request>>(
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
                  return const Center(child: Text('No requests'));
                }

                return ListView.builder(
                  itemCount: _filteredRequests.length + 1,
                  // +1 for the header row
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // Header row
                      return const ListTile(
                        title: Row(
                          children: [
                            Expanded(child: TitleWidget(title: 'ID')),
                            Spacer(),
                            Expanded(child: TitleWidget(title: 'Titre')),
                            Spacer(),
                            Expanded(child: TitleWidget(title: 'Timer')),
                            Spacer(),
                            Expanded(child: TitleWidget(title: 'Acceptée')),
                            Spacer(),
                            Expanded(child: TitleWidget(title: 'Complétée')),
                            Spacer(),
                          ],
                        ),
                      );
                    }

                    final request = _filteredRequests[index - 1];
                    return Card(
                      child: ListTile(
                        title: Row(
                          children: [
                            Expanded(child: Text('${request.id}')),
                            const Spacer(),
                            Expanded(child: Text('${request.title}')),
                            const Spacer(),
                            Expanded(child: Text('${request.timer}')),
                            const Spacer(),
                            Expanded(child: Text('${request.accepted}')),
                            const Spacer(),
                            Expanded(child: Text('${request.done}')),
                            ButtonBar(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         RequestDetailsWidget(
                                    //             request: request),
                                    //   ),
                                    // );
                                  },
                                  icon: const Icon(Icons.edit),
                                  color: Colors.blue,
                                ),
                                IconButton(
                                  onPressed: () {
                                    _deleteRequest(request.id);
                                  },
                                  icon: const Icon(Icons.delete),
                                  color: Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
