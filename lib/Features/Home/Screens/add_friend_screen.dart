import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/Bloc/FriendRequestsBloc/friend_request_bloc.dart';
import 'package:social_media_app/Bloc/UserListBloc/user_list_bloc.dart';
import 'package:social_media_app/Features/Home/Services/friend_services.dart';
import 'package:social_media_app/Features/Home/Widgets/add_friend.dart';
import 'package:social_media_app/Models/user_model.dart';

import '../../../Bloc/UserBloc/user_bloc.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final friendServices = FriendServices();

  @override
  void initState() {
    friendServices.getStrangers(context);
    friendServices.getFriendRequests(context);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<UserBloc>(context).state;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  BlocBuilder<FriendRequestBloc, List<UserModel>>(
                    builder: (context, state) {
                      if (state.isEmpty) {
                        return SizedBox(height: 2);
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Friend Requests',
                              style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: state.length,
                              itemBuilder: (context, index) {
                                UserModel user = state[index];
                                return AddFriend(
                                  image: user.image ?? '',
                                  name: user.name,
                                  title1: 'Confirm',
                                  onTap1: () {
                                    friendServices.confirmFriendRequests(context, user.id);
                                  },
                                  onTap2: () {
                                    friendServices.removeFriendRequests(context, user.id, bloc.id);
                                  },
                                  title2: "Remove",
                                );
                              },
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  Text(
                    'People You may Know',
                    style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05),
                  ),
                ],
              ),
            ),
            BlocBuilder<UserListBloc, List<UserModel>>(
              builder: (context, state) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      UserModel user = state[index];
                      return AddFriend(
                        image: user.image ?? '',
                        name: user.name,
                        title1: 'Add friend',
                        onTap1: () {
                          friendServices.sendFriendRequests(context, user.id);
                        },
                        onTap2: () {
                          friendServices.removeFriendRequests(context, bloc.id, user.id);
                        },
                        title2: "Remove",
                      );
                    },
                    childCount: state.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
