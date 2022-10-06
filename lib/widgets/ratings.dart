import 'package:flutter/material.dart';

class Ratings extends StatelessWidget {
  final double rating;
  const Ratings({
    Key? key,
    required this.rating,
  }) : super(key: key);

  List<double> _generateRating(double rating) {
    if (rating > 0 && rating < 1) {
      return [0.5];
    } else if (rating == 1) {
      return [1];
    } else if (rating < 2) {
      return [1, 0.5];
    } else if (rating == 2) {
      return [1, 1];
    } else if (rating < 3) {
      return [1, 1, 0.5];
    } else if (rating == 3) {
      return [1, 1, 1];
    } else if (rating < 4) {
      return [1, 1, 1, 0.5];
    } else if (rating == 4) {
      return [1, 1, 1, 1];
    } else if (rating < 5) {
      return [1, 1, 1, 1, 0.5];
    } else if (rating == 5) {
      return [1, 1, 1, 1, 1];
    }
    return [0];
  }

  Widget _ratingView() {
    List<double> ratings = _generateRating(rating);
    if (ratings[0] == 0) {
      return Row(
        children: const [
          Icon(
            Icons.star,
            size: 14,
            color: Color.fromARGB(255, 214, 106, 18),
          )
        ],
      );
    } else {
      return Row(
        children: ratings.map(
          (e) {
            return Icon(
              e == 1.0 ? Icons.star : Icons.star_half,
              size: 14,
              color: const Color.fromARGB(255, 214, 106, 18),
            );
          },
        ).toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ratingView();
  }
}
