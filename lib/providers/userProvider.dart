
import 'package:fan_hall/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  UserModel user = UserModel();
  
  setUser(UserModel userDetails) {
    user = userDetails;
    notifyListeners();
  }

  
}
