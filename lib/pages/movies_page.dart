import 'package:flutter/material.dart';
import 'package:flutter_hf/pages/character_page.dart';

import '../http_data/data/movie.dart';
import '../http_data/data_storage.dart';

class MoviesPage extends StatefulWidget{
  final String url;
  const MoviesPage({super.key, required this.url});

  @override
  State<MoviesPage> createState() => _MoviesPage();
}

class _MoviesPage extends State<MoviesPage>{
  late final String url;
  late Movie movie;

  @override
  void initState() {
    url = widget.url;
    movie = DataStorage().movies.firstWhere((element) => element.url == url);
  }

  @override
  Widget build(BuildContext context) {
    var info = getMovieInfo();

    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
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
                              'assets/${movie.episodeId ?? "unknown"}.png',
                              fit: BoxFit.fitWidth,
                              width: MediaQuery.of(context).size.width * 0.25,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Text(
                              movie.title ?? "",
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
                                  child: Text("Details",
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
                                    Padding(padding: const EdgeInsets.only(right: 20.0), child: Text(info[index - 1][0]),),
                                    Flexible(child: Text(/*"${info[index - 1][1].length > 15 ? info[index - 1][1].substring(0,15) + "..." : info[index - 1][1]}"*/ info[index - 1][1],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),),
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
                                  child: Text("Characters",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall),
                                );
                              }
                              var character = movie.characters![index - 1];
                              return ListTile(
                                title: Text(
                                  character.name ?? "No name",
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                // onTap: () {},
                                trailing: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(builder: (_) => CharacterPage(url: character.url!)));
                                  },
                                  icon: const Icon(Icons.keyboard_arrow_right),
                                  color: Colors.white,
                                ),
                              );
                            },
                            itemCount: movie.characters!.length + 1,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                            const Divider(
                              color: Colors.white,
                            ),
                          ),
                          Visibility(
                            visible: movie.starships!.isNotEmpty,
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
                                  var starship = movie.starships![index - 1];
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
                                itemCount: movie.starships!.length + 1,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                const Divider(
                                  color: Colors.white,
                                ),
                              ),
                            ],),
                          ),
                          Visibility(
                            visible: movie.vehicles!.isNotEmpty,
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
                                  var vehicle = movie.vehicles![index - 1];
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
                                itemCount: movie.vehicles!.length + 1,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                const Divider(
                                  color: Colors.white,
                                ),
                              ),
                            ],),
                          ),
                          Visibility(
                            visible: movie.species!.isNotEmpty,
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
                                  var species = movie.species![index - 1];
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
                                itemCount: movie.species!.length + 1,
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
            )
        )
    );
  }

  List<List<String>> getMovieInfo(){
    List<List<String>> info = [];
    if (movie.episodeId != null) info.add(["Episode", "${movie.episodeId!}"]);
    if (movie.director != null) info.add(["Director", movie.director!]);
    if (movie.producer != null) info.add(["Producer", movie.producer!]);
    if (movie.releaseDate != null) info.add(["Release date", movie.releaseDate!]);
    return info;
  }
}