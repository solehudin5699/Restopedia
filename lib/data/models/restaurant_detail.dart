class RestaurantDetailModel {
  RestaurantDetailModel({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  bool error;
  String message;
  RestaurantModel restaurant;

  factory RestaurantDetailModel.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailModel(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantModel.fromJson(json["restaurant"]),
      );
}

class RestaurantModel {
  RestaurantModel({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  List<CategoryModel> categories;
  MenusModel menus;
  double rating;
  List<CustomerReviewModel> customerReviews;

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<CategoryModel>.from(
          json["categories"].map(
            (x) => CategoryModel.fromJson(x),
          ),
        ),
        menus: MenusModel.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReviewModel>.from(
          json["customerReviews"].map(
            (x) => CustomerReviewModel.fromJson(x),
          ),
        ),
      );
}

class CategoryModel {
  CategoryModel({
    required this.name,
  });

  String name;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        name: json["name"],
      );
}

class CustomerReviewModel {
  CustomerReviewModel({
    required this.name,
    required this.review,
    required this.date,
  });

  String name;
  String review;
  String date;

  factory CustomerReviewModel.fromJson(Map<String, dynamic> json) =>
      CustomerReviewModel(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );
}

class MenusModel {
  MenusModel({
    required this.foods,
    required this.drinks,
  });

  List<CategoryModel> foods;
  List<CategoryModel> drinks;

  factory MenusModel.fromJson(Map<String, dynamic> json) => MenusModel(
        foods: List<CategoryModel>.from(
          json["foods"].map(
            (x) => CategoryModel.fromJson(x),
          ),
        ),
        drinks: List<CategoryModel>.from(
          json["drinks"].map(
            (x) => CategoryModel.fromJson(x),
          ),
        ),
      );
}
