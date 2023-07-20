import 'package:flutter/material.dart';

class TagTextField extends StatelessWidget {
  final dynamic controller;

  const TagTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(right: 5),
        width: 93,
        height: 40,
        child: TextField(
          controller: controller,
          maxLines: 1,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            //prefixIcon: const Icon(Icons.tag),
            labelStyle: const TextStyle(
                //color: Colors.black,
                ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: const Color.fromARGB(99, 177, 172, 172),
            contentPadding: const EdgeInsets.only(left: 15, right: 0, bottom: 0, top: 0),
          ),
          cursorColor: Colors.black,
          
        ));
  }
}

// class TagTextField extends StatefulWidget {
//   TagTextField(this.tag, {super.key});
//   final String tag;
//   final tagController = TextEditingController();

//   String getTagController() {
//     return tagController.text;
//   }

//   @override
//   State<TagTextField> createState() {
//     return _TagTextFieldState();
//   }
// }

// class _TagTextFieldState extends State<TagTextField> {
//   //final nameController = TextEditingController();

//   // String getTag() {
//   //   return widget.nameController.text;
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         margin: const EdgeInsets.only(right: 20),
//         width: 60,
//         child: TextField(
//           controller: widget.tagController..text = widget.tag,
//           decoration: InputDecoration(
//             labelStyle: const TextStyle(
//               color: Colors.black,
//             ),
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(15),
//               borderSide: BorderSide.none,
//             ),
//             filled: true,
//             fillColor: const Color.fromARGB(99, 177, 172, 172),
//           ),
//           cursorColor: Colors.black,
//         ));
//   }
// }





