import 'package:flutter/material.dart';
import 'package:flutter_hf/HTTP%20data/person.dart';
import 'package:flutter_hf/http_communication.dart';

class CharacterPage extends StatefulWidget {
  final String url;

  const CharacterPage({super.key, required this.url});

  @override
  State<CharacterPage> createState() => _CharacterPageState(url);
}

class _CharacterPageState extends State<CharacterPage> {
  final String url;
  Person? character;

  _CharacterPageState(this.url) {
    HttpCommunication http = HttpCommunication();
    print("?");
    http.getCharacter(url).then((value) => setState(() {
          print("?");
          character = value;
          print(character?.name ?? "XD");
        }));
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
            child: Stack(
              children: [
                Column(
                  children: [
                    Center(
                      child: Column(children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40.0),
                          child: Image.asset(
                            'assets/unknown.png',
                            fit: BoxFit.fitWidth,
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                        Text(
                          character?.name ?? "",
                          style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),),
                      ],

                      ),
                    ),

                    // Expanded(
                    //     child: ListView.separated(
                    //         itemBuilder: itemBuilder,
                    //         separatorBuilder: separatorBuilder,
                    //         itemCount: itemCount)
                    // )
                  ],
                ),
                Positioned(
                  top: 32.0,
                  left: 8.0,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.keyboard_arrow_left),
                    color: Colors.white,
                  ),
                ),
              ],
            )));
  }
}
