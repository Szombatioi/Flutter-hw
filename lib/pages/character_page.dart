import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hf/http_data/data/character.dart';
import 'package:flutter_hf/pages/widgets.dart';
import 'package:provider/provider.dart';
import '../providers/swapi_provider.dart';
import 'movies_page.dart';

class CharacterPage extends StatefulWidget {
  final String url;

  const CharacterPage({super.key, required this.url});

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  late final String url;
  late Character character;
  String assetName = 'assets/unknown.png';

  @override
  void initState() {
    url = widget.url;
    final provider = Provider.of<SwapiProvider>(context, listen: false);
    character =
        provider.characters.singleWhere((element) => element.url == url);

    provider.loadCharacterInfo(character);


    provider.assetExists('assets/${character.name}.png').then((value) =>
        setState(() {
          log("Character image exists? $value");
          assetName = value ? 'assets/${character.name?.split(' ').join()}.png' : 'assets/unknown.png';
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    var info = getCharacterInfo();
    final provider = Provider.of<SwapiProvider>(context, listen: true);
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Image.asset(
                            assetName,
                            fit: BoxFit.fitWidth,
                            width: MediaQuery.of(context).size.width * 0.25,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            '${character.name}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        )
                      ],
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text("Appearance",
                              style: Theme.of(context).textTheme.bodySmall),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 2.5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(info[index - 1][0]),
                            Text(info[index - 1][1])
                            // Text(info[index - 1][0]),
                            // Text(info[index - 1][1])
                          ],
                        ),
                      );
                    },
                    itemCount: info.length + 1,
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(
                      color: Colors.white,
                    ),
                  ),
                  if(provider.isLoading) const Center(child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ))
                  else Column(
                    children: [
                      Visibility(
                          visible: provider.movies.isNotEmpty,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30.0,
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: Text("Movies",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    );
                                  }
                                  var movie = provider.movies[index - 1];
                                  return ListTile(
                                    title: Text(
                                      movie.title ?? "No name",
                                      style: Theme.of(context).textTheme.bodyMedium,
                                    ),
                                    // onTap: () {},
                                    trailing: IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pushReplacement(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    MoviesPage(url: movie.url!)));
                                      },
                                      icon: const Icon(Icons.keyboard_arrow_right),
                                      color: Colors.white,
                                    ),
                                  );
                                },
                                itemCount: provider.movies.length + 1,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                const Divider(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )),
                      Visibility(
                        visible: provider.starships.isNotEmpty,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30.0,
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("Starships",
                                        style:
                                        Theme.of(context).textTheme.bodySmall),
                                  );
                                }
                                var starship = provider.starships[index - 1];
                                return ListTile(
                                  title: Text(
                                    starship.name ?? "No name",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  // onTap: () {},
                                  // trailing: IconButton(
                                  //   onPressed: () {
                                  //     print("Navigated");
                                  //   },
                                  //   icon:
                                  //   const Icon(Icons.keyboard_arrow_right),
                                  //   color: Colors.white,
                                  // ),
                                );
                              },
                              itemCount: provider.starships.length + 1,
                              separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: provider.vehicles.isNotEmpty,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30.0,
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("Vehicles",
                                        style:
                                        Theme.of(context).textTheme.bodySmall),
                                  );
                                }
                                var vehicle = provider.vehicles[index - 1];
                                return ListTile(
                                  title: Text(
                                    vehicle.name ?? "No name",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  // onTap: () {},
                                  // trailing: IconButton(
                                  //   onPressed: () {
                                  //     print("Navigated");
                                  //   },
                                  //   icon:
                                  //   const Icon(Icons.keyboard_arrow_right),
                                  //   color: Colors.white,
                                  // ),
                                );
                              },
                              itemCount: provider.vehicles.length + 1,
                              separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: provider.species.isNotEmpty,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30.0,
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                if (index == 0) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Text("Species",
                                        style:
                                        Theme.of(context).textTheme.bodySmall),
                                  );
                                }
                                var species = provider.species[index - 1];
                                return ListTile(
                                  title: Text(
                                    species.name ?? "No name",
                                    style: Theme.of(context).textTheme.bodyMedium,
                                  ),
                                  // onTap: () {},
                                  // trailing: IconButton(
                                  //   onPressed: () {
                                  //     print("Navigated");
                                  //   },
                                  //   icon:
                                  //   const Icon(Icons.keyboard_arrow_right),
                                  //   color: Colors.white,
                                  // ),
                                );
                              },
                              itemCount: provider.species.length + 1,
                              separatorBuilder: (BuildContext context, int index) =>
                              const Divider(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          MyBackButton()
        ],
      ),
    );
  }

  List<List<String>> getCharacterInfo() {
    List<List<String>> info = [];
    if (character.height != null)
      info.add(["Height", "${character.height!} cm"]);
    if (character.mass != null) info.add(["Mass", "${character.mass!} kg"]);
    if (character.hairColor != null)
      info.add(["Hair color", character.hairColor!]);
    if (character.skinColor != null)
      info.add(["Skin color", character.skinColor!]);
    if (character.eyeColor != null)
      info.add(["Eye color", character.eyeColor!]);
    if (character.birthYear != null)
      info.add(["Birth year", character.birthYear!]);
    if (character.gender != null) info.add(["Gender", character.gender!]);
    return info;
  }
}
