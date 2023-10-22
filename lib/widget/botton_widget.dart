import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottonWidget extends StatelessWidget {
  BottonWidget({super.key, this.text, this.colors, required this.onTap});
  String? text;
  Color? colors;
  void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: colors ?? Theme.of(context).primaryColor),
            child: Center(
              child: Text(
                text ?? 'Text Botton',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )),
      ),
    );
  }
}
