import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/Bloc/Friends/friends_bloc.dart';
import 'package:social_media_app/Core/Routes/route_name.dart';
import 'package:social_media_app/Features/Home/Widgets/home/photo_grid.dart';
import 'package:social_media_app/Models/user_model.dart';
import '../../../../Core/Constants/global_variables.dart';

class FriendsPosts extends StatelessWidget {
  const FriendsPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: BlocBuilder<FriendsBloc, List<UserModel>>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.length,
            itemBuilder: (context, index) {
              final user = state[index];
              return user.posts != null
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: user.posts!.length,
                      itemBuilder: (context, ind) {
                        final post = user.posts![(user.posts!.length) -ind-1];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: mq.width * 0.06,
                                    child: user.image == null
                                        ? Icon(
                                            Icons.person_outline,
                                            size: mq.width * 0.06,
                                          )
                                        : Image.asset(user.image!),
                                  ),
                                  SizedBox(
                                    width: mq.width * 0.03,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        user.name,
                                        style: TextStyle(
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.045),
                                      ),
                                      Text(
                                          '${post.date.difference(DateTime.now()).inHours * -1} hours ${((post.date.difference(DateTime.now()).inHours * -1) % 60).toInt()} munutes ago'),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                post.caption,
                                style: TextStyle(fontSize: mq.width * 0.05),
                              ),
                              post.images == null
                                  ? SizedBox()
                                  :post.images!.isNotEmpty? Container(
                                height: 200, // or whatever height you need
                                child: PhotoGrid(
                                  imageUrls: post.images!,
                                  onImageClicked: (val) {},
                                  onExpandClicked: () {
                                    Navigator.pushNamed(context, RouteName.postDetail,arguments: {
                                      'appBar': '${user.name} Posts Images',
                                      'imageUrls': post.images!
                                    });
                                  },
                                ),
                              ):SizedBox(),
                            ],
                          ),
                        );
                      },
                    )
                  : SizedBox();
            },
          );
        },
      ),
    );
  }
}
