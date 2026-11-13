import 'package:flutter/material.dart';
import 'package:l7m2/models/profile_controller.dart';
import 'package:l7m2/navigation.dart';
import 'package:l7m2/screens/contact.dart';
import 'package:l7m2/screens/home.dart';
import 'package:l7m2/screens/profile.dart';
import 'package:l7m2/screens/settings.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _darkTheme(),
      home: const MainScreen(),
    );
  }
}

ThemeData _darkTheme() {
  const bg = Color(0xFF0E0E0E);
  const panel = Color(0xFF161616);
  const card = Color(0xFF1C1C1C);

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: bg,
    colorScheme: const ColorScheme.dark(
      primary: Colors.white,
      onPrimary: Colors.black,
      surface: bg,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: bg,
      foregroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: panel),
    cardTheme: CardThemeData(
      color: card,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    dividerTheme: const DividerThemeData(color: Color(0xFF2A2A2A)),
    listTileTheme: const ListTileThemeData(iconColor: Colors.white70),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF2A2A2A),
      contentTextStyle: TextStyle(color: Colors.white),
    ),
  );
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = AppTab.home;

  final ProfileController _profile = ProfileController();

  static const List<String> _titles = ['Главная', 'Профиль', 'Настройки', 'Контакты'];

  void _selectTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _profile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
      drawer: _buildDrawer(),
      bottomNavigationBar: _buildBottomNav(),
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(profile: _profile),
          ProfileScreen(profile: _profile),
          SettingsScreen(onSelectTab: _selectTab),
          const ContactScreen(),
        ],
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            _menuItem(AppTab.home, 'Главная', Icons.home),
            _menuItem(AppTab.profile, 'Профиль', Icons.person),
            _menuItem(AppTab.settings, 'Настройки', Icons.settings),
            _menuItem(AppTab.contact, 'Контакты', Icons.contact_phone),
          ],
        ),
      ),
    );
  }

  Widget _menuItem(int index, String title, IconData icon) {
    return ListTile(
      selected: _currentIndex == index,
      selectedColor: Colors.white,
      selectedTileColor: Colors.white.withValues(alpha: 0.08),
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        _selectTab(index);
        Navigator.pop(context);
      },
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      currentIndex: _currentIndex > AppTab.settings ? AppTab.settings : _currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: const Color(0xFF161616),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white38,
      onTap: _selectTab,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Профиль'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Настройки'),
      ],
    );
  }
}
