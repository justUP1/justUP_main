import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:just_up/navbar/places.dart';
import 'package:just_up/navbar/routes.dart';

import 'adventures.dart';
import 'constructor.dart';
import 'friends.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int selectedIndex = 0;

  double xOffset = 0, yOffset = 0, scaleFactor = 1;

  bool showDrawer = false;

  List<IconData> data = [
    Icons.person,
    Icons.airplanemode_active,
    Icons.add_box_outlined,
    Icons.alt_route,
    Icons.location_on,
  ];

  void closeDrawer() => setState(() {
    xOffset = 0;
    yOffset = 0;
    scaleFactor = 1;
    showDrawer = false;
  });

  void openDrawer() => setState(() {
    xOffset = 230;
    yOffset = 150;
    scaleFactor = 0.6;
    showDrawer = true;
  });

  Widget buildPages(int selectedIndex) {
    switch (selectedIndex) {
      case 0:
        return const Friends();
      case 1:
        return const Adventures();
      case 2:
        return const Constructor();
      case 3:
        return const Routes();
      case 4:
        return const Places();
      default:
        return const Constructor();
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(0xffDC3C4D),
    body: Stack(
      children: [
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  ClipOval(
                    child: Image.asset("images/avatar.png"),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                      "Личный профиль",
                      style: TextStyle(
                          fontSize: 20,
                        color: Colors.white
                      )
                  ),
                  const SizedBox(height: 20),
                  const Text(
                      "ФИО",
                    style: TextStyle(color: Colors.white)
                  ),
                  const SizedBox(height: 5),
                  const Text(
                      "Котиков Андрей",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    )
                  ),
                  const Text(
                    "Владимирович",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    )
                  ),
                  const SizedBox(height: 20),
                  const Text(
                      "Количество путешествий",
                    style: TextStyle(color: Colors.white)
                  ),
                  const SizedBox(height: 5),
                  const Text(
                      "Отсутствуют",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      )
                  ),
                  const SizedBox(height: 20),
                  const Text(
                      "Телефон",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                      "+7(962) 212 57-22",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      )
                  ),
                  const SizedBox(height: 20),
                  const Text(
                      "Почта",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                      "kotikov777@gmail.com",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                      )
                  )
                ]
            )
          )
        ),
        GestureDetector(
            onTap: () => closeDrawer(),
            child: AnimatedContainer(
              transform: Matrix4.translationValues(xOffset, yOffset, 0)..scale(scaleFactor),
              duration: const Duration(milliseconds: 250),
              child: Scaffold(
                  appBar: AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      leading: GestureDetector(
                          onTap: () => openDrawer(),
                          child: const Icon(
                              Icons.menu,
                              color: Colors.black
                          )
                      ),
                      centerTitle: true,
                      title: Image.asset(
                        "images/just_up.png",
                        width: 100,
                        height: 50,
                      )
                  ),
                  body: Stack(
                    children: [
                      buildPages(selectedIndex),
                      Positioned(
                        bottom: 15,
                        left: 25,
                        right: 25,
                        child: Container(
                          height: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff2247e4),
                          ),
                          child: SizedBox(
                            height: 70,
                            width: double.infinity,
                            child: ListView.builder(
                              itemCount: data.length,
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              itemBuilder: (ctx, i) => Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: GestureDetector(
                                  onTap: () => setState(() => selectedIndex = i),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 250),
                                    width: 35,
                                    decoration: BoxDecoration(
                                      border: i == selectedIndex
                                          ? const Border(
                                          top: BorderSide(
                                              width: 3.0,
                                              color: Colors.white
                                          ))
                                          : null,
                                      gradient: i == selectedIndex
                                          ? LinearGradient(
                                          colors: [
                                            Colors.grey.shade800,
                                            const Color(0xff2247e4)
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter
                                      )
                                          : null,
                                    ),
                                    child: Icon(
                                      data[i],
                                      size: 35,
                                      color: i == selectedIndex
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                              scrollDirection: Axis.horizontal,
                            ),
                          ),
                        ),
                      )
                    ]
                  )
              ),
            )
        )
      ],
    ),
  );
}