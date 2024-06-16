import 'package:flutter/material.dart';
import 'package:quick_money_flutter/pages/Home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "title",
      theme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white, brightness: Brightness.light, dynamicSchemeVariant: DynamicSchemeVariant.fidelity)),
      // darkTheme: ThemeData.from(colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey, brightness: Brightness.dark, dynamicSchemeVariant: DynamicSchemeVariant.fidelity)),
      home: const Home(),
    );
  }
}
