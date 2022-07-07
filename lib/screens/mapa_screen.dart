import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);
  static String routerName = 'mapa';

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
  Completer<GoogleMapController> _controller = Completer();
  MapType mapType = MapType.normal;
  final CameraPosition puntoInicial = CameraPosition(
    target: LatLng(-12.0200065, -77.0070657),
    zoom: 17,
  );

  @override
  Widget build(BuildContext context) {
    //Marcadores
    Set<Marker> markers = Set<Marker>();
    markers.add(Marker(
        markerId: MarkerId('geo-location'),
        position: LatLng(-12.0200065, -77.0070657)));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa'),
        actions: [
          IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: LatLng(-12.0200065, -77.0070657), zoom: 17)));
              },
              icon: const Icon(Icons.location_disabled))
        ],
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.layers),
          onPressed: () {
            if (mapType == MapType.normal) {
              mapType = MapType.satellite;
            } else {
              mapType = MapType.normal;
            }
            setState(() {});
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: GoogleMap(
        mapType: mapType,
        markers: markers,
        initialCameraPosition: puntoInicial,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
