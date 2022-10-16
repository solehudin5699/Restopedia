class ReviewModel {
  ReviewModel({
    required this.error,
    required this.message,
    required this.customerReviews,
  });

  bool error;
  String message;
  List<CustomerReviewModel> customerReviews;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReviewModel>.from(
          json["customerReviews"].map(
            (x) => CustomerReviewModel.fromJson(x),
          ),
        ),
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
