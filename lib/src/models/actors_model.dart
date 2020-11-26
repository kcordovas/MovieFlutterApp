/// This class is to init an Actor List
class Cast {
  List<Actor> actors = new List();

  /// Create an constructor to receiver Json List
  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((actor) {
      // Add Actors on list
      actors.add(Actor.fromJsonMap(actor));
    });
  }
}

/// Object Actor
class Actor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
  });

  /// Second Constructor with name fromJsonMap
  Actor.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    knownForDepartment = json['known_for_department '];
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
    castId = json['cast_id'];
    character = json['character'];
    creditId = json['creditId'];
    order = json['order'];
  }

  /// Profile Path URL image
  String getPhoto() {
    if (profilePath == null) {
      return "https://www.kubookstore.com/sca-dev-vinson/img/no_image_available.jpeg";
    }
    return "https://image.tmdb.org/t/p/w500/$profilePath";
  }
}
