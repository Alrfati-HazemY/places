import 'package:favorite_places_app_5/models/place.dart';
import 'package:favorite_places_app_5/screens/place_detail.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({required this.places, super.key});
  final List<Place> places;

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (places.isNotEmpty) {
      content = ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => PlaceDetailScreen(
                    place: places[index],
                  ),
                ),
              );
            },
            leading: CircleAvatar(
              backgroundImage: FileImage(places[index].image),
            ),
            title: Text(
              places[index].title,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              places[index].location.address,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          );
        },
      );
    } else {
      content = Center(
        child: Text(
          "No places added yet!",
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      );
    }

    return content;
  }
}
