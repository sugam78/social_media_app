import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/Bloc/UserBloc/user_bloc.dart';
import 'package:social_media_app/Models/user_model.dart';
import 'package:social_media_app/Core/Routes/route_name.dart';
import 'package:social_media_app/Features/Splash/Services/splash_services.dart';

import '../../../Core/Constants/global_variables.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SplashServices().getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<UserBloc, UserModel>(
        listener: (context, state) {
          debugPrint('User token: ${state.token}');
          if (state.token.isNotEmpty) {
            Timer(Duration(seconds: 3), () {
              debugPrint('Navigating to TopBar');
              Navigator.pushReplacementNamed(context, RouteName.topBar);
            });
          } else {
            Timer(Duration(seconds: 3), () {
              debugPrint('Navigating to Auth');
              Navigator.pushReplacementNamed(context, RouteName.auth);
            });
          }
        },
        child: Center(
          child: Text(
            'Welcome',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
