import 'package:social_media_app/Models/post_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String? image;
  final List<String>? friends;
  final String token;
  final List<Post>? posts;
  final List<String>? sentFriendRequests;
  final List<String>? receivedFriendRequests;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    this.image,
    this.friends,
    required this.token,
    this.posts,
    this.sentFriendRequests,
    this.receivedFriendRequests,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      password: json['password'] as String? ?? '',
      image: json['image'] as String?,
      friends: (json['friends'] as List<dynamic>?)
          ?.map((friend) => friend as String)
          .toList(),
      token: json['token'] as String? ?? '',
      posts: (json['posts'] as List<dynamic>?)
          ?.map((post) => Post.fromJson(post as Map<String, dynamic>))
          .toList(),
      sentFriendRequests: (json['sentFriendRequests'] as List<dynamic>?)
          ?.map((request) => request as String)
          .toList(),
      receivedFriendRequests: (json['receivedFriendRequests'] as List<dynamic>?)
          ?.map((request) => request as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'image': image,
      'friends': friends,
      'token': token,
      'posts': posts?.map((post) => post.toJson()).toList(),
      'sentFriendRequests': sentFriendRequests,
      'receivedFriendRequests': receivedFriendRequests,
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? password,
    String? image,
    List<String>? friends,
    String? token,
    List<Post>? posts,
    List<String>? sentFriendRequests,
    List<String>? receivedFriendRequests,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      image: image ?? this.image,
      friends: friends ?? this.friends,
      token: token ?? this.token,
      posts: posts ?? this.posts,
      sentFriendRequests: sentFriendRequests ?? this.sentFriendRequests,
      receivedFriendRequests: receivedFriendRequests ?? this.receivedFriendRequests,
    );
  }
}
