import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Wrap(
        children: [
          const Text("label 1"),
          TextButton(onPressed: () {}, child: const Text("Btn1")),
          TextButton(onPressed: () {}, child: const Text("Btn2")),
          TextButton(onPressed: () {}, child: const Text("Btn3")),
          const Text("label 2"),
        ],
      ),
      
    );
  }
}
