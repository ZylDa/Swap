import 'package:flutter/material.dart';

Widget buildItemCard(String title, String imageUrl) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    width: 128,
    height: 184,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: const [
        BoxShadow(
          color: Color(0x19000000),
          blurRadius: 20,
          offset: Offset(0, 4),
          spreadRadius: 0,
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 128,
          height: 128,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.fill,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
        ),
        SizedBox(
          width: 128,
          height: 29,
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF151515),
              fontSize: 14,
              fontFamily: 'Basic',
              fontWeight: FontWeight.w400,
              letterSpacing: 0.70,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}
