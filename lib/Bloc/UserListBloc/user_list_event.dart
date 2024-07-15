part of 'user_list_bloc.dart';

sealed class UserListEvent {}

final class AddUsers extends UserListEvent {
  final String usersJson;
  AddUsers(this.usersJson);
}

final class RemoveUsers extends UserListEvent {
  final String userId;
  RemoveUsers(this.userId);
}
