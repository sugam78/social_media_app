import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social_media_app/Bloc/FriendRequestsBloc/friend_request_bloc.dart';
import 'package:social_media_app/Bloc/Friends/friends_bloc.dart';
import 'package:social_media_app/Bloc/UserBloc/user_bloc.dart';
import 'package:social_media_app/Bloc/UserListBloc/user_list_bloc.dart';
import 'package:social_media_app/Core/Constants/global_variables.dart';
import 'package:social_media_app/Core/ErrorHandling/htpp_error_handle.dart';
import 'package:social_media_app/Core/Routes/route_name.dart';
import 'package:social_media_app/Core/Utilities/utils.dart';

class FriendServices {
  Future<void> getStrangers(BuildContext context) async {
    try {
      final bloc = BlocProvider.of<UserBloc>(context).state;
      final response = await http.get(Uri.parse('$baseUrl/api/get-stranger-users'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': bloc.token!,
            'id': bloc.id
          });
      httpErrorHandle(response, context, (){});
      BlocProvider.of<UserListBloc>(context).add(AddUsers(response.body));
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }
  Future<void> getFriendRequests(BuildContext context) async {
    try {
      final bloc = BlocProvider.of<UserBloc>(context).state;
      final response = await http.get(Uri.parse('$baseUrl/api/get-friend-requests'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': bloc.token!,
            'id': bloc.id
          });
      debugPrint("Response:: ${response.body}");
      httpErrorHandle(response, context, (){});
      BlocProvider.of<FriendRequestBloc>(context).add(AddReceivedRequest(response.body));
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }
  Future<void> sendFriendRequests(BuildContext context,String receiverId) async {
    try {
      final bloc = BlocProvider.of<UserBloc>(context).state;
      final response = await http.post(Uri.parse('$baseUrl/api/send-friend-request'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': bloc.token!,
          },body: jsonEncode({
            'senderId' : bloc.id,
            'receiverId': receiverId
          }));
      httpErrorHandle(response, context, (){
        showSnackBar(context, "Friend request sent");
        removeStrangerUsers(context, receiverId);
      });

    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void removeStrangerUsers(BuildContext context,String id){
    BlocProvider.of<UserListBloc>(context).add(RemoveUsers(id));
  }
  void removeReceivedRequest(BuildContext context,String id){
    BlocProvider.of<FriendRequestBloc>(context).add(RemoveReceivedRequest(id));
  }

  Future<void> removeFriendRequests(BuildContext context,String senderId,String receiverId)async{
    try {
      final bloc = BlocProvider.of<UserBloc>(context).state;
      final response = await http.post(Uri.parse('$baseUrl/api/remove-friend-request'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': bloc.token!,
          },body: jsonEncode({
            'senderId' : senderId,
            'receiverId': receiverId
          }));
      httpErrorHandle(response, context, (){
        showSnackBar(context, "Removed");
        bloc.id == senderId?removeStrangerUsers(context, receiverId):removeReceivedRequest(context, senderId);
      });

    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  Future<void> confirmFriendRequests(BuildContext context,String senderId)async{
    try {
      final bloc = BlocProvider.of<UserBloc>(context).state;
      final response = await http.post(Uri.parse('$baseUrl/api/confirm-friend-request'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': bloc.token!,
          },body: jsonEncode({
            'senderId' : senderId,
            'receiverId': bloc.id
          }));
      httpErrorHandle(response, context, (){
        removeReceivedRequest(context, bloc.id);
      });

    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  Future<void> getFriends(BuildContext context)async{
    try {
      final bloc = BlocProvider.of<UserBloc>(context).state;
      final response = await http.get(Uri.parse('$baseUrl/api/get-friends'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': bloc.token!,
            'id': bloc.id
          });
      httpErrorHandle(response, context, (){
        BlocProvider.of<FriendsBloc>(context).add(AddFriends(response.body));
      });

    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  Future<void> logOut(BuildContext context)async{
    try {
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushReplacementNamed(context, RouteName.auth);

    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

}
