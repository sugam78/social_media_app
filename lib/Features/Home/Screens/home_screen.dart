import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/Bloc/UserBloc/user_bloc.dart';
import 'package:social_media_app/Features/Home/Widgets/home/friends_posts.dart';
import 'package:social_media_app/Features/Home/Widgets/home/photo_grid.dart';
import 'package:social_media_app/Features/Home/Widgets/home/post_bar.dart';

import '../Services/friend_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen> {
  final friendServices = FriendServices();
  @override
  void initState() {
    super.initState();
    friendServices.getFriends(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          PostBar(),
          Expanded(child: FriendsPosts()),
        ],
      ),
    );
  }
}
