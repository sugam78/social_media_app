import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/Bloc/UserBloc/user_bloc.dart';
import 'package:social_media_app/Core/Routes/route_name.dart';
import 'package:social_media_app/Models/user_model.dart';

import '../../../Bloc/UserBloc/user_event.dart';
import '../../../Core/Constants/global_variables.dart';
import '../../../Core/ErrorHandling/htpp_error_handle.dart';
import '../../../Core/Utilities/utils.dart';

class AuthService {
  //signup
  Future<void> signUpUser(
      String name, String email, String password, BuildContext context) async {
    UserModel user =
        UserModel(id: '', name: name, email: email, password: password,token: '');
    try {
      final response = await http.post(Uri.parse('$baseUrl/api/signup'),
          body: jsonEncode(user.toJson()),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(response, context, () {
        showSnackBar(context, "Account Created");
      });
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  //signin
  Future<void> signInUser(
      String email, String password, BuildContext context) async {
    try {
      final response = await http.post(Uri.parse('$baseUrl/api/signin'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      httpErrorHandle(response, context, () async {
        SharedPreferences sp = await SharedPreferences.getInstance();
        await sp.setString('x-auth-token', jsonDecode(response.body)['token']);
        BlocProvider.of<UserBloc>(context).add(SetUser(response.body));
        Navigator.pushReplacementNamed(context, RouteName.topBar);
      });
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  //getUserData
  Future<void> getUserData(BuildContext context) async {
    try {
      SharedPreferences sp = await SharedPreferences.getInstance();
      String? token = await sp.getString('x-auth-token');
      if (token == null) {
        sp.setString('x-auth-token', '');token = '';
      }
      final tokenResponse = await http.post(
          Uri.parse('$baseUrl/api/is-token-valid'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token
          });
      var isTokenValid = jsonDecode(tokenResponse.body);
      if (!isTokenValid) {
        BlocProvider.of<UserBloc>(context).add(SetUserFromModel(UserModel(id: '', name: '', email: '', password: '', token: '')));
        return showSnackBar(context, "Auth Failed");
      }
      final userResponse =
      await http.get(Uri.parse('$baseUrl/api/get-user-data'),headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': token
      });
      BlocProvider.of<UserBloc>(context).add(SetUser(userResponse.body));
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }
}
