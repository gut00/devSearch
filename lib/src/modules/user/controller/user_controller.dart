import 'package:dev_search/src/modules/user/model/user_model.dart';
import 'package:dev_search/src/modules/user/service/user_service.dart';
import 'package:flutter/material.dart';

class UserController extends ChangeNotifier {
  final UserService service;

  var user = UserModel.empty();

  bool isLoading = false;

  String error = '';

  UserController(this.service);

  Future<UserModel> fetchUsers(String userId) async {
    isLoading = true;
    notifyListeners();
    try {
      user = await service.fetchUsers(userId);
    } catch (e) {
      error = e.toString();
    }
    isLoading = false;
    return user;
  }
}
