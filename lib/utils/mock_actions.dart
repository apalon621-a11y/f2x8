import 'package:flutter/material.dart';



void _show(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}

void callPhone(BuildContext context, String phone) {
  if (phone.trim().isEmpty) {
    _show(context, 'Номер телефона не указан');
    return;
  }
  _show(context, 'Звонок (макет): $phone');
}

void writeEmail(BuildContext context, String email) {
  if (email.trim().isEmpty) {
    _show(context, 'Почта не указана');
    return;
  }
  _show(context, 'Письмо (макет): $email');
}
