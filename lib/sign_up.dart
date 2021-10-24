import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:just_up/widget/just_up_button.dart';
import 'package:just_up/widget/just_up_text_form_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  PageController controller = PageController();

  bool isSplashScreen = false, isGoSignUp = false, isSignUp = false, isGoTrip = false;

  @override
  void initState() {
    getPost();
    Future.delayed(const Duration(seconds: 1))
        .then((value) => setState(() => isSplashScreen = true))
        .then((value) => Future.delayed(const Duration(seconds: 1)))
        .then((value) => setState(() => isGoSignUp = true))
        .then((value) => Future.delayed(const Duration(milliseconds: 500)))
        .then((value) => setState(() => isSignUp = true));
    super.initState();
  }

  void getPost() async {
    await post(
        Uri.parse("http://fvedenev.pythonanywhere.com/sign_in-flask"),
      body: json.encoder.convert({
        'transport': 'car',
        'climate': 'warm',
        'type': 'active',
        'adults': 5,
        'childs': 6,
        'pets': 3,
        'money':1000,
        'dista': 'placeA',
        'distb': 'placeB',
        'date': '13/12/23',
        'duration': 1000
      }),
      headers: {'Content-type': 'application/json'},
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Stack(
      children: [
        Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(
              "images/bottom_left.png",
              width: MediaQuery.of(context).size.width * 0.2
            )
        ),
        Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
                "images/top_right.png",
                width: MediaQuery.of(context).size.width * 0.3
            )
        ),
        AnimatedPositioned(
          top: isGoTrip ? 0 : -100,
          left: isGoTrip ? 0 : -100,
          duration: const Duration(milliseconds: 500),
          child: Image.asset(
              "images/top_left.png",
              width: MediaQuery.of(context).size.width * 0.3
          ),
        ),
        AnimatedPositioned(
            top: isGoSignUp ? 20 : MediaQuery.of(context).size.height / 2 - 100,
            left: 0,
            right: 0,
            duration: const Duration(milliseconds: 500),
            child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Column(
                children: [
                  AnimatedOpacity(
                      opacity: isSplashScreen ? 1 : 0,
                      duration: const Duration(seconds: 1),
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(seconds: 1),
                          height: isGoSignUp ? 50 : 150,
                          width: isGoSignUp ? 100 : 300,
                          child: Image.asset("images/just_up.png"),
                        ),
                      )
                  ),
                  AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: isSignUp ? 1 : 0,
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: PageView(
                            controller: controller,
                            children: [
                              SingleChildScrollView(
                                child: SizedBox(
                                  height: MediaQuery.of(context).size.height + 200,
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        const SizedBox(height: 25),
                                        const Text(
                                          "ЗАРЕГИСТРИРОВАТЬСЯ",
                                          style: TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                        SvgPicture.asset(
                                          "images/sign_up.svg",
                                          height: MediaQuery.of(context).size.height * 0.35,
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                        JustUpTextFormField(
                                          hintText: "Ваш email",
                                          onChanged: (value) {},
                                        ),
                                        JustUpTextFormField(
                                          hintText: "Ваш пароль",
                                          onChanged: (value) {},
                                          obscureText: true,
                                        ),
                                        JustUpButton(
                                          text: "Зарегистрироваться",
                                          press: () {
                                            controller.nextPage(
                                                duration: const Duration(milliseconds: 500),
                                                curve: Curves.ease
                                            );
                                            setState(() {
                                              isGoTrip = true;
                                            });
                                          },
                                        ),
                                        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                      ]
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "ОТПРАВИМСЯ В ПУТЕШЕСТВИЕ?",
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Image.asset(
                                    "images/trip.png",
                                    height: MediaQuery.of(context).size.height * 0.35,
                                  ),
                                  JustUpButton(
                                    text: "Да",
                                    press: () {
                                      Navigator.of(context).pushReplacementNamed('/sign_up');
                                    },
                                  ),
                                  JustUpButton(
                                    text: "Нет",
                                    press: () {
                                      Navigator.of(context).pushReplacementNamed('/sign_up');
                                    },
                                  ),
                                ],
                              )
                            ],
                          )
                      )
                  )
                ],
              ),
            )
        ),
      ],
    ),
  );
}