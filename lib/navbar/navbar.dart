import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_up/checkout/pick_places.dart';
import 'package:just_up/checkout/pick_route.dart';
import 'package:just_up/navbar/places.dart';
import 'package:just_up/navbar/routes.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'adventures.dart';
import 'friends.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> with SingleTickerProviderStateMixin {
  PageController controller = PageController(initialPage: 2);

  int selectedIndex = 2;

  double xOffset = 0, yOffset = 0, scaleFactor = 1;

  bool showDrawer = false;

  List<IconData> data = [
    Icons.person,
    Icons.airplanemode_active,
    Icons.add_box_outlined,
    Icons.alt_route,
    Icons.location_on,
  ];

  PageController backgroundController = PageController(initialPage: 100);
  PageController carController = PageController(initialPage: 100);
  PageController manController = PageController(initialPage: 100);

  bool toggle = false;

  AnimationController? _controller;
  Animation? _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 350),
        reverseDuration: const Duration(milliseconds: 275)
    );

    _animation = CurvedAnimation(
      parent: _controller!.view,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );

    _controller!.addListener(() {
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Alignment alignment1 = const Alignment(0.0, 0.0);
  Alignment alignment2 = const Alignment(0.0, 0.0);
  Alignment alignment3 = const Alignment(0.0, 0.0);
  Alignment alignment4 = const Alignment(0.0, 0.0);
  Alignment alignment5 = const Alignment(0.0, 0.0);
  double size1 = 50.0;
  double size2 = 50.0;
  double size3 = 50.0;
  double size4 = 50.0;
  double size5 = 50.0;
  bool animal = false;
  bool family = false;
  bool love = false;

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
      backgroundColor: Colors.white,
      body: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                  "images/board.png",
                  width: MediaQuery.of(context).size.width * 0.3
              ),
            ),
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
                              )
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "ФИО",
                          ),
                          const SizedBox(height: 5),
                          const Text(
                              "Котиков Андрей",
                              style: TextStyle(
                                fontSize: 20,
                              )
                          ),
                          const Text(
                              "Владимирович",
                              style: TextStyle(
                                fontSize: 20,
                              )
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Количество путешествий",
                          ),
                          const SizedBox(height: 5),
                          const Text(
                              "Отсутствуют",
                              style: TextStyle(
                                fontSize: 20,
                              )
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Телефон",
                          ),
                          const SizedBox(height: 5),
                          const Text(
                              "+7(962) 212 57-22",
                              style: TextStyle(
                                fontSize: 20,
                              )
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Почта",
                          ),
                          const SizedBox(height: 5),
                          const Text(
                              "kotikov777@gmail.com",
                              style: TextStyle(
                                fontSize: 20,
                              )
                          )
                        ]
                    )
                )
            ),
            AnimatedPositioned(
              top: 10,
              left: showDrawer ? 500 : 200,
              duration: const Duration(seconds: 10),
              child: Image.asset(
                  "images/birds.png",
                  width: MediaQuery.of(context).size.width * 0.3
              ),
            ),
            GestureDetector(
              onTap: () => closeDrawer(),
              child: AnimatedContainer(
                transform: Matrix4.translationValues(
                    xOffset,
                    yOffset,
                    0
                )..scale(scaleFactor),
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
                      ),
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
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
                                    PageView.builder(
                                      controller: backgroundController,
                                      itemBuilder: (context, index) {
                                        return Image.asset("images/background${index % 3}.png", fit: BoxFit.cover);
                                      },
                                    ),
                                    PageView(
                                        controller: carController,
                                        children: [
                                          Container(
                                              height: MediaQuery.of(context).size.height,
                                              alignment: Alignment.topCenter,
                                              child: Image.asset("images/car2.png")
                                          ),
                                          Container(
                                              height: MediaQuery.of(context).size.height,
                                              alignment: Alignment.centerLeft,
                                              child: Image.asset("images/car1.png")
                                          )
                                        ]
                                    ),
                                    PageView.builder(
                                        controller: manController,
                                        itemBuilder: (context, index) => Padding(
                                          padding: const EdgeInsets.only(top: 30),
                                          child: Image.asset(
                                              "images/man${index % 3}.png"
                                          )
                                        )
                                    ),
                                    Positioned(
                                      top: 200,
                                      left: 100,
                                      child: AnimatedOpacity(
                                        opacity: love ? 1 : 0,
                                        duration: const Duration(milliseconds: 500),
                                        child: Image.asset(
                                            "images/love_human.png"
                                        )
                                      )
                                    ),
                                    Positioned(
                                      top: 200,
                                      right: 20,
                                      child: AnimatedOpacity(
                                          opacity: family ? 1 : 0,
                                        duration: const Duration(milliseconds: 500),
                                        child: Image.asset(
                                            "images/family_human.png"
                                        )
                                      ),
                                    ),
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height - 400,
                                        width: MediaQuery.of(context).size.width,
                                        child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const SizedBox(height: 30),
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                      onTap: () {
                                                        if (backgroundController.page == 0) {
                                                          backgroundController.animateToPage(
                                                              2,
                                                              duration: const Duration(milliseconds: 500),
                                                              curve: Curves.ease
                                                          );
                                                        }
                                                        else {
                                                          backgroundController.previousPage(
                                                              duration: const Duration(milliseconds: 500),
                                                              curve: Curves.ease
                                                          );
                                                        }
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
                                                        if (backgroundController.page == 2) {
                                                          backgroundController.animateToPage(
                                                              0,
                                                              duration: const Duration(milliseconds: 500),
                                                              curve: Curves.ease
                                                          );
                                                        }
                                                        else {
                                                          backgroundController.nextPage(
                                                              duration: const Duration(milliseconds: 500),
                                                              curve: Curves.ease
                                                          );
                                                        }
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
                                                  ),
                                                  const SizedBox(width: 10)
                                                ],
                                              ),
                                              const SizedBox(height: 30),
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
                                                  ),
                                                  const SizedBox(width: 10)
                                                ],
                                              ),
                                              const SizedBox(height: 30),
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
                                                  ),
                                                  const SizedBox(width: 10)
                                                ],
                                              ),
                                            ]
                                        ),
                                    ),
                                    Positioned(
                                      top: 425,
                                      left: 0,
                                      right: 0,
                                      child: SizedBox(
                                        height: 250,
                                        width: 250,
                                        child: Stack(
                                          children: [
                                            AnimatedAlign(
                                              duration: toggle
                                                  ? const Duration(milliseconds: 275)
                                                  : const Duration(milliseconds: 875),
                                              alignment: alignment1,
                                              curve: toggle ? Curves.easeIn : Curves.easeOut,
                                              child: AnimatedContainer(
                                                duration: const Duration(milliseconds: 275),
                                                height: size1,
                                                width: size1,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(40)
                                                ),
                                                child: Stack(
                                                  children: [
                                                    SvgPicture.asset(
                                                        "images/animal.svg"
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: GestureDetector(
                                                        onTap: () => setState(() {
                                                          animal = !animal;
                                                        }),
                                                          child: SvgPicture.asset(
                                                              animal
                                                                  ? "images/active_heart.svg"
                                                                  : "images/inactive_heart.svg"
                                                          )
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            AnimatedAlign(
                                              duration: toggle
                                                  ? const Duration(milliseconds: 275)
                                                  : const Duration(milliseconds: 875),
                                              alignment: alignment4,
                                              curve: toggle ? Curves.easeIn : Curves.easeOut,
                                              child: AnimatedContainer(
                                                duration: const Duration(milliseconds: 275),
                                                height: size4,
                                                width: size4,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(40)
                                                ),
                                                child: SvgPicture.asset(
                                                    "images/money.svg"
                                                ),
                                              ),
                                            ),
                                            AnimatedAlign(
                                              duration: toggle
                                                  ? const Duration(milliseconds: 275)
                                                  : const Duration(milliseconds: 875),
                                              alignment: alignment2,
                                              curve: toggle ? Curves.easeIn : Curves.easeOut,
                                              child: AnimatedContainer(
                                                  duration: const Duration(milliseconds: 275),
                                                  height: size2,
                                                  width: size2,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40)
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      SvgPicture.asset(
                                                          "images/family.svg"
                                                      ),
                                                      Positioned(
                                                        top: 0,
                                                        right: 0,
                                                        child: GestureDetector(
                                                            onTap: () => setState(() {
                                                              family = !family;
                                                            }),
                                                            child: SvgPicture.asset(
                                                                family
                                                                    ? "images/active_heart.svg"
                                                                    : "images/inactive_heart.svg"
                                                            )
                                                        )
                                                      ),
                                                    ],
                                                  )
                                              ),
                                            ),
                                            AnimatedAlign(
                                              duration: toggle
                                                  ? const Duration(milliseconds: 275)
                                                  : const Duration(milliseconds: 875),
                                              alignment: alignment3,
                                              curve: toggle ? Curves.easeIn : Curves.easeOut,
                                              child: AnimatedContainer(
                                                  duration: const Duration(milliseconds: 275),
                                                  height: size3,
                                                  width: size3,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(40)
                                                  ),
                                                  child: Stack(
                                                    children: [
                                                      SvgPicture.asset(
                                                          "images/love.svg"
                                                      ),
                                                      GestureDetector(
                                                          onTap: () => setState(() {
                                                            love = !love;
                                                          }),
                                                          child: SvgPicture.asset(
                                                              love
                                                                  ? "images/active_heart.svg"
                                                                  : "images/inactive_heart.svg"
                                                          )
                                                      )
                                                    ],
                                                  )
                                              ),
                                            ),
                                            AnimatedAlign(
                                              duration: toggle
                                                  ? const Duration(milliseconds: 275)
                                                  : const Duration(milliseconds: 875),
                                              alignment: alignment5,
                                              curve: toggle ? Curves.easeIn : Curves.easeOut,
                                              child: AnimatedContainer(
                                                duration: const Duration(milliseconds: 275),
                                                height: size5,
                                                width: size5,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(40)
                                                ),
                                                child: GestureDetector(
                                                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PickRoute())),
                                                  child: SvgPicture.asset(
                                                      "images/trip.svg"
                                                  ),
                                                )
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.center,
                                              child: Transform.rotate(
                                                angle: _animation!.value * pi * (3/4),
                                                child: AnimatedContainer(
                                                  duration: const Duration(milliseconds: 375),
                                                  curve: Curves.easeOut,
                                                  height: toggle ? 70 : 60,
                                                  width: toggle ? 70 : 60,
                                                  decoration: BoxDecoration(
                                                      color: const Color(0xff2247e4),
                                                      borderRadius: BorderRadius.circular(60.0)
                                                  ),
                                                  child: Material(
                                                      color: Colors.transparent,
                                                      child: IconButton(
                                                          splashColor: Colors.black54,
                                                          splashRadius: 31.0,
                                                          onPressed: () {
                                                            setState(() {
                                                              if (toggle) {
                                                                toggle = !toggle;
                                                                _controller!.forward();
                                                                Future.delayed(const Duration(milliseconds: 10), () {
                                                                  alignment1 = const Alignment(-0.4, -0.4);
                                                                  size1 = 50.0;
                                                                });
                                                                Future.delayed(const Duration(milliseconds: 10), () {
                                                                  alignment4 = const Alignment(-0.8, -0.4);
                                                                  size4 = 50.0;
                                                                });
                                                                Future.delayed(const Duration(milliseconds: 100), () {
                                                                  alignment2 = const Alignment(0.0, -0.8);
                                                                  size2 = 50.0;
                                                                });
                                                                Future.delayed(const Duration(milliseconds: 200), () {
                                                                  alignment3 = const Alignment(0.4, -0.4);
                                                                  size3 = 50.0;
                                                                });
                                                                Future.delayed(const Duration(milliseconds: 10), () {
                                                                  alignment5 = const Alignment(0.8, -0.4);
                                                                  size5 = 50.0;
                                                                });
                                                              } else {
                                                                toggle = !toggle;
                                                                _controller!.reverse();
                                                                alignment1 = const Alignment(0.0, 0.0);
                                                                alignment2 = const Alignment(0.0, 0.0);
                                                                alignment3 = const Alignment(0.0, 0.0);
                                                                alignment4 = const Alignment(0.0, 0.0);
                                                                alignment5 = const Alignment(0.0, 0.0);
                                                                size1 = size2 = size3 = size4 = size5 = 20.0;
                                                              }
                                                            });
                                                          },
                                                          icon: const Icon(Icons.add, color: Colors.white,)
                                                      )
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    )
                                  ],
                                ),
                              ),
                              const Routes(),
                              const Places()
                            ]
                        )
                      ]
                  ),
                  bottomNavigationBar: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 20,
                          color: Colors.black.withOpacity(.1),
                        )
                      ],
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                        child: GNav(
                          rippleColor: Colors.grey[300]!,
                          hoverColor: Colors.grey[100]!,
                          gap: 8,
                          activeColor: const Color(0xff2247e4),
                          iconSize: 24,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                          duration: const Duration(milliseconds: 400),
                          tabBackgroundColor: Colors.blue[50]!,
                          color: const Color(0xff2247e4),
                          tabs: const [
                            GButton(
                              icon: Icons.person,
                              text: 'Друзья',
                            ),
                            GButton(
                              icon: Icons.airplanemode_active,
                              text: 'Путешествия',
                            ),
                            GButton(
                              icon: Icons.add_box_outlined,
                              text: 'Выбор',
                            ),
                            GButton(
                              icon: Icons.alt_route,
                              text: 'Маршруты',
                            ),
                            GButton(
                              icon: Icons.location_on,
                              text: 'Места',
                            ),
                          ],
                          selectedIndex: selectedIndex,
                          onTabChange: (index) {
                            setState(() {
                              selectedIndex = index;
                              controller.animateToPage(
                                  index,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease
                              );
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ])
  );
}