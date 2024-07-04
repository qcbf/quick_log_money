import 'package:flutter/foundation.dart';

///
class AsyncValue<T> with ChangeNotifier implements ValueListenable<T> {
  late T _Value;
  bool IsHasValue = false;
  @override
  T get value => _Value;
  set value(T v) {
    _Value = v;
    notifyListeners();
  }

  AsyncValue(Future<T> valueFuture) {
    valueFuture.then((v) {
      IsHasValue = true;
      value = v;
    });
  }
}
