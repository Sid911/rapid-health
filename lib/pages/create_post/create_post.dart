import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rapid_health/global/location_selector.dart';

import '../../utility/map_styles.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kDefault = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Set<Marker> selectedLocationMarker = <Marker>{
    const Marker(
      markerId: MarkerId("userLocation"),
      position: LatLng(37.42796133580664, -122.085749655962),
    )
  };

  void setMarkerPosition(LatLng position) async {
    final newCamPos = CameraPosition(target: position, zoom: 13);
    final control = await _controller.future;
    control.animateCamera(CameraUpdate.newCameraPosition(newCamPos));
    setState(() {
      selectedLocationMarker = {
        Marker(
          markerId: const MarkerId("selectedLocation"),
          position: position,
        ),
      };
    });
  }

  void requestPermissions() async {
    final Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    setMarkerPosition(LatLng(
      _locationData.latitude!,
      _locationData.longitude!,
    ));
  }

  @override
  void initState() {
    super.initState();
    requestPermissions();
  } // Form thingy

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: const Text("Create Post"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          FlutterRemix.add_line,
          color: theme.textTheme.bodyText1?.color,
        ),
        onPressed: () {},
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: theme.textTheme.bodyText1,
                decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: theme.textTheme.bodyText1,
                  helperText:
                      "Something very formal. Maybe your company name or service you are offering!",
                  helperMaxLines: 2,
                ),
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'Please enter the full title';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: theme.textTheme.bodyText1,
                decoration: InputDecoration(
                  labelText: "Subtitle",
                  labelStyle: theme.textTheme.bodyText1,
                  helperText: "Your moto or anything catchy !",
                ),
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.length < 5) {
                    return 'Please enter an elaborate subtitle';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: theme.textTheme.bodyText1,
                decoration: InputDecoration(
                  labelText: "Description",
                  labelStyle: theme.textTheme.bodyText1,
                  helperText:
                      "Describe your service well. This will be the details people will read while selecting the service.",
                  helperMaxLines: 2,
                ),
                maxLength: 500,
                maxLines: 12,
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.length < 50) {
                    return 'Please enter an elaborate description';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                keyboardType: TextInputType.text,
                style: theme.textTheme.bodyText1,
                decoration: InputDecoration(
                  labelText: "Address",
                  labelStyle: theme.textTheme.bodyText1,
                  helperText:
                      "Address to avail the service. Note: This must be accurate enough to lead the user on their own.",
                  helperMaxLines: 2,
                ),
                maxLength: 100,
                maxLines: 3,
                onChanged: (value) {},
                validator: (value) {
                  if (value == null || value.length < 10) {
                    return 'Please enter an elaborate address';
                  }
                  return null;
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              child: Text(
                "Select your location 📍",
                style: theme.textTheme.bodyText1,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 30),
              height: 400,
              child: GoogleMap(
                zoomControlsEnabled: false,
                zoomGesturesEnabled: false,
                scrollGesturesEnabled: false,
                tiltGesturesEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: _kDefault,
                markers: selectedLocationMarker,
                onTap: (pos) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LocationSelector(
                          initialPosition: pos,
                          callback: setMarkerPosition,
                        );
                      },
                    ),
                  );
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
            Container(
              padding: const EdgeInsets.all(10),
              child: Text(
                "Enter the location for the service in order to let users find the location",
                style: theme.textTheme.subtitle2,
              ),
            )
          ],
        ),
      ),
    );
  }
}
