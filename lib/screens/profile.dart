import 'package:flutter/material.dart';
import 'package:l7m2/models/profile_controller.dart';
import 'package:l7m2/utils/mock_actions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.profile});

  final ProfileController profile;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Фон профиля — фото кота из assets (запасной вариант — тёмная заливка).
        Image.asset(
          'assets/images/profile_bg.jpeg',
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => const ColoredBox(color: Color(0xFF1C1C1C)),
        ),
        // Затемнение, чтобы текст читался на фото.
        Container(color: Colors.black.withValues(alpha: 0.6)),
        ListenableBuilder(
          listenable: profile,
          builder: (context, _) => ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color(0xFF2A2A2A),
                  child: Text(
                    profile.initial,
                    style: const TextStyle(
                      fontSize: 52,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                profile.name.isEmpty ? 'Без имени' : profile.name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: FilledButton.icon(
                  onPressed: () => _openEditor(context),
                  icon: const Icon(Icons.edit),
                  label: const Text('Изменить профиль'),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Column(
                  children: [
                    _InfoRow(Icons.cake, 'Дата рождения', profile.birth),
                    const Divider(height: 1),
                    _InfoRow(
                      Icons.email,
                      'Почта',
                      profile.email,
                      onTap: () => writeEmail(context, profile.email),
                    ),
                    const Divider(height: 1),
                    _InfoRow(
                      Icons.phone,
                      'Телефон',
                      profile.phone,
                      onTap: () => callPhone(context, profile.phone),
                    ),
                    const Divider(height: 1),
                    _InfoRow(Icons.person_outline, 'О себе', profile.about),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _openEditor(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _EditProfileSheet(profile: profile),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow(this.icon, this.label, this.value, {this.onTap});

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final empty = value.trim().isEmpty;
    return ListTile(
      leading: Icon(icon, color: Colors.white70),
      title: Text(label),
      subtitle: Text(
        empty ? 'Не указано' : value,
        style: TextStyle(color: empty ? Colors.grey : null),
      ),
      onTap: onTap,
    );
  }
}

class _EditProfileSheet extends StatefulWidget {
  const _EditProfileSheet({required this.profile});

  final ProfileController profile;

  @override
  State<_EditProfileSheet> createState() => _EditProfileSheetState();
}

class _EditProfileSheetState extends State<_EditProfileSheet> {
  late final TextEditingController _name;
  late final TextEditingController _birth;
  late final TextEditingController _email;
  late final TextEditingController _phone;
  late final TextEditingController _about;

  @override
  void initState() {
    super.initState();
    final p = widget.profile;
    _name = TextEditingController(text: p.name);
    _birth = TextEditingController(text: p.birth);
    _email = TextEditingController(text: p.email);
    _phone = TextEditingController(text: p.phone);
    _about = TextEditingController(text: p.about);
  }

  @override
  void dispose() {
    _name.dispose();
    _birth.dispose();
    _email.dispose();
    _phone.dispose();
    _about.dispose();
    super.dispose();
  }

  void _save() {
    widget.profile.update(
      name: _name.text,
      email: _email.text,
      phone: _phone.text,
      birth: _birth.text,
      about: _about.text,
    );
    Navigator.pop(context);
  }

  Widget _field(TextEditingController c, String label, IconData icon,
      {TextInputType? type, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: c,
        keyboardType: type,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Редактирование профиля',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _field(_name, 'Имя', Icons.person),
            _field(_birth, 'Дата рождения (например, 01.01.2000)', Icons.cake,
                type: TextInputType.datetime),
            _field(_email, 'Почта', Icons.email,
                type: TextInputType.emailAddress),
            _field(_phone, 'Телефон', Icons.phone, type: TextInputType.phone),
            _field(_about, 'О себе', Icons.edit_note, maxLines: 3),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _save,
                child: const Text('Сохранить'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
