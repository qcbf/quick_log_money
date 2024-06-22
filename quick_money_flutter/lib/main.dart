import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerData.dart';
import 'package:quick_log_money/Datas/UserData.dart';
import 'package:quick_log_money/Utilities/LocalDB.dart';
import 'package:quick_log_money/Utilities/Preference.dart';
import 'package:quick_log_money/pages/HomePage.dart';
import 'package:quick_log_money/pages/LoginPage.dart';
import 'package:quick_log_money/pages/RecordMoney/RecordPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalDBHelper.Init();
  await Preference.InitGlobal();
  runApp(const MainApp());
}

///
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      return const _DebugCreateApp();
    }
    return CreateApp();
  }

  static MaterialApp CreateApp({ThemeMode? themeMode}) {
    late Widget firstPage;
    if (UserProvider.IsLogined) {
      firstPage = GlobalPreference.IsFirstPageIsRecord ? const RecordPage() : const HomePage();
    } else {
      firstPage = const LoginPage();
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: _GetTheme(Brightness.light),
        darkTheme: _GetTheme(Brightness.dark),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => UserProvider()),
            ChangeNotifierProvider(create: (context) => LedgerProvider(), lazy: false),
          ],
          child: firstPage,
        ));
  }

  static ThemeData _GetTheme(Brightness brightness) {
    var colorScheme = ColorScheme.fromSeed(seedColor: Colors.grey, brightness: brightness, dynamicSchemeVariant: DynamicSchemeVariant.fidelity);
    return ThemeData(
        colorScheme: colorScheme,
        cardTheme: const CardTheme(margin: EdgeInsets.fromLTRB(0, 4, 0, 4)),
        textButtonTheme: TextButtonThemeData(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(colorScheme.surfaceContainer))));
  }
}

///
final class _DebugCreateApp extends StatefulWidget {
  const _DebugCreateApp();

  @override
  State<_DebugCreateApp> createState() => _DebugCreateAppState();
}

class _DebugCreateAppState extends State<_DebugCreateApp> {
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
