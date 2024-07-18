import 'package:flutter/material.dart';
import 'package:social_media_app/Core/Routes/route_name.dart';
import 'package:social_media_app/Features/Home/Screens/add_friend_screen.dart';
import 'package:social_media_app/Features/Home/Screens/home_screen.dart';
import 'package:social_media_app/Features/Home/Services/friend_services.dart';

class TopBarScreen extends StatefulWidget {
  const TopBarScreen({super.key});

  @override
  State<TopBarScreen> createState() => _TopBarScreenState();
}

class _TopBarScreenState extends State<TopBarScreen> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const AddFriendScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: pages.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome'),
          actions: [
            IconButton(onPressed: (){
              FriendServices().logOut(context);
            }, icon: Icon(Icons.logout)),
          ],
          bottom: TabBar(
            onTap: updatePage,
            tabs: [
              Tab(
                icon: Container(
                  width: bottomBarWidth,
                  child: const Icon(Icons.home_outlined),
                ),
              ),
              Tab(
                icon: Container(
                  width: bottomBarWidth,

                  child: const Icon(Icons.person_add_sharp),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: pages,
        ),
      ),
    );
  }
}
