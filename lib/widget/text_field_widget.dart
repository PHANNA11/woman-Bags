import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TextFieldWidget extends StatelessWidget {
  TextFieldWidget(
      {super.key,
      this.controller,
      this.hindText,
      this.iconData,
      this.obscureText,
      this.onChanged,
      this.keyboardType});
  TextEditingController? controller;
  String? hindText;
  IconData? iconData;
  bool? obscureText;
  void Function(String)? onChanged;
  TextInputType? keyboardType;

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
          keyboardType: keyboardType,
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
          onChanged: onChanged,
        ),
      ),
    );
  }
}
