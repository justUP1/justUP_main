import 'package:flutter/material.dart';

class JustUpButton extends StatelessWidget {
  final String text;
  final void Function()? press;
  final Color color, textColor;

  const JustUpButton({
    Key? key,
    required this.text,
    this.press,
    this.color = const Color(0xff2247e4),
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          primary: color,
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          textStyle: TextStyle(
              color: textColor,
              fontSize: 14,
              fontWeight: FontWeight.w500)),
    );
  }
}