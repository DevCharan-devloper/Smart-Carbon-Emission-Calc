import 'package:flutter/material.dart';
// import 'package:flutter/services.dart'; // Not used in this version
import 'package:untitled3/home.dart'; // Assuming home.dart defines the 'home' screen to navigate to.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CARBON SMART CALCULATOR',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF25A18E)),
        useMaterial3: true,
        // Define a consistent app bar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF25A18E),
          foregroundColor: Colors.white, // Color for icons and text
          elevation: 4,
          centerTitle: true,
        ),
        // Define a consistent button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF25A18E), // Brand color
            foregroundColor: Colors.white, // Text color
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      home: const MyHomePage(title: 'Carbon Smart Home'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carbon Smart Calculator'),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            // TODO: Implement drawer or menu functionality
            print("Menu button pressed!");
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand, // Ensures the Stack fills the entire body
        children: [
          // 1. BACKGROUND IMAGE
          // Placed first in the Stack to be in the background.
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/kkk.png"),
                fit: BoxFit.cover,
                opacity: 0.2, // A subtle opacity looks cleaner
              ),
            ),
          ),

          // 2. MAIN CONTENT
          // Using a Container with padding to give content space from the edges.
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Vertically centers the content
              crossAxisAlignment: CrossAxisAlignment.stretch, // Stretches button to fill width
              children: [
                // --- WELCOME TEXT ---
                const Text(
                  'Welcome to Carbon Smart',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    color: Color.fromARGB(255, 13, 90, 78), // Darker, less saturated green
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10,
                        color: Colors.black26,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50), // Increased spacing for better visual hierarchy

                // --- ACTION BUTTON ---
                // The Positioned widget has been removed.
                // The button is now a direct child of the Column.
                ElevatedButton(
                  onPressed: () {
                    // Navigate to the screen defined in home.dart
                    // Ensure 'home()' is a valid widget class.
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const home()),
                    );
                  },
                  child: const Text('Get Started'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

