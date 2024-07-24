import 'package:flutter/material.dart';
import 'package:quick_log_money/Pages/Home/HomePage.dart';
import 'package:quick_log_money/Utilities/Prefs.dart';
import 'package:quick_log_money/pages/LoginPage.dart';
import 'package:quick_log_money/pages/RecordMoney/RecordPage.dart';
import 'package:quick_log_money/pages/Setting/SettingPage.dart';

class Pages {
  static const Home = "/";
  static const Login = "/Login";
  static const Record = "/Record";
  static const Setting = "/Setting";
  static final Map<String, WidgetBuilder> Routes = {
    Home: (context) => const HomePage(),
    Login: (context) => const LoginPage(),
    Record: (context) => const RecordPage(),
    Setting: (context) => const SettingPage(),
  };

  static MaterialPageRoute? Router(RouteSettings settings) {
    WidgetBuilder? page;
    if (Prefs.IsLogined) {
      page = Routes[settings.name];
    } else {
      page = Routes[Login];
    }

    if (page == null) {
      return MaterialPageRoute(builder: (context) => ErrorWidget("not found page: ${settings.name}"));
    }
    return MaterialPageRoute(builder: page, settings: settings);
  }
}
