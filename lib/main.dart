import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/auth/login_screen.dart';
import 'features/usage/usage_screen.dart';
import 'features/focus/focus_screen.dart';
import 'features/fatigue/fatigue_screen.dart';
import 'features/profile/profile_screen.dart';

void main() => runApp(const DigitalWellbeingApp());

class DigitalWellbeingApp extends StatefulWidget {
  const DigitalWellbeingApp({super.key});
  @override
  DigitalWellbeingAppState createState() => DigitalWellbeingAppState();
}

class DigitalWellbeingAppState extends State<DigitalWellbeingApp> {
  ThemeMode _themeMode = ThemeMode.dark; // Default to Classy Dark

  void toggleTheme() => setState(
    () => _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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

  void login() => setState(() => isLoggedIn = true);
  void logout() => setState(() => isLoggedIn = false);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
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

  // This handles the logout and routing back to Login
  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Confirm Logout"),
        content: const Text(
          "Are you sure you want to return to the login screen?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              // ---------------------------------------------------------
              // FIREBASE CALL: auth.signOut()
              // ---------------------------------------------------------
              Navigator.pop(context); // Close the dialog

              // This triggers the AuthWrapper to show the LoginScreen
              context.findAncestorStateOfType<AuthWrapperState>()?.logout();
            },
            child: const Text(
              "Logout",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
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
        title: const Text("BALANCE"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () =>
                _confirmLogout(context), // Triggers the routing logic
          ),
        ],
      ),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        elevation: 0,
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
