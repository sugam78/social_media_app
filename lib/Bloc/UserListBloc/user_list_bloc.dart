import 'dart:convert';


import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Models/user_model.dart';

part 'user_list_event.dart';

class UserListBloc extends Bloc<UserListEvent, List<UserModel>> {
  UserListBloc() : super([]) {
    on<AddUsers>(_onAddUsers);
    on<RemoveUsers>(_onRemoveUsers);
  }

  void _onAddUsers(AddUsers event, Emitter<List<UserModel>> emit) {
    state.clear();
    final users = (jsonDecode(event.usersJson) as List)
        .map((e) => UserModel.fromJson(e))
        .toList();
    final updatedUsers = List<UserModel>.from(state)..addAll(users);
    emit(updatedUsers);
  }

  void _onRemoveUsers(RemoveUsers event, Emitter<List<UserModel>> emit) {
    final updatedUsers = state.where((user) => user.id != event.userId).toList();
    emit(updatedUsers);
  }
}
