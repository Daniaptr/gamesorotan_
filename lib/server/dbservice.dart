class DataGame {
  String id;
  String name;
  String genre;
  String avatar;
  String rating;
  String desk;
  String imageUrl1;
  String imageUrl2;
  String imageUrl3;

  DataGame({
    required this.id,
    required this.name,
    required this.genre,
    required this.avatar,
    required this.rating,
    required this.desk,
    required this.imageUrl1,
    required this.imageUrl2,
    required this.imageUrl3,
  });

  factory DataGame.fromJson(Map<String, dynamic> json) => DataGame(
        id: json["id"],
        name: json["name"],
        genre: json["genre"],
        avatar: json["avatar"],
        rating: json["rating"],
        desk: json["desk"],
        imageUrl1: json["imageUrl1"],
        imageUrl2: json["imageUrl2"],
        imageUrl3: json["imageUrl3"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "genre": genre,
        "avatar": avatar,
        "rating": rating,
        "desk": desk,
        "imageUrl1": imageUrl1,
        "imageUrl2": imageUrl2,
        "imageUrl3": imageUrl3,
      };
}

class MyUser {
  final String email;
  final String nama;
  final String profil;

  MyUser({
    required this.email,
    required this.nama,
    required this.profil,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "nama": nama,
      "profil": profil,
    };
  }

  factory MyUser.fromJson(Map<String, dynamic> json) {
    return MyUser(
      email: json["email"],
      nama: json["nama"],
      profil: json["profil"],
    );
  }
}
