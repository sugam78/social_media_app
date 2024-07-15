import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/Bloc/UserBloc/user_event.dart';
import 'package:social_media_app/Models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserModel> {
  UserBloc() : super(UserModel(id: '', name: '', email: '', password: '',token: '')) {
    on<SetUser>(_onSetUser);
    on<SetUserFromModel>(_onSetUserFromModel);
  }
  void _onSetUser(SetUser event, emit) {
    final user = UserModel.fromJson(jsonDecode(event.userModel));
    emit(user);
  }

  void _onSetUserFromModel(SetUserFromModel event, emit) {
    final user = event.userModel;
    emit(user);
  }
}
