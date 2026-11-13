import 'package:flutter/material.dart';
import 'package:l7m2/config/contact_info.dart';
import 'package:l7m2/utils/mock_actions.dart';
import 'package:l7m2/widgets/contact_tile.dart';


class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ContactTile(
          icon: Icons.phone,
          title: 'Телефон',
          value: ContactInfo.phone,
          onTap: () => callPhone(context, ContactInfo.phone),
        ),
        ContactTile(
          icon: Icons.email,
          title: 'Почта',
          value: ContactInfo.email,
          onTap: () => writeEmail(context, ContactInfo.email),
        ),
        ContactTile(
          icon: Icons.location_on,
          title: 'Адрес',
          value: ContactInfo.address,
          onTap: () {},
        ),
      ],
    );
  }
}
