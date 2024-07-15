import 'package:flutter/material.dart';
import 'package:social_media_app/Core/Widgets/reusuable_button.dart';

import '../../../Core/Constants/global_variables.dart';

class AddFriend extends StatelessWidget {
  final String image,name,title1,title2;
  final VoidCallback onTap1,onTap2;
  const AddFriend({super.key, this.image = '', required this.name, required this.title1, required this.onTap1, required this.onTap2, required this.title2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              CircleAvatar(
                child: image.isEmpty?Icon(Icons.person_outline,size: mq.width * 0.1,):Image.asset(image),
                radius: mq.width * 0.12,
              ),
              SizedBox(width: mq.width * 0.05,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,style: TextStyle(fontSize: mq.width * 0.045),),
                  SizedBox(height: mq.height * 0.01,),
                  Row(
                    children: [
                      ReusuableButton(title: title1, onTap: onTap1,width: mq.width * 0.25 ,height: mq.height * 0.05,),
                      SizedBox(width: mq.width * 0.05,),
                      ReusuableButton(title: title2, onTap: onTap2,width: mq.width * 0.25 ,height: mq.height * 0.05,),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: mq.height * 0.01,),
      ],
    );
  }
}
