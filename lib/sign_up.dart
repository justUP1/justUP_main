import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_up/widget/just_up_button.dart';
import 'package:just_up/widget/just_up_text_form_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  PageController controller = PageController();

  bool isSplashScreen = false, isGoSignUp = false, isSignUp = false;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1))
        .then((value) => setState(() => isSplashScreen = true))
        .then((value) => Future.delayed(const Duration(seconds: 1)))
        .then((value) => setState(() => isGoSignUp = true))
        .then((value) => Future.delayed(const Duration(milliseconds: 500)))
        .then((value) => setState(() => isSignUp = true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Material(
    child: Stack(
      children: [
        Positioned(
            top: 10,
            left: 0,
            child: Image.asset(
              "images/main_top.png",
              width: MediaQuery.of(context).size.width * 0.3,
            )
        ),
        Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                "images/login_bottom.png",
                width: MediaQuery.of(context).size.width * 0.4
            )
        ),
        AnimatedPositioned(
            top: isGoSignUp ? 20 : MediaQuery.of(context).size.height / 2 - 100,
            left: 0,
            right: 0,
            duration: const Duration(milliseconds: 500),
            child: AnimatedOpacity(
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
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
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
                          ),
                          JustUpButton(
                            text: "Зарегистрироваться",
                            press: () {
                              controller.nextPage(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.ease
                              );
                            },
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                        ]
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
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const SignUp())
                            );
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
  );
}