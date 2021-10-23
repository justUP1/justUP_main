import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_up/checkout/pick_date.dart';
import 'package:just_up/checkout/pick_map.dart';
import 'package:just_up/checkout/pick_places.dart';
import 'package:just_up/models/flight_model.dart';
import 'package:just_up/widget/just_up_button.dart';
import 'package:google_maps_webservice/places.dart';

class PickFlight extends StatefulWidget {
  const PickFlight({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PickFlightState();
}

class _PickFlightState extends State<PickFlight> {

  List<FlightModel> flightModels = [
    FlightModel(
        imgUrl: "https://yamoscow.ru/wp-content/uploads/2020/08/neboskryoby-moskva-siti.jpg",
      title: "Москва - Сочи",
      desc: "27.10.21 - 03.11.21",
      price: "70000",
      types: [0]
    ),
    FlightModel(
        imgUrl: "https://yamoscow.ru/wp-content/uploads/2020/08/neboskryoby-moskva-siti.jpg",
        title: "Москва - Сочи",
        desc: "29.10.21 - 06.11.21",
        price: "112000",
        types: [0, 1]
    ),
    FlightModel(
        imgUrl: "https://yamoscow.ru/wp-content/uploads/2020/08/neboskryoby-moskva-siti.jpg",
        title: "Москва - Воронеж - Сочи",
        desc: "28.10.21 - 09.11.21",
        price: "98000",
        types: [0, 2]
    )
  ];

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
              "Выберите маршрут",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20
              )
          )
      ),
      body: SizedBox(
        height: 500,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: flightModels.length,
            itemBuilder: (context, index) {
              return PopularTours(
                desc: flightModels[index].desc,
                imgUrl: flightModels[index].imgUrl,
                title: flightModels[index].title,
                price: flightModels[index].price,
                types: flightModels[index].types,
              );
            }),
      )
  );
}

class PopularTours extends StatelessWidget {
  final String imgUrl;
  final String title;
  final String desc;
  final String price;
  final List<int> types;
  const PopularTours({
    Key? key,
        required this.imgUrl,
        required this.types,
        required this.desc,
        required this.price,
        required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const PickMap()
            )
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 8, left: 10, right: 10),
        padding: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: const Color(0xffE9F4F9),
            borderRadius: BorderRadius.circular(20)
      ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              child: Image.network(
                imgUrl,
                width: 110.0,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff4E6059)),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    desc,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff89A097)),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "$priceр.",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff4E6059)),
                  )
                ],
              ),
            ),
            const Spacer(),
            Container(
                margin: const EdgeInsets.only(bottom: 10, right: 8),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xff139157)),
                child: Column(
                  children: [
                    if (types.contains(0))
                      const Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Icon(
                            Icons.airplanemode_active,
                            color: Colors.white,
                            size: 20,
                          )
                      ),
                    if (types.contains(1))
                      const Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Icon(
                            Icons.train,
                            color: Colors.white,
                            size: 20,
                          )
                      ),
                    if (types.contains(2))
                      const Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: Icon(
                            Icons.directions_car,
                            color: Colors.white,
                            size: 20,
                          )
                      )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}