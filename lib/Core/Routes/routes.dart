
import 'package:flutter/material.dart';
import 'package:social_media_app/Features/Auth/Screens/auth_screen.dart';
import 'package:social_media_app/Features/CreatePost/Screens/create_post.dart';
import 'package:social_media_app/Features/Home/Screens/top_bar_screen.dart';
import 'package:social_media_app/Features/Splash/Screen/splash_screen.dart';
import 'route_name.dart';

class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RouteName.auth:
        return MaterialPageRoute(builder: (context)=>const AuthScreen());
      case RouteName.topBar:
        return MaterialPageRoute(builder: (context)=>const TopBarScreen());
      case RouteName.splash:
        return MaterialPageRoute(builder: (context)=>const SplashScreen());
      case RouteName.createPost:
        return MaterialPageRoute(builder: (context)=>const CreatePost());
      default:
        return MaterialPageRoute(builder: (context)
        {
          return const Scaffold(
            body: Center(child: Text('No routes available')),
          );
        });
    }

  }
}