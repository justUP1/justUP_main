import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_up/checkout/pick_date.dart';
import 'package:just_up/checkout/pick_places.dart';
import 'package:just_up/widget/just_up_button.dart';
import 'package:google_maps_webservice/places.dart';

class PickRoute extends StatefulWidget {
  const PickRoute({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickRouteState();
}

class _PickRouteState extends State<PickRoute> {
  TextEditingController fromController = TextEditingController(),
      toController = TextEditingController();

  List<PlacesSearchResult> result = [];

  List<LatLng> polylineCoordinates = [];

  bool isTo = false, error = false;

  final FocusNode fromFocus = FocusNode();
  final FocusNode toFocus = FocusNode();

  // @override
  // void initState() {
  //   taxiInfo = widget.taxiInfo;
  //   fromController.text = widget.taxiInfo.from;
  //   toController.text = widget.taxiInfo.to;
  //   isTo = widget.isTo;
  //   onChanged(isTo ? toController.text : fromController.text);
  //   super.initState();
  // }

  void onChanged(String value) async {
    try {
      await GoogleMapsPlaces(
          apiKey: "AIzaSyDgXRQripKQUEAphzbyxG489nah_ZmnmRI"
      ).searchByText(
          value,
          language: "ru"
      ).then((value) => setState(() {
        result = value.results;
        error = false;
      }));
    }
    catch (e) {
      setState(() => error = true);
    }
  }

  void adressOnTapped(int index) async {
    if (isTo) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PickDate()));
    }
    else {
      fromController.text = result[index].name;
      isTo = true;
      onChanged(toController.text);
      FocusScope.of(context).requestFocus(toFocus);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black
              )
          ),
          centerTitle: true,
          title: const Text(
              "Маршрут",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20
              )
          )
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Откуда",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F7),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                        children: [
                          const Icon(Icons.search),
                          const SizedBox(width: 10),
                          Expanded(
                              child: TextField(
                                  autofocus: !isTo,
                                  controller: fromController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  focusNode: fromFocus,
                                  onTap: () {
                                    setState(() => isTo = false);
                                    onChanged(fromController.text);
                                  },
                                  onChanged: (value) => onChanged(value)
                              )
                          ),
                          AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: fromController.text == "" ? 0 : 1,
                              child: GestureDetector(
                                  onTap: () => setState(() => fromController.text = ""),
                                  child: const Icon(Icons.close)
                              )
                          )
                        ]
                    )
                ),
                const SizedBox(height: 10),
                const Text(
                  "Куда",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F7),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Row(
                        children: [
                          const Icon(Icons.search),
                          const SizedBox(width: 10),
                          Expanded(
                              child: TextField(
                                  autofocus: isTo,
                                  controller: toController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  focusNode: toFocus,
                                  onTap: () {
                                    setState(() => isTo = true);
                                    onChanged(toController.text);
                                  },
                                  onChanged: (value) => onChanged(value)
                              )
                          ),
                          AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: toController.text == "" ? 0 : 1,
                              child: GestureDetector(
                                  onTap: () => setState(() => toController.text = ""),
                                  child: const Icon(Icons.close)
                              )
                          )
                        ]
                    )
                ),
                Expanded(
                    child: error
                        ? const Center(
                        child: Text(
                            "Нет результатов"
                        )
                    )
                        : ListView.builder(
                        itemCount: result.length,
                        itemBuilder: (BuildContext context, int index) => GestureDetector(
                            onTap: () => adressOnTapped(index),
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                child: Row(
                                    children: [
                                      Flexible(
                                          child: Text(
                                              result[index].name,
                                              style: TextStyle(
                                                  color: const Color(0xFF0D1333).withOpacity(.5),
                                                  fontSize: 18
                                              )
                                          )
                                      ),
                                      const Spacer(),
                                      if (isTo
                                          ? toController.text.isNotEmpty
                                          : fromController.text.isNotEmpty)
                                        Container(
                                            margin: const EdgeInsets.only(left: 20),
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: const Color(0xFF49CC96).withOpacity(1)
                                            ),
                                            child: const Icon(
                                                Icons.play_arrow,
                                                color: Colors.white
                                            )
                                        )
                                    ]
                                )
                            )
                        )
                    )
                )
              ]
          )
      )
  );
}