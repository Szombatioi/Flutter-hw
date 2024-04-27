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
    title = json['title'];
    episodeId = json['episode_id'];
    openingCrawl = json['opening_crawl'];
    director = json['director'];
    producer = json['producer'];
    releaseDate = json['release_date'];
    characters = json['characters'] != null ? json['characters'].cast<String>() : [];
    planets = json['planets'] != null ? json['planets'].cast<String>() : [];
    starships = json['starships'] != null ? json['starships'].cast<String>() : [];
    vehicles = json['vehicles'] != null ? json['vehicles'].cast<String>() : [];
    species = json['species'] != null ? json['species'].cast<String>() : [];
    created = json['created'];
    edited = json['edited'];
    url = json['url'];
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