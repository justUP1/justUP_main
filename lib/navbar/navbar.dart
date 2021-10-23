import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:just_up/checkout/pick_date.dart';
import 'package:just_up/checkout/pick_route.dart';
import 'package:just_up/navbar/places.dart';
import 'package:just_up/navbar/routes.dart';
import 'package:just_up/widget/just_up_button.dart';

import 'adventures.dart';
import 'constructor.dart';
import 'friends.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  PageController controller = PageController();

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

  PageController backgroundController = PageController();
  PageController carController = PageController();
  PageController manController = PageController();

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
                      PageView(
                        controller: controller,
                        children: [
                          const Friends(),
                          const Adventures(),
                          Scaffold(
                            body: Stack(
                              children: [
                                PageView(
                                  controller: backgroundController,
                                  children: [
                                    Image.asset("images/background1.png", fit: BoxFit.cover,),
                                    Image.asset("images/background2.png", fit: BoxFit.cover),
                                    Image.asset("images/background3.png", fit: BoxFit.cover)
                                  ],
                                ),
                                PageView(
                                  controller: carController,
                                  children: [
                                    Image.asset("images/car1.png"),
                                    Image.asset("images/car2.png"),
                                    Image.asset("images/car3.png")
                                  ]
                                ),
                                PageView(
                                  controller: manController,
                                    children: [
                                      Image.asset("images/man1.png"),
                                      Image.asset("images/man2.png"),
                                      Image.asset("images/man3.png")
                                    ]
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height - 50,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  backgroundController.previousPage(
                                                      duration: const Duration(milliseconds: 500),
                                                      curve: Curves.ease
                                                  );
                                                },
                                                child: Container(
                                                    margin: const EdgeInsets.only(left: 20),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: const Color(0xFF49CC96).withOpacity(1)
                                                    ),
                                                    child: const Icon(
                                                        Icons.arrow_back_ios,
                                                        color: Colors.white
                                                    )
                                                )
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                                onTap: () {
                                                  backgroundController.nextPage(
                                                      duration: const Duration(milliseconds: 500),
                                                      curve: Curves.ease
                                                  );
                                                },
                                                child: Container(
                                                    margin: const EdgeInsets.only(left: 20),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: const Color(0xFF49CC96).withOpacity(1)
                                                    ),
                                                    child: const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.white
                                                    )
                                                )
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  carController.previousPage(
                                                      duration: const Duration(milliseconds: 500),
                                                      curve: Curves.ease
                                                  );
                                                },
                                                child: Container(
                                                    margin: const EdgeInsets.only(left: 20),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: const Color(0xFF49CC96).withOpacity(1)
                                                    ),
                                                    child: const Icon(
                                                        Icons.arrow_back_ios,
                                                        color: Colors.white
                                                    )
                                                )
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                                onTap: () {
                                                  carController.nextPage(
                                                      duration: const Duration(milliseconds: 500),
                                                      curve: Curves.ease
                                                  );
                                                },
                                                child: Container(
                                                    margin: const EdgeInsets.only(left: 20),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: const Color(0xFF49CC96).withOpacity(1)
                                                    ),
                                                    child: const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.white
                                                    )
                                                )
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  manController.previousPage(
                                                      duration: const Duration(milliseconds: 500),
                                                      curve: Curves.ease
                                                  );
                                                },
                                                child: Container(
                                                    margin: const EdgeInsets.only(left: 20),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: const Color(0xFF49CC96).withOpacity(1)
                                                    ),
                                                    child: const Icon(
                                                        Icons.arrow_back_ios,
                                                        color: Colors.white
                                                    )
                                                )
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                                onTap: () {
                                                  manController.nextPage(
                                                      duration: const Duration(milliseconds: 500),
                                                      curve: Curves.ease
                                                  );
                                                },
                                                child: Container(
                                                    margin: const EdgeInsets.only(left: 20),
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: const Color(0xFF49CC96).withOpacity(1)
                                                    ),
                                                    child: const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: Colors.white
                                                    )
                                                )
                                            )
                                          ],
                                        ),
                                        JustUpButton(
                                            text: "Моё путешествие",
                                          press: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PickRoute())),
                                        )
                                      ]
                                  )
                                ),
                              ],
                            ),
                          ),
                          const Routes(),
                          const Places()
                        ]
                      ),
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
                                  onTap: () {
                                    setState(() => selectedIndex = i);
                                    controller.animateToPage(
                                        selectedIndex,
                                        duration: const Duration(milliseconds: 250),
                                        curve: Curves.ease
                                    );
                                  },
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