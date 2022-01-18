import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as lat_lng;

class ObjectMap extends StatelessWidget {
  var coords = [];
  ObjectMap({Key? key, required this.coords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: lat_lng.LatLng(coords[0], coords[1]),
        zoom: 14.0,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return const Text("© Provided By OpenStreetMap");
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 40.0,
              height: 40.0,
              point: lat_lng.LatLng(coords[0], coords[1]),
              builder: (ctx) => const Icon(Icons.place_outlined),
            ),
          ],
        ),
      ],
    );
  }
}
