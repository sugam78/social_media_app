part of 'friends_bloc.dart';


sealed class FriendsEvent {}

final class AddFriends extends FriendsEvent{
  final String users;
  AddFriends(this.users);
}
final class RemoveFriend extends FriendsEvent{
  final String id;
  RemoveFriend(this.id);
}
