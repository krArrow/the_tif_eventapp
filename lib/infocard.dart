import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class InfoCard extends StatefulWidget {
  const InfoCard({super.key});

  @override
  State<InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<InfoCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.circular(5.0)),
            height: 30,
            width: 150,
            child: Center(
                child: Text(
              "😁 Arriving Soon 😁",
              style: TextStyle(color: Colors.white),
            ))),
      )),
    );
  }
}
