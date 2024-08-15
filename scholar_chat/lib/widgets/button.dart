import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({this.OnTap, super.key, required this.text});
  String text;
  VoidCallback? OnTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        height: 60,
        child: Center(
            child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 22),
        )),
      ),
    );
  }
}
