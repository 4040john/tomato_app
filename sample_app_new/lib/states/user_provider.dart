import 'package:flutter/widgets.dart';

class UserProvider extends ChangeNotifier {
  bool _userLoggedIn = true;

  void setUserAuth(bool authState) {
    _userLoggedIn = authState;
    //데이터 변경을 알려주는부분
    notifyListeners();
  }

  bool get userState => _userLoggedIn;
}
