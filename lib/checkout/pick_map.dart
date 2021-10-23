import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:just_up/widget/just_up_button.dart';
import 'package:map_launcher/map_launcher.dart';

class PickMap extends StatefulWidget {
  const PickMap({Key? key}) : super(key: key);

  @override
  State<PickMap> createState() => _PickMapState();
}

class _PickMapState extends State<PickMap> {
  StreamSubscription<Position>? streamPosition;

  GoogleMapController? _controller;

  List<LatLng> polylineCoordinates = [];

  double latitude = 0.0, longitude = 0.0;

  @override
  void dispose() {
    streamPosition!.cancel();
    super.dispose();
  }

  void getPositioned() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) {
      setState(() {
        latitude = value.latitude;
        longitude = value.longitude;
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
            43.585472,
            39.723098
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
        print(polylineCoordinates);
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        GoogleMap(
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
            onMapCreated: (GoogleMapController controller) {
              _controller = controller;
              getPositioned();
              getPolylines();
            },
            initialCameraPosition: CameraPosition(
                zoom: 14.4746,
                target: LatLng(
                    latitude,
                    longitude
                )
            )
        ),
        Positioned(
          bottom: 20,
          left: 10,
          right: 10,
          child: Row(
            children: [
             GestureDetector(
               onTap: () => Navigator.popUntil(context, (route) => route.isFirst),
               child:  ClipRRect(
                 borderRadius: BorderRadius.circular(29),
                 child: Container(
                     height: 50,
                     width: MediaQuery.of(context).size.width / 2 - 20,
                     color: const Color(0xff2247e4),
                     alignment: Alignment.center,
                     child: const Text(
                       "Оплатить",
                       style: TextStyle(color: Colors.white),
                     )
                 ),
               )
             ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  final availableMaps = await MapLauncher.installedMaps;
              showModalBottomSheet(
              context: context,
                  builder: (BuildContext context) {
                    return SafeArea(
                        child: Column(
                            children: <Widget>[
                              Expanded(
                                  child: SingleChildScrollView(
                                      child: Wrap(
                                          children: <Widget>[
                                            for (var map in availableMaps)
                                              ListTile(
                                                  onTap: () {
                                                    map.showDirections(
                                                        origin: Coords(
                                                            latitude,
                                                            longitude
                                                        ),
                                                        destination: Coords(
                                                            43.585472,
                                                            39.723098
                                                        )
                                                    ).then((value) => Navigator.pop(context));
                                                  },
                                                  title: Text(map.mapName),
                                                  leading: SvgPicture.asset(
                                                    map.icon,
                                                    height: 30.0,
                                                    width: 30.0,
                                                  )
                                              )
                                          ]
                                      )
                                  )
                              )
                            ]
                        )
                    );
                  }
              );
                },
                child: Container(
                    height:50,
                    decoration: BoxDecoration(
                        color: const Color(0xff2247e4),
                      borderRadius: BorderRadius.circular(29)
                    ),
                    width: MediaQuery.of(context).size.width / 2 - 20,
                    alignment: Alignment.center,
                    child: const Text(
                      "Другие карты",
                      style: TextStyle(color: Colors.white),
                    )
                )
              ),
            ],
          ),
        )
      ]
    )
  );
}