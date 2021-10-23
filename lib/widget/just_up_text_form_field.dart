import 'package:flutter/material.dart';

class JustUpTextFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  const JustUpTextFormField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: const Color(0xFFF1E6FF),
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextField(
        onChanged: onChanged,
        cursorColor: const Color(0xff2247e4),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: const Color(0xff2247e4),
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}