import 'package:flutter/material.dart';
import 'package:l7m2/models/profile_controller.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.profile});

  final ProfileController profile;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: ListenableBuilder(
          listenable: profile,
          builder: (context, _) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Охаешачки датабаешачки, ${profile.name.isEmpty ? 'гость' : profile.name}!',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              const Text(
                'Ты это прочитал!',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
