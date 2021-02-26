import 'package:flutter/cupertino.dart';

class BaseProvider with ChangeNotifier{
  bool loading = false;

  void loadingg(bool loading) {
    this.loading = loading;
    notifyListeners();
  }
}