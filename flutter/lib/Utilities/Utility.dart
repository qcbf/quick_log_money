class LedgerUtility {
  ///将账本图标名转换为资源路径
  static String LedgerIconNameToAssetPath(String name) => "Assets/Ledger/TagIcons/$name";

  ///将整数钱转换为真实小数
  static double GetRealMoney(int money) => money * 0.01;
}

class Utility {
  ///
  static T? TryConvertTo<T>(dynamic obj) => obj is T ? obj : null;
}

extension DateEx on DateTime {
  ///将日期转换为好看的字符串
  String ToSmartString({bool isDisplayTime = false}) {
    final now = DateTime.now();
    if (year == now.year && month == now.month) {
      if (day == now.day) {
        return "今天";
      } else if (day == now.day - 1) {
        return "昨天";
      } else if (day == now.day - 2) {
        return "前天";
      } else if (day == now.day + 1) {
        return "明天";
      }
    }

    var str = StringBuffer();
    if (now.year != year) {
      str.write(year);
      str.write("年");
    }
    if (!isDisplayTime || now.month != month) {
      str.write(month);
      str.write("月");
    }
    if (!isDisplayTime || now.day != day) {
      str.write(day);
      str.write("日");
    }
    if (isDisplayTime) {
      str.write(hour);
      str.write("时");
      str.write(minute);
      str.write("分");
    }
    return str.toString();
  }
}

extension DoubleEx on double {
  ///double转换到字符串最多保留两位小数
  String ToSmartString() {
    final int = toInt();
    if (int == this) {
      return int.toString();
    } else {
      return toStringAsFixed(this * 100 % 10 == 0 ? 1 : 2);
    }
  }
}
