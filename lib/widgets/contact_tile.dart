import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Карточка с контактом: нажатие выполняет действие, долгое нажатие копирует.
class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white.withValues(alpha: 0.08),
          child: Icon(icon, color: Colors.white70),
        ),
        title: Text(title),
        subtitle: Text(value),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
        onLongPress: () async {
          final messenger = ScaffoldMessenger.of(context);
          await Clipboard.setData(ClipboardData(text: value));
          messenger.showSnackBar(
            const SnackBar(content: Text('Скопировано в буфер обмена')),
          );
        },
      ),
    );
  }
}
