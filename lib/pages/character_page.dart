import 'package:flutter/material.dart';
import 'package:flutter_hf/http_data/data/character.dart';
import 'package:flutter_hf/http_data/data_storage.dart';
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

  @override
  void initState() {
    url = widget.url;
    character = DataStorage().characters.firstWhere((element) => element.url == url);
  }

  @override
  Widget build(BuildContext context) {
    var info = getCharacterInfo();

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
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 50.0),
                            child: Image.asset(
                              'assets/unknown.png',
                              fit: BoxFit.fitWidth,
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Text(
                              character.name ?? "",
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              if (index == 0) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text("Appearance",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                );
                              }
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 2.5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(info[index - 1][0]),
                                    Text(info[index - 1][1])
                                  ],
                                ),
                              );
                            },
                            itemCount: info.length + 1,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
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
                              var movie = character.movies[index - 1];
                              return ListTile(
                                title: Text(
                                  movie.title ?? "No name",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                // onTap: () {},
                                trailing: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (_) => MoviesPage(url: movie.url!)));
                                  },
                                  icon: const Icon(Icons.keyboard_arrow_right),
                                  color: Colors.white,
                                ),
                              );
                            },
                            itemCount: character.movies.length + 1,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const Divider(
                              color: Colors.white,
                            ),
                          ),
                          Visibility(
                            visible: character.starships.isNotEmpty,
                            child: Column(children: [
                              const SizedBox(height: 30.0,),
                              ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: Text("Starships",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    );
                                  }
                                  var starship = character.starships[index - 1];
                                  return ListTile(
                                    title: Text(
                                      starship.name ?? "No name",
                                      style:
                                      Theme.of(context).textTheme.bodyMedium,
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
                                itemCount: character.starships.length + 1,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                const Divider(
                                  color: Colors.white,
                                ),
                              ),
                            ],),
                          ),
                          Visibility(
                            visible: character.vehicles.isNotEmpty,
                            child: Column(children: [
                              const SizedBox(height: 30.0,),
                              ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: Text("Vehicles",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    );
                                  }
                                  var vehicle = character.vehicles[index - 1];
                                  return ListTile(
                                    title: Text(
                                      vehicle.name ?? "No name",
                                      style:
                                      Theme.of(context).textTheme.bodyMedium,
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
                                itemCount: character.vehicles.length + 1,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                const Divider(
                                  color: Colors.white,
                                ),
                              ),
                            ],),
                          ),
                          Visibility(
                            visible: character.species.isNotEmpty,
                            child: Column(children: [
                              const SizedBox(height: 30.0,),
                              ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index == 0) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: Text("Species",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall),
                                    );
                                  }
                                  var species = character.species[index - 1];
                                  return ListTile(
                                    title: Text(
                                      species.name ?? "No name",
                                      style:
                                      Theme.of(context).textTheme.bodyMedium,
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
                                itemCount: character.species.length + 1,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                const Divider(
                                  color: Colors.white,
                                ),
                              ),
                            ],),
                          ),
                        ],
                      ),
                    )
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

  List<List<String>> getCharacterInfo() {
    List<List<String>> info = [];
    if (character.height != null) info.add(["Height", "${character.height!} cm"]);
    if (character.mass != null) info.add(["Mass", "${character.mass!} kg"]);
    if (character.hairColor != null) info.add(["Hair color", character.hairColor!]);
    if (character.skinColor != null) info.add(["Skin color", character.skinColor!]);
    if (character.eyeColor != null) info.add(["Eye color", character.eyeColor!]);
    if (character.birthYear != null) info.add(["Birth year", character.birthYear!]);
    if (character.gender != null) info.add(["Gender", character.gender!]);
    return info;
  }
}
