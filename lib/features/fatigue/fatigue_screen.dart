import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class FatigueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Digital Fatigue Level", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          CircularPercentIndicator(
            radius: 120.0,
            lineWidth: 15.0,
            percent: 0.74, // This would come from your FastAPI later
            center: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("74%", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                Text("High", style: TextStyle(color: Colors.redAccent)),
              ],
            ),
            progressColor: Colors.redAccent,
            backgroundColor: Colors.grey.withOpacity(0.2),
            circularStrokeCap: CircularStrokeCap.round,
            animation: true,
          ),
          const SizedBox(height: 40),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text("Recommendation: Take a 15-minute break away from all screens.", 
              textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}