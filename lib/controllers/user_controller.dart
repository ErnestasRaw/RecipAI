//Singleton controller
import 'package:receptai/controllers/routing/navigator_utils.dart';
import 'package:receptai/models/user.dart';

class UserController {
  factory UserController() => _instance;
  UserController._();

  static final UserController _instance = UserController._();

  User? loggedInUser;
  bool get isLoggedIn => loggedInUser != null;

  void login(User user) {
    loggedInUser = user;
    resetNavigator();
  }

  void logout() {
    loggedInUser = null;
    resetNavigator();
  }
}
