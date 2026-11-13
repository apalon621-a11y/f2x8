import 'package:flutter/material.dart';
import 'package:l7m2/config/contact_info.dart';
import 'package:l7m2/navigation.dart';
import 'package:l7m2/utils/mock_actions.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, required this.onSelectTab});

  final ValueChanged<int> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Главная'),
          onTap: () => onSelectTab(AppTab.home),
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Профиль'),
          onTap: () => onSelectTab(AppTab.profile),
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.contact_phone),
          title: const Text('Контакты'),
          onTap: () => onSelectTab(AppTab.contact),
        ),
        const Divider(height: 1),
        ListTile(
          leading: const Icon(Icons.mail),
          title: const Text('Почта'),
          onTap: () => writeEmail(context, ContactInfo.email),
        ),
      ],
    );
  }
}
