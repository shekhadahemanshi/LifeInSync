import 'package:flutter/material.dart';

class FatigueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wellness Hub')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // MOCK DATA: Digital Fatigue Indicator
            // This will later be connected to your Python FastAPI 'fatigue_analysis' endpoint
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.blueAccent],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fatigue Score",
                    style: TextStyle(color: Colors.white70),
                  ),
                  Text(
                    "42%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("Status: Fresh", style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            SizedBox(height: 20),
            _buildSmartTip(Icons.lightbulb, "Time for a 20-20-20 eye break."),
          ],
        ),
      ),
    );
  }

  Widget _buildSmartTip(IconData icon, String text) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.amber),
        title: Text(text, style: TextStyle(fontSize: 14)),
      ),
    );
  }
}
