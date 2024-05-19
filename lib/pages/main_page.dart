import 'package:flutter/material.dart';
import 'package:flutter_hf/providers/swapi_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'character_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<SwapiProvider>(context, listen: false);
    provider.loadCharacters();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SwapiProvider>(context);

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
      child: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Image.asset(
                          'assets/lightsabers.png',
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width * 0.25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Text(
                          'Characters',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  // Wrap the ListView with Expanded
                  child: ListView.separated(
                    itemCount: provider.characters.length,
                    itemBuilder: (BuildContext context, int index) {
                      final character = provider.characters[index];
                      return Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: ListTile(
                            title: Text(
                              character.name ?? "No name",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            onTap: () {},
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    launchUrl(Uri.parse(
                                            'https://www.google.com/search?q=${character.name}'))
                                        .then((value) => {
                                              // if(!value) log("Web not working") //TODO
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
                                        builder: (context) =>
                                            CharacterPage(url: character.url!),
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.keyboard_arrow_right),
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
    ));
  }
}