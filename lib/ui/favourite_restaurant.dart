import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/enum.dart';
import 'package:restaurant_app/provider/database.dart';
import 'package:restaurant_app/widgets/error_message.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

class FavouriteRestaurant extends StatefulWidget {
  const FavouriteRestaurant({Key? key}) : super(key: key);

  @override
  State<FavouriteRestaurant> createState() => _FavouriteRestaurantState();
}

class _FavouriteRestaurantState extends State<FavouriteRestaurant> {
  bool isShowSearchbar = false;
  final TextEditingController _controllerKeyword = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controllerKeyword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 247, 247, 247),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
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
        leading: !isShowSearchbar
            ? IconButton(
                iconSize: 24,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              )
            : null,
        automaticallyImplyLeading: false,
        title: isShowSearchbar
            ? Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                width: double.infinity,
                height: 40,
                child: Consumer<DatabaseProvider>(
                  builder: (context, state, _) {
                    return TextField(
                      controller: _controllerKeyword,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Cari di sini',
                        prefixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isShowSearchbar = false;
                            });
                            state.getFavouriteRestaurants(null);
                            _controllerKeyword.clear();
                          },
                          icon: const Icon(Icons.arrow_back),
                        ),
                        suffixIcon: _controllerKeyword.value.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _controllerKeyword.clear();
                                  state.getFavouriteRestaurants(null);
                                },
                              )
                            : const SizedBox(
                                width: 0,
                                height: 0,
                              ),
                      ),
                      onChanged: (String value) {
                        state.getFavouriteRestaurants(value);
                      },
                    );
                  },
                ),
              )
            : const Text(
                'Restaurant Favorit',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
        actions: !isShowSearchbar
            ? [
                IconButton(
                  onPressed: () {
                    setState(() {
                      isShowSearchbar = true;
                    });
                  },
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                )
              ]
            : null,
      ),
      body: Consumer<DatabaseProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.hasData) {
            return MasonryGridView.count(
              crossAxisCount: 1,
              itemCount: state.favouriteRestaurants.length,
              itemBuilder: (context, index) {
                return RestaurantCard(
                  data: state.favouriteRestaurants[index],
                );
              },
            );
          } else if (state.state == ResultState.noData) {
            return ErrorMessage(
              message: state.message,
              icon: const Icon(
                Icons.announcement_outlined,
                size: 50,
                color: Color.fromARGB(255, 255, 65, 59),
              ),
            );
          } else {
            return const ErrorMessage(message: 'Terjadi kesalahan');
          }
        },
      ),
    );
  }
}
