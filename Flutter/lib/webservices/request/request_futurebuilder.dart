import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/request/request_class.dart';
import 'package:goldie_studio/webservices/request/request_webservices.dart';
import '../../pages/request/add_req.dart';
import '../../pages/request/details_req.dart';
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
  List<Request> _requests = [];
  List<Request> _filteredRequests = [];
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  final int _requestsPerPage = 10;

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  void _loadRequests() {
    RequestWebServices.getAllRequests().then((requests) {
      setState(() {
        _requests = requests;
        _filteredRequests =
            requests.take(_currentPage * _requestsPerPage).toList();
      });
      return requests;
    });
  }

  void _deleteRequest(int? id) {
    if (id != null) {
      setState(() {
        RequestWebServices.deleteRequest(id).then((_) {
          _loadRequests();
        });
      });
    }
  }

  void updateRequests() {
    setState(() {
      _currentPage = 1;
      RequestWebServices.getAllRequests().then((requests) {
        _requests = requests;
        _filteredRequests =
            requests.take(_currentPage * _requestsPerPage).toList();
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
          .take(_currentPage * _requestsPerPage)
          .toList();
    });
  }

  void _loadMoreRequests() {
    setState(() {
      _currentPage++;
      _filteredRequests =
          _requests.take(_currentPage * _requestsPerPage).toList();
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequestAddWidget(),
                    ),
                  );
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
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
                        Expanded(child: TitleWidget(title: 'Complétée')),
                        Spacer(),
                      ],
                    ),
                  );
                } else if (index == _filteredRequests.length) {
                  if (_filteredRequests.length < _requests.length) {
                    return ElevatedButton(
                      onPressed: _loadMoreRequests,
                      child: const Text('Charger plus'),
                    );
                  } else {
                    return const SizedBox
                        .shrink(); // Hide the button if all requests are shown
                  }
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
                        Expanded(child: Text('${request.done}')),
                        ButtonBar(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RequestDetailsWidget(request: request),
                                  ),
                                );
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
            ),
          ),
        ],
      ),
    );
  }
}
