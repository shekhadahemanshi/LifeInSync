import 'package:flutter/material.dart';
import '../../services/wellbeing_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // MOCK DATA: These will later be fetched from your FastAPI/Firebase
  double _dailyLimit = 4.0;
  bool _focusNotifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings & Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // User Header
            _buildUserHeader(),
            SizedBox(height: 30),

            // Preference Section: Usage Limits
            _buildSectionHeader("Usage Preferences"),
            _buildPreferenceCard(
              title: "Daily Screen Time Limit",
              subtitle: "${_dailyLimit.toInt()} Hours",
              icon: Icons.hourglass_top,
              trailing: Slider(
                value: _dailyLimit,
                min: 1,
                max: 12,
                onChanged: (val) {
                  // TODO: API CALL - Update user's preference in FastAPI
                  setState(() => _dailyLimit = val);
                },
              ),
            ),

            // Preference Section: Focus Mode
            _buildSectionHeader("Focus Mode Settings"),
            _buildPreferenceCard(
              title: "Auto-DND",
              subtitle: "Enable Do Not Disturb during focus",
              icon: Icons.do_not_disturb_on,
              trailing: Switch(
                value: _focusNotifications,
                onChanged: (val) {
                  // TODO: API CALL - Sync with Firebase user preferences
                  setState(() => _focusNotifications = val);
                },
              ),
            ),

            SizedBox(height: 20),
            _buildLogoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.indigo.withOpacity(0.1),
          child: Icon(Icons.person, size: 50, color: Colors.indigo),
        ),
        SizedBox(height: 12),
        Text(
          "Digital Explorer",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text("user@example.com", style: TextStyle(color: Colors.grey)),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.indigo,
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget trailing,
  }) {
    return Card(
      margin: EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              leading: Icon(icon, color: Colors.indigo),
              title: Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
              subtitle: Text(subtitle),
            ),
            trailing,
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return TextButton.icon(
      onPressed: () {
        // TODO: FIREBASE CALL - auth.signOut()
      },
      icon: Icon(Icons.logout, color: Colors.red),
      label: Text("Logout", style: TextStyle(color: Colors.red)),
    );
  }
}
