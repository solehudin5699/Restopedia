import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:restaurant_app/models/restaurants.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //To onfocus TextField when tap outside TextField
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Restaurant>> listRestaurants;

  final TextEditingController _controllerKeyword = TextEditingController();

  @override
  void initState() {
    super.initState();
    listRestaurants = getRestaurants(context, '');
  }

  @override
  void dispose() {
    _controllerKeyword.dispose();
    super.dispose();
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
            child: TextField(
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
                          setState(() {
                            listRestaurants = getRestaurants(context, '');
                          });
                        })
                    : const SizedBox(
                        width: 0,
                        height: 0,
                      ),
              ),
              onChanged: (String value) {
                setState(
                  () {
                    listRestaurants = getRestaurants(context, value);
                  },
                );
              },
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Restaurant>>(
        future: listRestaurants,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            if (data!.isEmpty) {
              return Center(
                child: SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.error_outline,
                          size: 50,
                          color: Color.fromARGB(255, 255, 65, 59),
                        ),
                        Text(
                          'Ups...,pencarian tidak ditemukan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 255, 65, 59),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return MasonryGridView.count(
              crossAxisCount: 1,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return RestaurantCard(data: data[index]);
              },
            );
          } else {
            return const Text(
              "Tidak ada data",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Color.fromARGB(255, 255, 65, 59),
              ),
            );
          }
        },
      ),
    );
  }
}
