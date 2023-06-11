// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  final Widget navigateTo;
  const TextLink({
    Key? key,
    required this.text,
    required this.navigateTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => navigateTo),
        );
      },
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 13,
        ),
      ),
    );
  }
}
