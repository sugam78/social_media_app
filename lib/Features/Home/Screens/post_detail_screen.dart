import 'package:flutter/material.dart';
import 'package:social_media_app/Features/Home/Widgets/home/specific_photo.dart';

class PostDetailScreen extends StatelessWidget {
  final String appBar;
  final List<String> imgUrls;
  const PostDetailScreen({super.key, required this.appBar, required this.imgUrls});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBar),
      ),
      body: ListView.builder(
          itemCount: imgUrls.length,
          itemBuilder: (context,index){
            return SpecificPhoto(imageUrl: imgUrls[index]);
      }),
    );
  }
}
