import 'package:flutter/material.dart';

class UserModel with ChangeNotifier {
  String id;
  String displayName;
  String photoUrl;
  String email;

  UserModel(
      {required this.id,
      required this.displayName,
      required this.photoUrl,
      required this.email});

}
