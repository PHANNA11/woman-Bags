import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {super.key,
      this.controller,
      this.hindText,
      this.iconData,
      this.obscureText});
  TextEditingController? controller;
  String? hindText;
  IconData? iconData;
  bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey),
        child: TextField(
          controller: controller,
          cursorWidth: 3,
          cursorHeight: 20,
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
              prefixIcon: iconData != null
                  ? Icon(
                      iconData,
                      color: Colors.black,
                    )
                  : null,
              border: InputBorder.none,
              hintText: hindText ?? 'Enter sometext'),
        ),
      ),
    );
  }
}
