import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hf/http_data/data_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import 'characterPage.dart';
import 'http_communication.dart';
import 'http_data/data/character.dart';

class HomePage extends StatefulWidget {
  final String description;

  const HomePage(this.description, {super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Character>? characters = DataStorage().characters;
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
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Image.asset(
                      'assets/lightsabers.png',
                      fit: BoxFit.fitWidth,
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(40.0),
                    child: Text(
                      'Characters',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              // Wrap the ListView with Expanded
              child: ListView.separated(
                itemCount: characters?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  final character = characters![index];
                  return Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: ListTile(
                        title: Text(
                          character.name ?? "No name",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {},
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                launchUrl(Uri.parse('https://www.google.com/search?q=${character.name}')).then((value) => {
                                  if(!value) print("Web not working") //TODO
                                });
                              },
                              icon: const Icon(Icons.info_outline),
                              color: Colors.white,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CharacterPage(url: character.url!),
                                  ),
                                );
                                print("Navigated");
                              },
                              icon: const Icon(Icons.keyboard_arrow_right),
                              color: Colors.white,
                            ),
                          ],
                        ),
                      )
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                const Divider(
                  color: Colors.white,
                ),
              ),
            ),
            // Visibility( //TODO not sure if needed
            //   visible: hasNext,
            //   child: TextButton(
            //     onPressed: () {
            //       page++;
            //       http.getCharacters(page: page).then((value) => characters?.addAll(value?.results as Iterable<Character>));
            //     },
            //     child: const Text("Load more"),
            //   )
            // ),
          ],
        ),
      ),
    );
  }
}