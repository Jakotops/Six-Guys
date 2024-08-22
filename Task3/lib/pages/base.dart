import 'package:flutter/material.dart';
import 'package:stockit/pages/portfolio.dart';

class Base extends StatefulWidget {
  const Base({super.key});

  @override
  State<Base> createState() => _BaseState();
}

class _BaseState extends State<Base> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Portfolio()
        ],
      ),
    );
  }
}
