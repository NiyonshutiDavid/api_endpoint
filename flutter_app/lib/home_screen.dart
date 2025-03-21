import 'package:flutter/material.dart';
import 'output_screen.dart'; // Import the Output Screen

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GradPredict.Al'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Prediction climate impact on economy in millions USD',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text('Please input the following to predict:'),
            SizedBox(height: 10),
            TextField(decoration: InputDecoration(labelText: 'Column name')),
            TextField(decoration: InputDecoration(labelText: 'Column name')),
            TextField(decoration: InputDecoration(labelText: 'Column name')),
            TextField(decoration: InputDecoration(labelText: 'Column name')),
            TextField(decoration: InputDecoration(labelText: 'Column name')),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OutputScreen()),
                );
              },
              child: Text('Predict'),
            ),
          ],
        ),
      ),
    );
  }
}