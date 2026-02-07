import 'package:flutter/material.dart';
import 'package:untitled3/electricity.dart';
import 'package:untitled3/vehicle.dart';



// --- Home Screen ---
class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF25A18E),
        title: const Text(
          'CARBON SMART',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2),
        ),
        centerTitle: true,
        elevation: 3,
      ),
      body: Stack(
        children: [
          // Background Image with Opacity
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/kkk.png"),
                fit: BoxFit.cover,
                opacity: 0.1,
              ),
            ),
          ),

          // Main Content
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Disclaimer Section
                  Container(
                    padding: const EdgeInsets.all(18.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Text(
                      'This app helps you estimate the carbon emissions from your daily activities.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        height: 1.5,
                      ),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // Heading
                  const Text(
                    'Choose an activity',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0D5A4E),
                    ),
                  ),

                  const SizedBox(height: 0),

                  // Buttons
                  ActivityButton(
                    imagePath: 'assets/images/vehicle.png',
                    label: 'Vehicle Emissions',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VehicleScreen()),
                      );
                    },
                  ),

                  const SizedBox(height: 0),

                  ActivityButton(
                    imagePath: 'assets/images/k.png',
                    label: 'Home Energy',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ElectricityScreen()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Activity Button with InkWell & modern UI
class ActivityButton extends StatelessWidget {
  const ActivityButton({
    super.key,
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  final String imagePath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Card(
        elevation: 6,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            // Image
            SizedBox(
              height: 140,
              width: double.infinity,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
            // Label
            Container(
              padding: const EdgeInsets.all(14.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF25A18E).withOpacity(0.95),
              ),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
