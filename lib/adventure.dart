import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Adventure extends StatefulWidget {
  const Adventure({Key? key}) : super(key: key);

  @override
  State<Adventure> createState() => _AdventureState();
}

class _AdventureState extends State<Adventure> {
  StreamSubscription<Position>? streamPosition;

  GoogleMapController? _controller;

  List<LatLng> polylineCoordinates = [];

  double latitude = 0.0, longitude = 0.0;

  @override
  void initState() {
    getCurrentLocation();
    getPolylines();
    super.initState();
  }

  @override
  void dispose() {
    streamPosition!.cancel();
    super.dispose();
  }

  void getCurrentLocation() async {
    streamPosition = Geolocator.getPositionStream(
        desiredAccuracy: LocationAccuracy.best,
        intervalDuration: const Duration(seconds: 15)
    ).listen((Position position) {
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
      if (_controller != null) {
        _controller!.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: LatLng(
                        latitude,
                        longitude
                    ),
                    zoom: 14.4746
                )
            )
        );
      }
    });
  }

  void getPolylines() {
    PolylinePoints().getRouteBetweenCoordinates(
        "AIzaSyDgXRQripKQUEAphzbyxG489nah_ZmnmRI",
        PointLatLng(
            latitude,
            longitude
        ),
        const PointLatLng(
            57.621752,
            39.926077
        )
    ).then((value) {
      if (value.points.isNotEmpty) {
        for (var point in value.points) {
          polylineCoordinates.add(
              LatLng(
                  point.latitude,
                  point.longitude
              )
          );
        }
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xffFFBFB7),
    body: GoogleMap(
        markers: {
          Marker(
              markerId: const MarkerId("me"),
              position: LatLng(
                  latitude,
                  longitude
              ),
              draggable: false,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure
              )
          ),
          Marker(
              markerId: const MarkerId("marker"),
              position: const LatLng(
                  57.627086,
                  39.884712
              ),
              draggable: false,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue
              )
          )
        },
        polylines: {Polyline(
            polylineId: const PolylineId("polyline"),
            visible: true,
            points: polylineCoordinates,
            color: Colors.green
        )},
        myLocationButtonEnabled: false,
        onMapCreated: (GoogleMapController controller) => _controller = controller,
        initialCameraPosition: CameraPosition(
            zoom: 14.4746,
            target: LatLng(
                latitude,
                longitude
            )
        )
    ),
  );
}