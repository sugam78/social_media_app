

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/Models/user_model.dart';

part 'friends_event.dart';

class FriendsBloc extends Bloc<FriendsEvent, List<UserModel>> {
  FriendsBloc() : super([]) {
    on<AddFriends>(_onAddFriends);
    on<RemoveFriend>(_onRemoveFriend);
  }
  void _onAddFriends(AddFriends event, Emitter<List<UserModel>> emit) {
    state.clear();
    final users = (jsonDecode(event.users) as List)
        .map((e) => UserModel.fromJson(e))
        .toList();
    final updatedUsers = List<UserModel>.from(state)..addAll(users);
    emit(updatedUsers);
  }
  void _onRemoveFriend(RemoveFriend event, Emitter<List<UserModel>> emit) {
    final updatedUsers = state.where((user) => user.id != event.id).toList();
    emit(updatedUsers);
  }
}
