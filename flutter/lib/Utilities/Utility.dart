// import 'package:location/location.dart';

class Utility {
  ///
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

  //
}
