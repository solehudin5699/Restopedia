import 'package:flutter/material.dart';
import 'package:restaurant_app/data/models/restaurant_detail.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key, required this.review}) : super(key: key);

  final CustomerReviewModel review;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      margin: const EdgeInsets.only(
        top: 5,
        bottom: 3,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.person_outline_rounded,
                color: Color.fromARGB(255, 214, 106, 18),
                size: 14,
              ),
              const SizedBox(
                width: 3,
              ),
              Expanded(
                child: Text(
                  review.name,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 104, 94, 86),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Text(
            review.date,
            style: const TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.normal,
              color: Color.fromARGB(255, 104, 94, 86),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.question_answer_rounded,
                color: Color.fromARGB(255, 214, 106, 18),
                size: 18,
              ),
              const SizedBox(
                width: 3,
              ),
              Expanded(
                child: Text(
                  review.review,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 104, 94, 86),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
