import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/models/restaurants.dart';
import 'package:restaurant_app/widgets/image_network.dart';
import 'package:restaurant_app/widgets/ratings.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantModel data;
  const RestaurantCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      clipBehavior: Clip.none,
      child: InkWell(
        onTap: (() {
          Navigator.pushNamed(context, '/restaurantDetail', arguments: data);
        }),
        splashColor: const Color.fromARGB(100, 255, 65, 59),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 150,
              height: 100,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
                child: Hero(
                  tag: data.pictureId,
                  child: ImageNetwork(
                    src: ApiService().imageBaseUrl(pictureId: data.pictureId),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          data.name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 15,
                        color: Color.fromARGB(255, 104, 94, 86),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        data.city,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Color.fromARGB(255, 104, 94, 86),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 3.0),
                        child: const Ratings(rating: 1),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '(${data.rating})',
                        style: const TextStyle(
                          fontSize: 14.0,
                          color: Color.fromARGB(255, 104, 94, 86),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
