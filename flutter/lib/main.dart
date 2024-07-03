import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerDao.dart';
import 'package:quick_log_money/Datas/Ledger/LedgerDataProvider.dart';
import 'package:quick_log_money/Datas/UserData.dart';
import 'package:quick_log_money/Utilities/Def.dart';
import 'package:quick_log_money/Utilities/Pages.dart';
import 'package:quick_log_money/Utilities/Prefs.dart';
import 'package:path_provider/path_provider.dart';

// entry
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var botOpt = BotToast.defaultOption;
  botOpt.simpleNotification.duration =
      botOpt.notification.duration = botOpt.customNotification.duration = const Duration(seconds: 8);
  botOpt.customLoading.duration = botOpt.loading.duration = const Duration(seconds: 10);

  Def.LocalPath = "${(await getApplicationSupportDirectory()).path}${Platform.pathSeparator}";
  print("Set Local Path: ${Def.LocalPath}");
  Hive.init(Def.LocalPath);

// test begin
  LedgerDatabase.managers.ledgerInfos.create((o) => LedgerInfo.fromJson({}).toCompanion(false));

  return;
//test end

  await UserDataProvider.Global.Init();
  await UserPrefsDataDef.TryInit();
  LedgerDataProvider.Global.Init();

  runApp(const MainApp());
}

/// app root ui
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      return const _DebugCreateApp();
    }
    return CreateApp();
  }

  static Widget CreateApp({ThemeMode? themeMode}) {
    ///
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: _GetTheme(Brightness.light),
      darkTheme: _GetTheme(Brightness.dark),
      onGenerateRoute: Pages.Router,
      initialRoute:
          UserDataProvider.Global.Id == 0 ? Pages.Login : (UserPrefs.IsFirstPageToRecord.value ? Pages.Record : Pages.Home),
      navigatorObservers: [BotToastNavigatorObserver()],
      builder: (context, child) {
        child = BotToastInit()(context, child);
        return child;
      },
    );
  }

  static ThemeData _GetTheme(Brightness brightness) {
    var colorScheme =
        ColorScheme.fromSeed(seedColor: Colors.grey, brightness: brightness, dynamicSchemeVariant: DynamicSchemeVariant.fidelity);
    return ThemeData(
        colorScheme: colorScheme,
        cardTheme: const CardTheme(margin: EdgeInsets.fromLTRB(0, 4, 0, 4)),
        textButtonTheme:
            TextButtonThemeData(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(colorScheme.surfaceContainer))));
  }
}

/*






*/

/// 调试模式包一层做一些调试设置
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
