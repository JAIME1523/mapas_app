import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mapas_app/blocs/blocs.dart';
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
    final serarchBloc = BlocProvider.of<SearchBloc>(context);

    serarchBloc.getPlaceByQuery(query);

    return BlocBuilder<SearchBloc, SearchState>(
      builder: (BuildContext context, state) {
        return ListView.separated(
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final PlacesResponce place = state.places[index];
            return ListTile(
              title: Text(place.displayPlace),
              subtitle: Text(
                place.displayName,
                style: const TextStyle(fontSize: 12),
              ),
              leading: const Icon(
                Icons.place_outlined,
                color: Colors.black,
              ),
              onTap: () {
                final result = SearchResut(
                    cancel: false,
                    manual: false,
                    position: LatLng(
                        double.parse(place.lat), double.parse(place.lon)),
                    description: place.displayName,
                    name: place.displayName);

                //aqui se  agregar el evento y mandar el lugar
                serarchBloc.add(AddToHistoryEvent(place));
                close(context, result);
              },
            );
          },
          itemCount: state.places.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //refrencia al state searBloc
    final historia = BlocProvider.of<SearchBloc>(context).state.history;

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
        ),
        ...historia.map((place) =>  ListTile(
              title: Text(place.displayPlace),
              subtitle: Text(
                place.displayName,
                style: const TextStyle(fontSize: 12),
              ),
              leading: const Icon(
                Icons.place_outlined,
                color: Colors.black,
              ),
              onTap: () {
                final result = SearchResut(
                    cancel: false,
                    manual: false,
                    position: LatLng(
                        double.parse(place.lat), double.parse(place.lon)),
                    description: place.displayName,
                    name: place.displayName);

                //aqui se  agregar el evento y mandar el lugar
                // serarchBloc.add(AddToHistoryEvent(place));
                close(context, result);
              },
            )
          )
      ],
    );
  }
}
