import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/Bloc/UserBloc/user_bloc.dart';
import 'package:social_media_app/Core/Routes/route_name.dart';

import '../../../Core/Constants/global_variables.dart';

class PostBar extends StatelessWidget {
  const PostBar({super.key});

  @override
  Widget build(BuildContext context) {
    void onPressed(){
      Navigator.pushNamed(context, RouteName.createPost);
    }
    final bloc = BlocProvider.of<UserBloc>(context).state;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: mq.width * 0.07,
                    child: bloc.image == null
                        ? Icon(Icons.person,size: mq.width * 0.075,)
                        : Image.network(bloc.image!),
                  ),
                  SizedBox(width: mq.width * 0.05,),
                  InkWell(
                    onTap: onPressed,
                    child: Container(
                      height: mq.height * 0.05,
                      width: mq.width * 0.55,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1,color: Colors.black),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Center(child: Text("Whats on your mind?")),
                    ),
                  ),
                  IconButton(onPressed: onPressed, icon: Icon(Icons.image)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
