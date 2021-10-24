import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:pay/pay.dart';

const _paymentItems = [
  PaymentItem(
    label: 'Total',
    amount: '00.01',
    status: PaymentItemStatus.final_price,
  )
];

class PickMap extends StatefulWidget {
  const PickMap({Key? key}) : super(key: key);

  @override
  State<PickMap> createState() => _PickMapState();
}

class _PickMapState extends State<PickMap> {

  void onGooglePayResult(paymentResult) {
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void onApplePayResult(paymentResult) {
    debugPrint(paymentResult.toString());
  }

  GoogleMapController? _controller;

  List<LatLng> polylineCoordinates = [];

  double latitude = 0.0, longitude = 0.0;

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
          top: 50,
          left: 10,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back_ios),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 10,
          right: 10,
          child: Row(
            children: [
             GestureDetector(
               onTap: () => showModalBottomSheet(
                   context: context,
                   backgroundColor: Colors.transparent,
                   builder: (BuildContext context) => Container(
                     height: 150,
                     padding: const EdgeInsets.symmetric(
                         horizontal: 10,
                         vertical: 10
                     ),
                     decoration: const BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.only(
                             topRight: Radius.circular(30),
                             topLeft: Radius.circular(30)
                         )
                     ),
                     child: Column(
                       children: [
                         Container(
                           height: 50,
                           width: double.infinity,
                           alignment: Alignment.center,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5),
                               color: const Color(0xff2247e4)
                           ),
                           child: const Text(
                             "Оплатить картой",
                             style: TextStyle(
                                 color: Colors.white
                             ),
                           ),
                         ),
                         GooglePayButton(
                           height: 50,
                           width: double.infinity,
                           paymentConfigurationAsset:
                           'default_payment_profile_google_pay.json',
                           paymentItems: _paymentItems,
                           style: GooglePayButtonStyle.black,
                           type: GooglePayButtonType.pay,
                           margin: const EdgeInsets.only(top: 15.0),
                           onPaymentResult: onGooglePayResult,
                           loadingIndicator: const Center(
                             child: CircularProgressIndicator(),
                           ),
                         ),
                       ],
                     ),
                   )
               ),
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
                backgroundColor: Colors.transparent,
              context: context,
                  builder: (BuildContext context) => Container(
                    height: 150,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                      ),
                      color: Colors.white
                    ),
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
                    ),
                  )
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