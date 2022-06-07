import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rapid_health/global/doctor_dropdown_button.dart';
import 'package:rapid_health/global/location_selector.dart';
import 'package:rapid_health/utility/map_styles.dart';

import '../../bloc/registration/registration_cubit.dart';

class DoctorRegistration extends StatefulWidget {
  const DoctorRegistration({Key? key}) : super(key: key);

  @override
  State<DoctorRegistration> createState() => _DoctorRegistrationState();
}

class _DoctorRegistrationState extends State<DoctorRegistration> {
  final Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kDefault = const CameraPosition(
    target: LatLng(21.250000, 81.629997),
    zoom: 14.4746,
  );

  Set<Marker> selectedLocationMarker = <Marker>{
    const Marker(
      markerId: MarkerId("userLocation"),
      position: LatLng(21.250000, 81.629997),
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
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.phone,
          style: theme.textTheme.bodyText1,
          decoration: const InputDecoration(
            labelText: "Work phone no. (public)",
            labelStyle: TextStyle(fontSize: 12),
          ),
          onChanged: (value) {
            context.read<RegistrationCubit>().setDoctorWorkPhone(value);
          },
          validator: (value) {
            if (value == null || value.length < 10) {
              return 'Please enter valid phone number';
            }
            return null;
          },
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.streetAddress,
          style: theme.textTheme.bodyText1,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: "Work address (public)",
            labelStyle: TextStyle(fontSize: 12),
          ),
          onChanged: (value) {
            context.read<RegistrationCubit>().setDoctorWorkAddress(value);
          },
          validator: (value) {
            if (value == null || value.length < 8) {
              return 'Please enter elaborate address';
            }
            return null;
          },
        ),
        TextFormField(
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.url,
          style: theme.textTheme.bodyText1,
          maxLines: 2,
          decoration: const InputDecoration(
            labelText: "Website",
            labelStyle: TextStyle(fontSize: 12),
          ),
          onChanged: (value) {
            context.read<RegistrationCubit>().setDoctorWorkWebsite(value);
          },
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Major type of service you provide"),
              BlocBuilder<RegistrationCubit, RegistrationState>(
                builder: (context, state) {
                  if (state is RegistrationDoctor) {
                    return DoctorDropdownButton(
                      value: state.category,
                      onChanged: (category) {
                        context
                            .read<RegistrationCubit>()
                            .setDoctorWorkCategory(category);
                      },
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child:  Text("Your Work location",style: theme.textTheme.subtitle2,),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 30),
          height: 200,
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
                      initialPosition: selectedLocationMarker.first.position,
                      callback: (pos) {
                        setMarkerPosition(pos);
                        context
                            .read<RegistrationCubit>()
                            .setDoctorWorkCoordinates(
                          [pos.latitude, pos.longitude],
                        );
                      },
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
      ],
    );
  }
}
