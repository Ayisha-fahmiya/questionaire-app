import 'package:flutter/material.dart';

import '../responsive/responsive.dart';

class TextFieldStyle extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  const TextFieldStyle({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: R.sw(16, context)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(75, 158, 158, 158),
            blurRadius: R.sw(4, context),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: R.sw(12, context)),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
