class RestaurantsModel {
  RestaurantsModel({
    required this.error,
    this.message,
    this.count,
    this.founded,
    required this.restaurants,
  });

  bool error;
  String? message;
  int? count;
  int? founded;
  List<RestaurantModel> restaurants;

  factory RestaurantsModel.fromJson(Map<String, dynamic> json) =>
      RestaurantsModel(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantModel>.from(
          json["restaurants"].map(
            (x) => RestaurantModel.fromJson(x),
          ),
        ),
      );
}

class RestaurantModel {
  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  String id;
  String name;
  String description;
  String pictureId;
  String city;
  double rating;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
      );
}
