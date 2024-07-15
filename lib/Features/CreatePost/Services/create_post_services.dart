import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_media_app/Bloc/UserBloc/user_bloc.dart';
import 'package:social_media_app/Core/ErrorHandling/htpp_error_handle.dart';
import 'package:social_media_app/Core/Utilities/utils.dart';
import 'package:social_media_app/Models/post_model.dart';

import '../../../Core/Constants/global_variables.dart';

class CreatePostServices{

  Future<void> createPosts(BuildContext context,String caption,DateTime date,List<File> images)async{
    try{
      final CloudinaryPublic cloudinaryPublic = CloudinaryPublic('dknxrosod', 'klrwndix');
      List<String> imageUrl = [];
      for (int i = 0; i < images.length; i++) {
        final res = await cloudinaryPublic.uploadFile(CloudinaryFile.fromFile(images[i].path, folder: DateTime.now().millisecondsSinceEpoch.toString()));
        imageUrl.add(res.secureUrl);
      }

      final response = await http.post(Uri.parse('$baseUrl/api/create-post'),headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': BlocProvider.of<UserBloc>(context).state.token!,
      },body: jsonEncode({
        'id': BlocProvider.of<UserBloc>(context).state.id,
        'post': Post(caption: caption, date: date,images: imageUrl,likes: 0)
      }));
      httpErrorHandle(response, context, (){
        showSnackBar(context, 'Post created');
      });
    }
    catch(err){
      showSnackBar(context, err.toString());
    }
  }

}