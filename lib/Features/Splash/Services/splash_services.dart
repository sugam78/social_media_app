import 'package:flutter/cupertino.dart';
import '../../Auth/Services/auth_service.dart';

class SplashServices {
  void getUserData(BuildContext context) {
    final authService = AuthService();
    authService.getUserData(context);
  }
}
