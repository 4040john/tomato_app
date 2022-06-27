import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:sample_app_new/utils/logger.dart';

class UserProvider extends ChangeNotifier {
  UserProvider() {
    initUser();
  }

  User? _user;

  void initUser() {
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      logger.d('user status - $user');

      notifyListeners();
    });
  }

  User? get user => _user;
}
