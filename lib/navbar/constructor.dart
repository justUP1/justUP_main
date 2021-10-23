import 'package:flutter/material.dart';
import 'package:just_up/checkout/pick_date.dart';

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
        Positioned(
          bottom: 20,
          child: GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PickDate())),
            child: Container(
              height: 100,
              width: 200,
              color: Colors.red,
            ),
          ),
        )
      ],
    ),
  );
}