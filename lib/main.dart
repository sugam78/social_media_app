import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/Bloc/FriendRequestsBloc/friend_request_bloc.dart';
import 'package:social_media_app/Bloc/Friends/friends_bloc.dart';
import 'package:social_media_app/Bloc/UserBloc/user_bloc.dart';
import 'package:social_media_app/Bloc/UserListBloc/user_list_bloc.dart';

import 'Core/Routes/route_name.dart';
import 'Core/Routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_)=>UserBloc(),),
        BlocProvider(create: (_)=>UserListBloc(),),
        BlocProvider(create: (_)=>FriendRequestBloc(),),
        BlocProvider(create: (_)=>FriendsBloc(),),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: RouteName.splash,
        onGenerateRoute: (settings)=>Routes.generateRoute(settings),
      ),
    );
  }
}
