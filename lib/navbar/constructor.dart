import 'package:flutter/material.dart';

class Constructor extends StatefulWidget {
  const Constructor({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConstructorState();
}

class _ConstructorState extends State<Constructor> {
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Stack(
      children: [
        Container(),
        Container(),
        Container(),
        Container()
      ],
    ),
  );
}