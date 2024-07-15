

import '../../Models/user_model.dart';

sealed class UserEvent {}

final class SetUser extends UserEvent{
  final String userModel;
  SetUser(this.userModel);
}

final class SetUserFromModel extends UserEvent{
  final UserModel userModel;
  SetUserFromModel(this.userModel);
}