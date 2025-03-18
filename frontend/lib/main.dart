import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(PlotLabApp());
}

class PlotLabApp extends StatelessWidget {
  const PlotLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UploadScreen(),
    );
  }
}

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  _UploadScreenState createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  PlatformFile? _selectedFile;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        _selectedFile = result.files.single;
      });
      _uploadFile();
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile == null) return;

    var request = http.MultipartRequest('POST', Uri.parse('https://api-endpoint-dtym.onrender.com/upload'));

    if (kIsWeb) {
      Uint8List? fileBytes = _selectedFile!.bytes;
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        fileBytes!,
        filename: _selectedFile!.name,
      ));
    } else {
      request.files.add(await http.MultipartFile.fromPath('file', _selectedFile!.path!));
    }

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(await response.stream.bytesToString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ColumnSelectionScreen(columns: List<String>.from(jsonResponse['columns'])),
          ),
        );
      } else {
        print('Failed to upload file: ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plot Lab')),
      body: Center(
        child: ElevatedButton(
          onPressed: _pickFile,
          child: Text('Upload'),
        ),
      ),
    );
  }
}

class ColumnSelectionScreen extends StatefulWidget {
  final List<String> columns;
  const ColumnSelectionScreen({super.key, required this.columns});

  @override
  _ColumnSelectionScreenState createState() => _ColumnSelectionScreenState();
}

class _ColumnSelectionScreenState extends State<ColumnSelectionScreen> {
  String? xAxis;
  String? yAxis;
  String? imageUrl;

  Future<void> _generatePlot() async {
    var response = await http.post(
      Uri.parse('https://api-endpoint-dtym.onrender.com/plot'),
      body: jsonEncode({'x_axis': xAxis, 'y_axis': yAxis}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      setState(() {
        imageUrl = jsonDecode(response.body)['plot_url'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Plot Lab - Select Columns')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              items: widget.columns.map((col) => DropdownMenuItem(value: col, child: Text(col))).toList(),
              onChanged: (value) => setState(() => xAxis = value),
              decoration: InputDecoration(labelText: 'X-axis column'),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              items: widget.columns.map((col) => DropdownMenuItem(value: col, child: Text(col))).toList(),
              onChanged: (value) => setState(() => yAxis = value),
              decoration: InputDecoration(labelText: 'Y-axis column'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generatePlot,
              child: Text('Next'),
            ),
            if (imageUrl != null) ...[
              SizedBox(height: 20),
              Image.network(imageUrl!),
            ],
          ],
        ),
      ),
    );
  }
}
