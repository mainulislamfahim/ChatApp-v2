import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final bool online;
  final String imgUrl;

  UserModel({required this.id, required this.name, required this.online,required this.imgUrl});

  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    return UserModel(
      id: snapshot.id,
      name: snapshot['username'] ?? 'Unknown',
      online: snapshot['online'] ?? false,
      imgUrl: snapshot['imgUrl'] ?? '',
    );
  }
}
