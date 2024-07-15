

import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/Models/user_model.dart';

part 'friend_request_event.dart';

class FriendRequestBloc extends Bloc<FriendRequestEvent, List<UserModel>> {
  FriendRequestBloc() : super([]) {
    on<AddReceivedRequest>(_onAddReceivedRequest);
    on<RemoveReceivedRequest>(_onRemoveReceivedRequest);
  }
  void _onAddReceivedRequest(AddReceivedRequest event, Emitter<List<UserModel>> emit) {
    state.clear();
    final users = (jsonDecode(event.user) as List)
        .map((e) => UserModel.fromJson(e))
        .toList();
    final updatedUsers = List<UserModel>.from(state)..addAll(users);
    emit(updatedUsers);
  }
  void _onRemoveReceivedRequest(RemoveReceivedRequest event, Emitter<List<UserModel>> emit) {
    final updatedUsers = state.where((user) => user.id != event.id).toList();
    emit(updatedUsers);
  }
}
