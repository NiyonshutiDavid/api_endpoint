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
  final irrigationController = TextEditingController();
  final temperatureController = TextEditingController();
  final rainfallController = TextEditingController();

  String predictionResult = "";
  String apiUrl = "YOUR_API_URL_HERE"; // Replace with actual API URL

  Future<void> predict() async {
    try {
      final response = await http.post(
        Uri.parse("$apiUrl/predict"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "Irrigation_Access_Percent": double.tryParse(irrigationController.text) ?? 0.0,
          "Average_Temperature_Celsius": double.tryParse(temperatureController.text) ?? 0.0,
          "Annual_Rainfall_mm": double.tryParse(rainfallController.text) ?? 0.0,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          predictionResult = "**Predicted Economic Impact:** \n${data['Predicted Economic Impact (Million USD)']} Million USD";
        });
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "**Enter Climate Data**",
              style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800]),
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
              controller: temperatureController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Avg. Temperature (°C)",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: rainfallController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Annual Rainfall (mm)",
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
