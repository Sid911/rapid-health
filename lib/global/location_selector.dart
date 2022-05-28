import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../utility/map_styles.dart';

class LocationSelector extends StatefulWidget {
  const LocationSelector({
    Key? key,
    required this.initialPosition,
    required this.callback,
  }) : super(key: key);
  final LatLng initialPosition;
  final void Function(LatLng position) callback;
  @override
  State<LocationSelector> createState() => _LocationSelectorState();
}

class _LocationSelectorState extends State<LocationSelector> {
  final Completer<GoogleMapController> _controller = Completer();

  late Set<Marker> markers;
  @override
  void initState() {
    super.initState();
    markers = {
      Marker(
        markerId: const MarkerId("initial"),
        position: widget.initialPosition,
        flat: true,
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          zoomControlsEnabled: false,
          mapType: MapType.normal,
          tiltGesturesEnabled: false,
          initialCameraPosition:
              CameraPosition(target: widget.initialPosition, zoom: 15),
          markers: markers,
          myLocationButtonEnabled: false,
          myLocationEnabled: true,
          onTap: (pos) {
            setState(() {
              markers = {
                Marker(
                  markerId: const MarkerId("initial"),
                  position: pos,
                  flat: true,
                )
              };
            });
          },
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(
              theme.brightness == Brightness.dark
                  ? MapStyles.dark
                  : MapStyles.light,
            );
            _controller.complete(controller);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pop(context);
          widget.callback(markers.first.position);
        },
        label: const Text('Select location'),
        icon: const Icon(FlutterRemix.map_2_line),
      ),
    );
  }
}
