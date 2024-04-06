import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hello World'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _goToSecondPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 50), // Added padding to move the text down
            const Text(
              'Hi! I am Nidhi Kumar.',
              style:
                  TextStyle(fontSize: 24), // Increased font size for the text
            ),
            SizedBox(height: 20), // Added spacing between text and image
            Image.asset('images/image.png'), // Adjust path to your image asset
            Spacer(), // Added Spacer to push button to bottom
            Padding(
              padding: EdgeInsets.only(bottom: 50), // Added space from the bottom
              child: ElevatedButton(
                onPressed: _goToSecondPage,
                child: Text('About Me'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Me'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20), // Added spacing
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20), // Added padding on left and right
              child: Text(
                'I am currently doing my masters at University of Washington. '
                    'I love creating applications. I aspire to build something unique one day!',
                textAlign: TextAlign.center, // Align text to the center
                style: TextStyle(fontSize: 24), // Increased font size for the text
              ),
            ),
            SizedBox(height: 20), // Add spacing between text and image
            Image.asset(
              'images/uw.JPG', // Adjust the path to your image asset
              width: 500, // Adjust the width of the image as needed
              height: 400, // Adjust the height of the image as needed
            ),
            Spacer(), // Added Spacer to push the button to the bottom
            Padding(
              padding: EdgeInsets.only(bottom: 50), // Added space from the bottom
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThirdPage()),
                  );
                },
                child: Text('Contact Me'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Connect with me:',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Add spacing between text and links
            ListTile(
              leading: Icon(Icons.link),
              title: Text(
                'LinkedIn',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: InkWell(
                onTap: () {
                  launch('https://www.linkedin.com/in/nidhikumar1401/');
                },
                child: Text(
                  'https://www.linkedin.com/in/nidhikumar1401/',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.github), // Using Font Awesome GitHub icon
              title: Text(
                'GitHub',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: InkWell(
                onTap: () {
                  launch('https://github.com/nidhikumar');
                },
                child: Text(
                  'https://github.com/nidhikumar',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text(
                'Email',
                style: TextStyle(fontSize: 18),
              ),
              subtitle: InkWell(
                onTap: () {
                  launch('mailto:nk1401@uw.edu');
                },
                child: Text(
                  'nk1401@uw.edu',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20), // Add spacing between links and Back button
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}


