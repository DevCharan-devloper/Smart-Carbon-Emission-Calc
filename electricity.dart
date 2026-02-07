import 'package:flutter/material.dart';

// Electricity Screen
class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({super.key});

  @override
  State<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends State<ElectricityScreen> {
  final TextEditingController unitsController = TextEditingController();
  final TextEditingController renewableController = TextEditingController();
  final TextEditingController acHoursController = TextEditingController();

  void calculateAndNavigate() {
    double units = double.tryParse(unitsController.text) ?? 0;
    String renewable = renewableController.text.trim().toLowerCase();
    double acHours = double.tryParse(acHoursController.text) ?? 0;

    // Simple scoring system
    double score = units * 0.1 + acHours * 2;
    if (renewable == "yes") {
      score -= 10; // Bonus for renewable energy
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          units: units,
          renewable: renewable,
          acHours: acHours,
          score: score,
        ),
      ),
    );
  }

  Widget _buildQuestionCard(String question, TextEditingController controller,
      {String? hint}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                question,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF0D5A4E),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: hint ?? "Enter your answer...",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: const Color(0xFF25A18E),
        title: const Text(
          "Home Energy",
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/kkk.png"),
                fit: BoxFit.cover,
                opacity: 0.1,
              ),
            ),
          ),

          // Main content
          SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildQuestionCard(
                  "How many units of electricity do you consume monthly?",
                  unitsController,
                  hint: "e.g. 300",
                ),
                _buildQuestionCard(
                  "Do you use renewable energy sources (yes/no)?",
                  renewableController,
                  hint: "yes / no",
                ),
                _buildQuestionCard(
                  "How many hours per day do you use air conditioning?",
                  acHoursController,
                  hint: "e.g. 5",
                ),

                // Submit button
                ElevatedButton.icon(
                  icon: const Icon(Icons.calculate, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25A18E),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 28),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  onPressed: calculateAndNavigate,
                  label: const Text(
                    "Calculate Emission",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Result Screen
class ResultScreen extends StatelessWidget {
  final double units;
  final String renewable;
  final double acHours;
  final double score;

  const ResultScreen({
    super.key,
    required this.units,
    required this.renewable,
    required this.acHours,
    required this.score,
  });

  String getCategory() {
    if (score <= 20) {
      return "🌱 Environment Saver";
    } else if (score <= 50) {
      return "😐 Moderate User";
    } else {
      return "🔥 High Pollution Type";
    }
  }

  Color getCategoryColor() {
    if (score <= 20) {
      return Colors.green;
    } else if (score <= 50) {
      return Colors.orange;
    } else {
      return Colors.redAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Your Results"),
        backgroundColor: const Color(0xFF25A18E),
      ),
      body: Center(
        child: Card(
          elevation: 8,
          margin: const EdgeInsets.all(20),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.bolt, size: 60, color: Colors.amber),
                const SizedBox(height: 16),
                Text(" Units Consumed: $units"),
                Text("🌞 Renewable Energy: $renewable"),
                Text("❄️ AC Usage: $acHours hrs/day"),
                const Divider(height: 30, thickness: 1),
                Text(
                  "🌍 Your Energy Impact Score:\n${score.toStringAsFixed(1)}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: getCategoryColor()),
                ),
                const SizedBox(height: 20),
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  decoration: BoxDecoration(
                    color: getCategoryColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    getCategory(),
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: getCategoryColor()),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25A18E),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: const Text("🔙 Go Back & Edit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
