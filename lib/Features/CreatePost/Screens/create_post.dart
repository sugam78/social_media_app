import 'dart:io';

import 'package:flutter/material.dart';
import 'package:social_media_app/Core/Utilities/utils.dart';
import 'package:social_media_app/Core/Widgets/custom_text_field.dart';
import 'package:social_media_app/Core/Widgets/reusuable_button.dart';
import 'package:social_media_app/Features/CreatePost/Services/create_post_services.dart';

import '../../../Core/Constants/global_variables.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  List<File> images = [];
  final createPostServices = CreatePostServices();
  final TextEditingController controller = TextEditingController();
  void selectImages() async {
    var res = await pickImages();
    setState(() {
      images = res;
    });
  }
  Future<void> createPost()async{
    await createPostServices.createPosts(context, controller.text, DateTime.now(), images);
    Navigator.pop(context);
  }
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: mq.width * 0.06,
                    child:  Icon(Icons.person,size: mq.width * 0.065,)
                  ),
                  SizedBox(width: mq.width * 0.1),
                  Text("Sugam Paudel",style: TextStyle(fontSize: mq.width * 0.045),),
                ],
              ),
              SizedBox(height: mq.height * 0.03),
              CustomTextField(controller: controller, hintText: 'Caption',maxLines: 5,),
              SizedBox(height: mq.height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: selectImages,
                    child: Container(
                      width: mq.width * 0.4,
                      decoration: BoxDecoration(
                        color:  GlobalVariables.secondaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.image),
                          Text('Add Images'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: mq.height * 0.03),
              ReusuableButton(title: 'Create Post', onTap: createPost,color: GlobalVariables.secondaryColor,),
            ],
          ),
        ),
      ),
    );
  }
}
