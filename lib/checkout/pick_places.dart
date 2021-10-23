import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:just_up/checkout/pick_flight.dart';
import 'package:just_up/widget/just_up_button.dart';

class PickPlaces extends StatefulWidget {
  const PickPlaces({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickPlacesState();
}

class _PickPlacesState extends State<PickPlaces> {
  TextEditingController controller = TextEditingController();

  List<String> places = [];

  bool isShow = false;

  void adressOnTapped(int index) async {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PickFlight()));
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
          title: const Text(
              "Обязательные пункты",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20
              )
          )
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  controller: controller,
                                  onChanged: (value) {
                                    if (!isShow) {
                                      setState(() {
                                        isShow = true;
                                        places.add("Скотина");
                                      });
                                    }
                                  }
                              )
                          ),
                          AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: controller.text == "" ? 0 : 1,
                              child: GestureDetector(
                                  onTap: () => setState(() => controller.text = ""),
                                  child: const Icon(Icons.close)
                              )
                          )
                        ]
                    )
                ),
                const SizedBox(height: 10),
                Expanded(
                    child: ListView.builder(
                        itemCount: places.length,
                        itemBuilder: (BuildContext context, int index) => GestureDetector(
                            onTap: () => adressOnTapped(index),
                            child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                width: double.infinity,
                                child: Row(
                                    children: [
                                      Flexible(
                                          child: Text(
                                              places[index],
                                              style: TextStyle(
                                                  color: const Color(0xFF0D1333).withOpacity(.5),
                                                  fontSize: 18
                                              )
                                          )
                                      ),
                                      const Spacer(),
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