import 'package:flutter/material.dart';
import 'package:quick_log_money/Pages/Home/HomePage.dart';
import 'package:quick_log_money/Utilities/Prefs.dart';
import 'package:quick_log_money/pages/LoginPage.dart';
import 'package:quick_log_money/pages/RecordMoney/RecordPage.dart';

class Pages {
  static const Home = "/";
  static const Login = "/Login";
  static const Record = "/Record";
  static final Map<String, WidgetBuilder> Routes = {
    Home: (context) => const HomePage(),
    Login: (context) => const LoginPage(),
    Record: (context) => const RecordPage(),
  };

  static MaterialPageRoute? Router(RouteSettings settings) {
    WidgetBuilder? page;
    if (GlobalPrefs.LoginUid.IsDefault) {
      page = Routes[Login];
    } else {
      page = Routes[settings.name];
    }

    if (page == null) {
      return MaterialPageRoute(builder: (context) => ErrorWidget("not found page: ${settings.name}"));
    }
    return MaterialPageRoute(builder: page, settings: settings);
  }
}
