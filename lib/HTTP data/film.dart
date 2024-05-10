class Film {
  String? title;
  num? episodeId;
  String? openingCrawl;
  String? director;
  String? producer;
  String? releaseDate;
  List<String>? characters;
  List<String>? planets;
  List<String>? starships;
  List<String>? vehicles;
  List<String>? species;
  String? created;
  String? edited;
  String? url;

  Film({
      this.title, 
      this.episodeId, 
      this.openingCrawl, 
      this.director, 
      this.producer, 
      this.releaseDate, 
      this.characters, 
      this.planets, 
      this.starships, 
      this.vehicles, 
      this.species, 
      this.created, 
      this.edited, 
      this.url,});

  Film.fromJson(dynamic json) {
    print("Beginning");
    title = json['title'];
    print("Title done");
    episodeId = json['episode_id'];
    print("EpisodeID done");
    openingCrawl = json['opening_crawl'];
    print("opening done");
    director = json['director'];
    print("director done");
    producer = json['producer'];
    print("producer done");
    releaseDate = json['release_date'];
    print("release done");
    characters = json['characters'] != null ? json['characters'].cast<String>() : [];
    print("characters done");
    planets = json['planets'] != null ? json['planets'].cast<String>() : [];
    print("planets done");
    starships = json['starships'] != null ? json['starships'].cast<String>() : [];
    print("starships done");
    vehicles = json['vehicles'] != null ? json['vehicles'].cast<String>() : [];
    print("vahicles done");
    species = json['species'] != null ? json['species'].cast<String>() : [];
    print("species done");
    created = json['created'];
    print("created done");
    edited = json['edited'];
    print("edited done");
    url = json['url'];
    print("url done");
  }

  Film copyWith({  String? title,
    num? episodeId,
    String? openingCrawl,
    String? director,
    String? producer,
    String? releaseDate,
    List<String>? characters,
    List<String>? planets,
    List<String>? starships,
    List<String>? vehicles,
    List<String>? species,
    String? created,
    String? edited,
    String? url,
  }) => Film(  title: title ?? this.title,
    episodeId: episodeId ?? this.episodeId,
    openingCrawl: openingCrawl ?? this.openingCrawl,
    director: director ?? this.director,
    producer: producer ?? this.producer,
    releaseDate: releaseDate ?? this.releaseDate,
    characters: characters ?? this.characters,
    planets: planets ?? this.planets,
    starships: starships ?? this.starships,
    vehicles: vehicles ?? this.vehicles,
    species: species ?? this.species,
    created: created ?? this.created,
    edited: edited ?? this.edited,
    url: url ?? this.url,
  );
}