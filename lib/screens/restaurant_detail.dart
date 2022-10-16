import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/data/models/restaurants.dart';
import 'package:restaurant_app/provider/restaurant_detail.dart';
import 'package:restaurant_app/widgets/error_message.dart';
import 'package:restaurant_app/widgets/field_add_review.dart';
import 'package:restaurant_app/widgets/image_network.dart';
import 'package:restaurant_app/widgets/loading_indicator.dart';
import 'package:restaurant_app/widgets/menu_card.dart';
import 'package:restaurant_app/widgets/ratings.dart';
import 'package:restaurant_app/widgets/review_card.dart';

class RestaurantDetail extends StatelessWidget {
  const RestaurantDetail({Key? key, required this.data}) : super(key: key);
  final RestaurantModel data;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ChangeNotifierProvider(
        create: (_) => RestaurantDetailProvider(
          apiServices: ApiService(),
          id: data.id,
        ),
        child: RestaurantDetailScreen(
          data: data,
        ),
      ),
    );
  }
}

class RestaurantDetailScreen extends StatelessWidget {
  final RestaurantModel data;
  const RestaurantDetailScreen({Key? key, required this.data})
      : super(key: key);

  SliverAppBar _appBar() {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        ),
      ),
      pinned: true,
      floating: true,
      snap: false,
      flexibleSpace: Container(
        height: 300,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color.fromARGB(255, 214, 106, 18),
              Color.fromARGB(255, 255, 65, 59)
            ],
          ),
          image: DecorationImage(
            image: NetworkImage(
                ApiService().imageBaseUrl(pictureId: data.pictureId)),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
          ),
        ),
      ),
      bottom: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: const Color.fromARGB(0, 73, 138, 236),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10.0),
          ),
        ),
        title: SizedBox(
          width: double.infinity,
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                data.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  SliverList _sliverListMainInfo() {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Container(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 247, 247, 247),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  data.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 65, 59),
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 14,
                      color: Color.fromARGB(255, 104, 94, 86),
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      '${data.city} |',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 104, 94, 86),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 3.0,
                      ),
                      child: Ratings(
                        rating: data.rating,
                      ),
                    ),
                    Text(
                      '(${data.rating})',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Color.fromARGB(255, 104, 94, 86),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ImageNetwork(
                    src: ApiService().imageBaseUrl(
                      pictureId: data.pictureId,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                ExpandableText(
                  data.description,
                  expandText: 'lebih banyak.',
                  collapseText: 'lebih sedikit.',
                  linkColor: const Color.fromARGB(255, 214, 106, 18),
                  linkStyle: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromARGB(255, 214, 106, 18),
                  ),
                  maxLines: 5,
                  textAlign: TextAlign.justify,
                  animation: true,
                  animationCurve: Curves.easeIn,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                    color: Color.fromARGB(255, 104, 94, 86),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      body: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return CustomScrollView(
              slivers: [
                _appBar(),
                _sliverListMainInfo(),
                const SliverFillRemaining(
                  child: LoadingIndicator(),
                )
              ],
            );
          } else if (state.state == ResultState.noData) {
            return CustomScrollView(
              slivers: [
                _appBar(),
                _sliverListMainInfo(),
                SliverFillRemaining(
                  child: ErrorMessage(message: state.message),
                )
              ],
            );
          } else if (state.state == ResultState.noConnection) {
            return CustomScrollView(
              slivers: [
                _appBar(),
                _sliverListMainInfo(),
                SliverFillRemaining(
                  child: ErrorMessage(
                    message: state.message,
                    icon: const Icon(
                      Icons.signal_wifi_off_outlined,
                      size: 50,
                      color: Color.fromARGB(255, 255, 65, 59),
                    ),
                  ),
                )
              ],
            );
          } else if (state.state == ResultState.error) {
            return CustomScrollView(
              slivers: [
                _appBar(),
                _sliverListMainInfo(),
                SliverFillRemaining(
                  child: ErrorMessage(message: state.message),
                )
              ],
            );
          }
          return CustomScrollView(
            slivers: [
              _appBar(),
              _sliverListMainInfo(),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 247, 247, 247),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: const Text(
                        "Menu yang ditawarkan oleh restaurant ini, adalah sebagai berikut :",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color.fromARGB(255, 104, 94, 86),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              SliverGrid.count(
                crossAxisSpacing: 3,
                mainAxisSpacing: 3,
                crossAxisCount: 3,
                children: [
                  ...state.restaurantDetail.restaurant.menus.foods.map(
                    (e) {
                      return MenuCard(
                        name: e.name,
                        icon: 'assets/images/food_icon.png',
                      );
                    },
                  ).toList(),
                  ...state.restaurantDetail.restaurant.menus.drinks.map(
                    (e) {
                      return MenuCard(
                        name: e.name,
                        icon: 'assets/images/drink_icon.png',
                      );
                    },
                  ).toList()
                ],
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(30, 255, 65, 59),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 15,
                      ),
                      margin: const EdgeInsets.only(
                        top: 25,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          FieldAddReview(restaurantId: data.id),
                          const Text(
                            'Semua Review',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color.fromARGB(255, 104, 94, 86),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          ...state.restaurantDetail.restaurant.customerReviews
                              .reversed
                              .map(
                            (e) {
                              return ReviewCard(review: e);
                            },
                          ).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
