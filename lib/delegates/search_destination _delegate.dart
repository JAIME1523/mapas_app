import 'package:flutter/material.dart';
import 'package:mapas_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResut> {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Buscar...');
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            //el cuery ya biene el searh delegate
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          //close biene en SearchDelegate
          final result = SearchResut(cancel: true);
          close(context, result);
        },
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(
            Icons.location_on_outlined,
            color: Colors.black,
          ),
          title: const Text('Colocar la ubicacion manual mente',
              style: TextStyle(color: Colors.black)),
          onTap: () {
            final result = SearchResut(cancel: false, manual: true);

            close(context, result);
          },
        )
      ],
    );
  }
}
