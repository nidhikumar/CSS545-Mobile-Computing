import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchThemeMode(),
      builder: (context, AsyncSnapshot<bool> snapshot) {
        final isDarkModeEnabled = snapshot.data ?? false;
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            brightness: isDarkModeEnabled ? Brightness.dark : Brightness.light,
          ),
          home: const MyHomePage(title: 'Flutter Demo Home Page'),
        );
      },
    );
  }

  Future<bool> _fetchThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isDarkModeEnabled') ?? false;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);

      if (pickedImage == null) return;

      final imageTemp = File(pickedImage.path);

      setState(() => image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Basic Storage"),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              color: Colors.blue,
              child: const Text(
                "Pick Image from Gallery",
                style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
              ),
              onPressed: () => pickImage(ImageSource.gallery),
            ),
            MaterialButton(
              color: Colors.blue,
              child: const Text(
                "Pick Image from Camera",
                style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
              ),
              onPressed: () => pickImage(ImageSource.camera),
            ),
            SizedBox(height: 20),
            image != null
                ? SizedBox(
              height: 150,
              width: 150,
              child: Image.file(image!),
            )
                : Text("No image selected"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DownloadPage()),
                );
              },
              child: Text("Download Page"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _toggleDarkMode(context),
              child: Text("Toggle Dark Mode"),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleDarkMode(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkModeEnabled = !(prefs.getBool('isDarkModeEnabled') ?? false);
    prefs.setBool('isDarkModeEnabled', isDarkModeEnabled);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Dark Mode ${isDarkModeEnabled ? "enabled" : "disabled"}'),
    ));

    // Rebuild the entire app with the new theme
    runApp(MyApp());
  }

}

class DownloadPage extends StatelessWidget {
  final List<String> imagePaths = [
    "assets/tiger.jpg",
    "assets/deer.jpg",
    "assets/butterfly.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (var path in imagePaths)
              Image.asset(
                path,
                height: 150,
                width: 150,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _downloadImages(context),
              child: Text("Download Images"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _downloadImages(BuildContext context) async {
    for (var path in imagePaths) {
      await _downloadImage(context, path);
    }
  }

  Future<void> _downloadImage(BuildContext context, String path) async {
    final ByteData data = await rootBundle.load(path);
    final Uint8List bytes = data.buffer.asUint8List();
    final directory = await getApplicationDocumentsDirectory();
    final File imageFile = File('${directory.path}/${path.split('/').last}');
    await imageFile.writeAsBytes(bytes);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('${path.split('/').last} downloaded successfully'),
    ));
  }
}
