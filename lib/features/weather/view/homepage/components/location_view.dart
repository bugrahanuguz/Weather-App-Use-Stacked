import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  final double? longitude;
  final double? latitude;
  final String? city;

  const LocationView(
      {Key? key,
      required this.longitude,
      required this.latitude,
      required this.city})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        cityNameTextWidget(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.location_on, color: Colors.white, size: 15),
            const SizedBox(width: 10),
            buildCoordText(longitude.toString()),
            buildCoordText(' , '.toString()),
            buildCoordText(latitude.toString().toString()),
          ],
        )
      ]),
    );
  }

  Text cityNameTextWidget() {
    return Text('$city',
        style: const TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w300,
          color: Colors.white,
        ));
  }

  Text buildCoordText(String text) {
    return Text(text,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ));
  }
}
