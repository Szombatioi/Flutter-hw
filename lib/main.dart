import 'package:flutter/material.dart';
import 'package:flutter_hf/http_communication.dart';
import 'package:url_launcher/url_launcher.dart';

import 'HTTP data/person.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Star Wars Characters',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        // useMaterial3: true,
        primaryColor: Colors.white,
      ),
      home: const HomePage('Main Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  final String description;

  const HomePage(this.description, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Person>? characters;

  _HomePageState() {
    HttpCommunication http = HttpCommunication();
    http.getCharacters().then((value) => setState(() {
          characters = value;
        })); //async operation starts in the background
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1D6D38), Color(0xFF282828)],
            stops: [0.0, 0.25],
          ),
        ),
        padding: const EdgeInsets.all(80.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Center(
              child: Image.asset(
                'assets/lightsabers.png',
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width * 0.25,
              ),
            ),
            const SizedBox(height: 20), // Add spacing between image and text
            const Text(
              'Characters',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
              ),
            ),
            Expanded(
                child: Container(
              width: double.infinity,
              child: ListView.separated(
                itemCount: characters!.length,
                itemBuilder: (BuildContext context, int index) {
                  final character = characters![index];
                  return ListTile(
                    title: Text(
                      character.name ?? "No name",
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {},
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {
                            // if(! await launchUrl(Uri.parse('uri'))){
                            //
                            // }
                          },
                          icon: const Icon(Icons.info_outline),
                          color: Colors.white,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.arrow_right),
                          color: Colors.white,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(
                  color: Colors.white,
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
