class Utility {
  ///将日期转换为好看的字符串
  static String DateToString(DateTime date, {bool isDisplayTime = false}) {
    final now = DateTime.now();
    if (date.year == now.year && date.month == now.month) {
      if (date.day == now.day) {
        return "今天";
      } else if (date.day == now.day - 1) {
        return "昨天";
      } else if (date.day == now.day - 2) {
        return "前天";
      } else if (date.day == now.day + 1) {
        return "明天";
      }
    }

    var str = StringBuffer();
    if (now.year != date.year) {
      str.write(date.year);
      str.write("年");
    }
    if (!isDisplayTime || now.month != date.month) {
      str.write(date.month);
      str.write("月");
    }
    if (!isDisplayTime || now.day != date.day) {
      str.write(date.day);
      str.write("日");
    }
    if (isDisplayTime) {
      str.write(date.hour);
      str.write("时");
      str.write(date.minute);
      str.write("分");
    }
    return str.toString();
  }

  // static GetLocation() async {
  //   var permission = await Location.instance.hasPermission();
  //   if (permission == PermissionStatus.denied) {
  //     permission = await Location.instance.requestPermission();
  //     if (permission == PermissionStatus.deniedForever || permission == PermissionStatus.denied) {
  //       return "";
  //     }
  //   }
  //   final location = await Location.instance.getLocation();
  //   return location.accuracy.toString();
  // }

  ///将数字转换为中文字符
  static String IntNumToWord(int index) => switch (index) {
        0 => "零",
        1 => "一",
        2 => "二",
        3 => "三",
        4 => "四",
        5 => "五",
        6 => "六",
        7 => "七",
        8 => "八",
        9 => "九",
        10 => "十",
        _ => "X",
      };

  ///将账本图标名转换为资源路径
  static String LedgerIconNameToAssetPath(String name) => "Assets/Ledger/TagIcons/$name";

  ///将整数钱转换为真实小数
  static double GetRealMoney(int money) => money * 0.01;
}

///
T? TryCastType<T>(dynamic ipt) => ipt is T ? ipt : null;
