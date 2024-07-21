class LedgerUtility {
  ///将账本图标名转换为资源路径
  static String LedgerIconNameToAssetPath(String name) => "Assets/Ledger/TagIcons/$name";

  ///将整数钱转换为真实小数
  static double GetRealMoney(int money) => money * 0.01;

  ///将整数钱转换为真实小数
  static String GetRealMoneyStr(int money) => GetRealMoney(money).ToSmartString();

  ///
  static String GetHumanMoney(double money) {
    if (money >= 1000) {
      if (money < 10000) {
        return "${(money * 0.001).ToSmartString()}千";
      } else if (money < 1000000) {
        return "${(money * 0.0001).ToSmartString()}万";
      } else if (money < 10000000) {
        return "${(money * 0.000001).ToSmartString()}百万";
      } else if (money < 100000000) {
        return "${(money * 0.0000001).ToSmartString()}千万";
      } else if (money < 1000000000) {
        return "${(money * 0.00000001).ToSmartString()}亿";
      }
    }
    return "${money.ToSmartString()}元";
  }
}

class Utility {
  ///
  static T? TryConvertTo<T>(dynamic obj) => obj is T ? obj : null;
}

extension DateEx on DateTime {
  ///将日期转换为好看的字符串
  String ToSmartString({bool isShort = false, bool isDisplayTime = false}) {
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
    final yearTemp = now.year != year ? year : null;
    final monthTemp = (!isDisplayTime && !isShort) || now.month != month ? month : null;
    final dayTemp = !isDisplayTime || now.day != day ? day : null;

    if (yearTemp != null) {
      str.write(yearTemp);
      if (!isShort) {
        str.write("年");
      } else if (monthTemp != null) {
        str.write("/");
      }
    }
    if (monthTemp != null) {
      str.write(month);
      if (!isShort) {
        str.write("月");
      } else if (dayTemp != null) {
        str.write("/");
      }
    }
    if (!isDisplayTime || now.day != day) {
      str.write(day);
      if (!isShort) {
        str.write("日");
      } else if (isDisplayTime) {
        str.write("/");
      }
    }
    if (isDisplayTime) {
      str.write(hour);
      str.write(isShort ? "/" : "时");
      str.write(minute);
      if (!isShort) str.write("分");
    }
    return str.toString();
  }

  ///转换到当天的0时0分0秒0毫秒
  DateTime Today() => DateTime(year, month, day);
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

extension StringEx on String {
  ///double转换到字符串最多保留两位小数
  ///
  /// - [ellipsisPosition] 省略号位置:-1:开头, 0:中间, 1:结尾
  String LimitLength(int maxLength, [int ellipsisPosition = 1]) {
    const String ellipsisChars = '...';
    if (length > maxLength) {
      switch (ellipsisPosition) {
        case -1:
          return ellipsisChars + substring(length - maxLength);
        case 0:
          int segmentLength = maxLength ~/ 4;
          segmentLength = segmentLength < 1 ? 1 : segmentLength;
          return substring(0, segmentLength) + ellipsisChars + substring(length - segmentLength);
        case 1:
          return substring(0, maxLength) + ellipsisChars;
      }
    }
    return this;
  }
}
