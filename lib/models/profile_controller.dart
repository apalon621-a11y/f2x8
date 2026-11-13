import 'package:flutter/foundation.dart';


class ProfileController extends ChangeNotifier {
  String name = 'Kim Chen In';
  String email = 'spongeladen@icloud.com';
  String phone = '';
  String birth = '';
  String about = '';

  String get initial => name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase();

  void update({
    required String name,
    required String email,
    required String phone,
    required String birth,
    required String about,
  }) {
    this.name = name.trim();
    this.email = email.trim();
    this.phone = phone.trim();
    this.birth = birth.trim();
    this.about = about.trim();
    notifyListeners();
  }
}
