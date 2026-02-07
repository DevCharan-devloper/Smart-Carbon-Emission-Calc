import 'package:flutter/material.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  final TextEditingController kmController = TextEditingController();
  final TextEditingController mileageController = TextEditingController();
  String fuelType = "Petrol";

  // Emission factors in kg CO2 per litre
  final Map<String, double> emissionFactors = {
    "Petrol": 2.31,
    "Diesel": 2.68,
    "CNG": 2.0,
  };

  void calculateAndNavigate() {
    double km = double.tryParse(kmController.text) ?? 0;
    double mileage = double.tryParse(mileageController.text) ?? 1;

    double fuelUsed = km / mileage;
    double emission = fuelUsed * (emissionFactors[fuelType] ?? 2.31);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          km: km,
          mileage: mileage,
          fuelType: fuelType,
          emission: emission,
        ),
      ),
    );
  }

  Widget _buildInputCard({required String title, required Widget child}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0D5A4E))),
            const SizedBox(height: 12),
            child,
          ],
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
        title: const Text("Vehicle Emissions",
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Fuel type first
            _buildInputCard(
              title: "What type of fuel does your vehicle use?",
              child: DropdownButtonFormField<String>(
                value: fuelType,
                items: emissionFactors.keys
                    .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(e),
                ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    fuelType = val!;
                  });
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
            ),

            // Mileage second
            _buildInputCard(
              title: "What is your vehicle's mileage (km/l)?",
              child: TextField(
                controller: mileageController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter mileage here...",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
            ),

            // Km third
            _buildInputCard(
              title: "How many kilometers do you drive per day?",
              child: TextField(
                controller: kmController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter km here...",
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Submit button
            ElevatedButton.icon(
              icon: const Icon(Icons.calculate, color: Colors.white),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF25A18E),
                padding:
                const EdgeInsets.symmetric(vertical: 14, horizontal: 28),
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
    );
  }
}

class ResultScreen extends StatelessWidget {
  final double km;
  final double mileage;
  final String fuelType;
  final double emission;

  const ResultScreen({
    super.key,
    required this.km,
    required this.mileage,
    required this.fuelType,
    required this.emission,
  });

  String getCategory() {
    if (emission <= 3) {
      return "🌱 Environment Saver";
    } else if (emission <= 6) {
      return "😐 Moderate";
    } else {
      return "🔥 High Polluter";
    }
  }

  Color getCategoryColor() {
    if (emission <= 3) {
      return Colors.green;
    } else if (emission <= 6) {
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
                const Icon(Icons.eco, size: 60, color: Colors.green),
                const SizedBox(height: 16),
                Text("🚗 Kilometers per day: $km"),
                Text("⛽ Fuel type: $fuelType"),
                Text("📊 Mileage: $mileage km/l"),
                const Divider(height: 30, thickness: 1),
                Text(
                  "🌍 Your daily CO₂ emissions:\n${emission.toStringAsFixed(2)} kg",
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
