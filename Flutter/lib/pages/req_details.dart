import 'package:flutter/material.dart';
import 'package:goldie_studio/webservices/request/request_class.dart';
import '../webservices/request/request_webservices.dart';

class RequestDetailsWidget extends StatefulWidget {
  final Request request;

  const RequestDetailsWidget({Key? key, required this.request}) : super(key: key);

  @override
  _RequestDetailsWidgetState createState() => _RequestDetailsWidgetState();
}

class _RequestDetailsWidgetState extends State<RequestDetailsWidget> {
  late List<Map<String, String>> _fieldList;
  late List<TextEditingController> _textControllers;

  @override
  void initState() {
    super.initState();
    _fieldList = [
      {'Titre': widget.request.title ?? ''},
      {'Timer': widget.request.timer ?? ''},
      {'Client': widget.request.client?.toString() ?? ''},
      {'Type': widget.request.type?.toString() ?? ''},
      {'Slots': widget.request.slots?.toString() ?? ''},
      {'Complétée': widget.request.done?.toString() ?? ''},
    ];

    _textControllers = _fieldList
        .map((field) => TextEditingController(text: field.values.first))
        .toList();
  }

  @override
  void dispose() {
    for (var controller in _textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails de la demande'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            for (var i = 0; i < _fieldList.length; i++)
              TextField(
                controller: _textControllers[i],
                decoration: InputDecoration(
                  labelText: _fieldList[i].keys.first,
                ),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final updatedRequest = Request(
                  id: widget.request.id,
                  title: _textControllers[0].text,
                  timer: _textControllers[1].text,
                  client: int.tryParse(_textControllers[2].text),
                  type: int.tryParse(_textControllers[3].text),
                  slots: int.tryParse(_textControllers[4].text),
                  done: int.tryParse(_textControllers[6].text),
                );

                await RequestWebServices.updateRequest(updatedRequest);

                // Afficher une snackbar ou une boîte de dialogue pour confirmer la mise à jour
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Demande mise à jour')),
                );

                // Naviguer en arrière après la mise à jour
                Navigator.pop(context);
              },
              child: const Text('Enregistrer'),
            ),
          ],
        ),
      ),
    );
  }
}
