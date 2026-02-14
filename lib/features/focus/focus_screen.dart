import 'package:flutter/material.dart';

class FocusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    "Deep Work",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),

                  // Circular Timer Section
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 240,
                        height: 240,
                        child: CircularProgressIndicator(
                          value: 0.65, // Mock progress
                          strokeWidth: 6,
                          color: Theme.of(context).colorScheme.primary,
                          backgroundColor: Colors.grey.withOpacity(0.1),
                        ),
                      ),
                      const Text(
                        "18:42",
                        style: TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),

                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem("Interruptions", "2"),
                      _buildStatItem("Focus Score", "94%"),
                    ],
                  ),

                  // Control Button
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent.withOpacity(0.1),
                        foregroundColor: Colors.redAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () {
                        // ---------------------------------------------------------
                        // API CALL: POST to FastAPI to end session and log interruptions
                        // ---------------------------------------------------------
                      },
                      child: const Text(
                        "END FOCUS SESSION",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
