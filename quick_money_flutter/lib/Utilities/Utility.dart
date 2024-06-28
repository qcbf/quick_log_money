
class Utility {
  ///
  static String DateToString(DateTime date) {
    var str = StringBuffer();
    var now = DateTime.now();
    if (now.year != date.year) {
      str.write(now.year);
      str.write("年");
    }
    if (now.month != date.month) {
      str.write(now.month);
      str.write("月");
    }
    if (now.day != date.day) {
      str.write(now.day);
      str.write("日");
    }
    str.write(now.hour);
    str.write("时");
    str.write(now.minute);
    str.write("分");
    return str.toString();
  }
}
