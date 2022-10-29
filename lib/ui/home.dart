import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/enum.dart';
import 'package:restaurant_app/data/api/api_services.dart';
import 'package:restaurant_app/provider/database.dart';
import 'package:restaurant_app/provider/restaurant.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/widgets/error_message.dart';
import 'package:restaurant_app/widgets/loading_indicator.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';
import 'package:restaurant_app/widgets/slide_transition_container.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //To unfocus TextField when tap outside TextField
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: ChangeNotifierProvider(
        create: (_) => RestaurantProvider(apiServices: ApiService()),
        child: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controllerKeyword = TextEditingController();
  final NotificationHelper _notificationHelper = NotificationHelper();
  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject('/restaurantDetail');
  }

  @override
  void dispose() {
    _controllerKeyword.dispose();
    super.dispose();
    selectNotificationSubject.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        centerTitle: false,
        elevation: 0,
        title: const Text(
          'Restopedia',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35,
            color: Colors.white,
            fontFamily: 'DancingScript',
          ),
        ),
        actions: [
          Consumer<DatabaseProvider>(builder: (context, state, _) {
            return IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/favouriteRestaurant');
                state.getFavouriteRestaurants(null);
              },
              icon: const Icon(
                Icons.favorite_outline,
                color: Colors.white,
              ),
            );
          }),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(
              Icons.settings_outlined,
              color: Colors.white,
            ),
          ),
        ],
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 214, 106, 18),
                Color.fromARGB(255, 255, 65, 59)
              ],
            ),
          ),
        ),
        bottom: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            padding: const EdgeInsets.only(bottom: 2, left: 10),
            width: double.infinity,
            height: 40,
            child: Consumer<RestaurantProvider>(
              builder: (context, state, _) {
                return TextField(
                  controller: _controllerKeyword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Cari',
                    suffixIcon: _controllerKeyword.value.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(
                              Icons.clear,
                            ),
                            onPressed: () {
                              _controllerKeyword.clear();
                              state.fetchRestaurantList(null);
                            },
                          )
                        : const SizedBox(
                            width: 0,
                            height: 0,
                          ),
                  ),
                  onChanged: (String value) {
                    if (value == '') {
                      state.fetchRestaurantList(null);
                    } else {
                      state.fetchRestaurantList(value);
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
      body: Consumer<RestaurantProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const LoadingIndicator();
          } else if (state.state == ResultState.hasData) {
            return MasonryGridView.count(
              crossAxisCount: 1,
              itemCount: state.restaurantList.restaurants.length,
              itemBuilder: (context, index) {
                return SlideTransitionContainer(
                  child: RestaurantCard(
                    data: state.restaurantList.restaurants[index],
                  ),
                );
              },
            );
          } else if (state.state == ResultState.noData) {
            return ErrorMessage(message: state.message);
          } else if (state.state == ResultState.noConnection) {
            return ErrorMessage(
              message: state.message,
              icon: const Icon(
                Icons.signal_wifi_off_outlined,
                size: 50,
                color: Color.fromARGB(255, 255, 65, 59),
              ),
            );
          } else {
            return ErrorMessage(message: state.message);
          }
        },
      ),
    );
  }
}
