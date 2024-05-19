import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hf/pages/character_page.dart';
import 'package:flutter_hf/pages/widgets.dart';
import 'package:provider/provider.dart';
import '../http_data/data/movie.dart';
import '../providers/swapi_provider.dart';

class MoviesPage extends StatefulWidget {
  final String url;

  const MoviesPage({super.key, required this.url});

  @override
  State<MoviesPage> createState() => _MoviesPage();
}

class _MoviesPage extends State<MoviesPage> {
  late final String url;
  late Movie movie;
  String assetName = 'assets/unknown.png';

  @override
  void initState() {
    super.initState();
    url = widget.url;

    final provider = Provider.of<SwapiProvider>(context, listen: false);
    movie = provider.movies.singleWhere((element) => element.url == url);

    provider.loadMovieInfo(movie).then((value) => setState(() {}));

    provider
        .assetExists('assets/${movie.episodeId}.png')
        .then((value) => setState(() {
              log("Movie image exists? $value");
              assetName = value
                  ? 'assets/${movie.episodeId}.png'
                  : 'assets/unknown.png';
            }));
  }

  @override
  Widget build(BuildContext context) {
    var info = getMovieInfo();
    final provider = Provider.of<SwapiProvider>(context, listen: true);

    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
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
                              assetName,
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
                            physics: const NeverScrollableScrollPhysics(),
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
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: Text(info[index - 1][0]),
                                    ),
                                    Flexible(
                                      child: Text(
                                        info[index - 1][1],
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                    ),
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
                          if (provider.isLoading)
                            const Center(
                                child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ))
                          else
                            Column(
                              children: [
                                Visibility(
                                    visible: provider.characters.isNotEmpty,
                                    child: Column(
                                      children: [
                                        const SizedBox(
                                          height: 30.0,
                                        ),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (index == 0) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20.0),
                                                child: Text("Characters",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall),
                                              );
                                            }
                                            var character =
                                                provider.characters[index - 1];
                                            return ListTile(
                                              title: Text(
                                                character.name ?? "No name",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                              // onTap: () {},
                                              trailing: IconButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  CharacterPage(
                                                                      url: character
                                                                          .url!)));
                                                },
                                                icon: const Icon(
                                                    Icons.keyboard_arrow_right),
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                          itemCount:
                                              provider.characters.length + 1,
                                          separatorBuilder:
                                              (BuildContext context,
                                                      int index) =>
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
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (index == 0) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text("Starships",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                            );
                                          }
                                          var starship =
                                              provider.starships[index - 1];
                                          return ListTile(
                                            title: Text(
                                              starship.name ?? "No name",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          );
                                        },
                                        itemCount:
                                            provider.starships.length + 1,
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
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
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (index == 0) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text("Vehicles",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                            );
                                          }
                                          var vehicle =
                                              provider.vehicles[index - 1];
                                          return ListTile(
                                            title: Text(
                                              vehicle.name ?? "No name",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          );
                                        },
                                        itemCount: provider.vehicles.length + 1,
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
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
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          if (index == 0) {
                                            return Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text("Species",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall),
                                            );
                                          }
                                          var species =
                                              provider.species[index - 1];
                                          return ListTile(
                                            title: Text(
                                              species.name ?? "No name",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium,
                                            ),
                                          );
                                        },
                                        itemCount: provider.species.length + 1,
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
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
                    )
                  ],
                ),
                MyBackButton(),
              ],
            )));
  }

  List<List<String>> getMovieInfo() {
    List<List<String>> info = [];
    if (movie.episodeId != null) info.add(["Episode", "${movie.episodeId!}"]);
    if (movie.director != null) info.add(["Director", movie.director!]);
    if (movie.producer != null) info.add(["Producer", movie.producer!]);
    if (movie.releaseDate != null) info.add(["Release date", movie.releaseDate!]);
    return info;
  }
}
