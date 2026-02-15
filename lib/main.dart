import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Add this dependency
// import 'firebase_options.dart'; // She will uncomment this after running flutterfire configure

import 'core/theme/app_theme.dart';
import 'features/auth/login_screen.dart';
import 'features/usage/usage_screen.dart';
import 'features/focus/focus_screen.dart';
import 'features/fatigue/fatigue_screen.dart';
import 'features/profile/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // --- FIREBASE INITIALIZATION ---
  // She will uncomment the options line below once she links her project
  try {
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print("Firebase not initialized yet: $e");
  }

  runApp(const DigitalWellbeingApp());
}

class DigitalWellbeingApp extends StatefulWidget {
  const DigitalWellbeingApp({super.key});

  @override
  DigitalWellbeingAppState createState() => DigitalWellbeingAppState();
}

class DigitalWellbeingAppState extends State<DigitalWellbeingApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Balance',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: const AuthWrapper(),
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});
  @override
  AuthWrapperState createState() => AuthWrapperState();
}

class AuthWrapperState extends State<AuthWrapper> {
  bool isLoggedIn = false;

  // This method is called by the LoginScreen
  void login() => setState(() => isLoggedIn = true);

  // This method is called by the Logout Dialog
  void logout() => setState(() => isLoggedIn = false);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: isLoggedIn ? const MainNavigation() : const LoginScreen(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    UsageScreen(),
    FocusScreen(),
    FatigueScreen(),
    ProfileScreen(),
  ];

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Logout"),
        content: const Text("Are you sure you want to end your session?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // --- HER TASK: Add await FirebaseAuth.instance.signOut(); ---
              Navigator.pop(context);
              context.findAncestorStateOfType<AuthWrapperState>()?.logout();
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.contrast_rounded),
          onPressed: () => context
              .findAncestorStateOfType<DigitalWellbeingAppState>()
              ?.toggleTheme(),
        ),
        title: const Text(
          "BALANCE",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () => _confirmLogout(context),
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.bar_chart_rounded),
            label: 'Usage',
          ),
          NavigationDestination(
            icon: Icon(Icons.timer_rounded),
            label: 'Focus',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_graph_rounded),
            label: 'Wellness',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
