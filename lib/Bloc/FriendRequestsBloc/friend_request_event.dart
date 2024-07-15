part of 'friend_request_bloc.dart';


sealed class FriendRequestEvent {}
final class AddReceivedRequest extends FriendRequestEvent{
  final String user;
  AddReceivedRequest(this.user);
}
final class RemoveReceivedRequest extends FriendRequestEvent{
  final String id;
  RemoveReceivedRequest(this.id);
}