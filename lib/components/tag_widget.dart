import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  final String tag;

  const TagWidget(this.tag, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.only(right: 6),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        tag,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
