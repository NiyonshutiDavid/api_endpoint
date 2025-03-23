import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Climate Impact Predictor',
      theme: ThemeData(
        primaryColor: Colors.green, // Agriculture theme
        scaffoldBackgroundColor: Colors.lightGreen[50], // Soft green background
        textTheme: GoogleFonts.interTextTheme(), // Inter font
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        centerTitle: true,
        title: Text(
          'Climate Impact Predictor',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green[700], // Button color
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          ),
          child: Text(
            'Go to Prediction',
            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PredictionPage()),
            );
          },
        ),
      ),
    );
  }
}

class PredictionPage extends StatefulWidget {
  @override
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final yearController = TextEditingController();
  final temperatureController = TextEditingController();
  final precipitationController = TextEditingController();
  final co2EmissionsController = TextEditingController();
  final irrigationController = TextEditingController();
  final extremeWeatherEventsController = TextEditingController();
  final pesticideUseController = TextEditingController();
  final fertilizerUseController = TextEditingController();
  final soilHealthIndexController = TextEditingController();
  final cropYieldController = TextEditingController();

  String predictionResult = "";
  String apiUrl = "https://api-endpoint-dtym.onrender.com"; 

  Future<void> predict() async {
    try {
      final response = await http.post(
        Uri.parse("$apiUrl/predict"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "Year": int.tryParse(temperatureController.text) ?? 0,
          "Average_Temperature_C": double.tryParse(temperatureController.text) ?? 0.0,
          "Total_Precipitation_mm": double.tryParse(precipitationController.text) ?? 0.0,
          "CO2_Emissions_MT": double.tryParse(co2EmissionsController.text) ?? 0.0,
          "Irrigation_Access_Percent": double.tryParse(irrigationController.text) ?? 0.0,
          "Extreme_Weather_Events": int.tryParse(extremeWeatherEventsController.text) ?? 0,
          "Pesticide_Use_KG_per_HA": double.tryParse(pesticideUseController.text) ?? 0.0,
          "Fertilizer_Use_KG_per_HA": double.tryParse(fertilizerUseController.text) ?? 0.0,
          "Soil_Health_Index": double.tryParse(soilHealthIndexController.text) ?? 0.0,
          "Crop_Yield_MT_per_HA": double.tryParse(cropYieldController.text) ?? 0.0,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Predicted Economic Impact"),
              content: Text("${data['prediction']} Million USD"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Back to Predict"),
                ),
              ],
            );
          },
        );
      } else {
        setState(() {
          predictionResult = "**Error:** ${jsonDecode(response.body)['error']}";
        });
      }
    } catch (e) {
      setState(() {
        predictionResult = "**Failed to connect to API**";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        centerTitle: true,
        title: Text(
          'Predict Climate Impact',
          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              "**Enter Climate Data**",
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800]),
            ),
            SizedBox(height: 10),
            TextField(
              controller: yearController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Year",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: temperatureController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Avg. Temperature (°C)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: precipitationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Total Precipitation (mm)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: co2EmissionsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "CO2 Emissions (MT)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: irrigationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Irrigation Access (%)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: extremeWeatherEventsController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Extreme Weather Events",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: pesticideUseController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Pesticide Use (KG/HA)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: fertilizerUseController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Fertilizer Use (KG/HA)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: soilHealthIndexController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Soil Health Index",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: cropYieldController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Crop Yield (MT/HA)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: predict,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: Text(
                  "Predict",
                  style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              predictionResult,
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red[700]),
            ),
          ],
        ),
      ),
    );
  }
}

