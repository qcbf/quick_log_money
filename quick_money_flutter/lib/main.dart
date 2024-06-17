import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quick_money_flutter/Pages/Home.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      return const _Debug();
    }
    return CreateApp();
  }

  static MaterialApp CreateApp({ThemeMode? themeMode}) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: _GetTheme(Brightness.light),
      darkTheme: _GetTheme(Brightness.dark),
      home: const Home(),
    );
  }

  static ThemeData _GetTheme(Brightness brightness) {
    return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white, brightness: brightness, dynamicSchemeVariant: DynamicSchemeVariant.fidelity),
        cardTheme: const CardTheme(margin: EdgeInsets.fromLTRB(0, 4, 0, 4)));
  }
}

final class _Debug extends StatefulWidget {
  const _Debug();

  @override
  State<_Debug> createState() => _DebugState();
}

class _DebugState extends State<_Debug> {
  late ThemeMode _themeMode = ThemeMode.dark;

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
        focusNode: FocusNode(),
        onKeyEvent: (value) {
          if (value is KeyDownEvent && value.logicalKey == LogicalKeyboardKey.keyT) {
            setState(() {
              _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
            });
          }
        },
        child: MainApp.CreateApp(themeMode: _themeMode));
  }
}
