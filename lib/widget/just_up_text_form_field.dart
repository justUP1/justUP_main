import 'package:flutter/material.dart';

class JustUpTextFormField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  JustUpTextFormField({
    required this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  });

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
        cursorColor: const Color(0xFF6F35A5),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: const Color(0xFF6F35A5),
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}