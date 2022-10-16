import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/snackbar.dart';
import 'package:restaurant_app/provider/restaurant_detail.dart';

class FieldAddReview extends StatefulWidget {
  const FieldAddReview({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  final String restaurantId;
  @override
  State<StatefulWidget> createState() => _FieldAddReviewState();
}

class _FieldAddReviewState extends State<FieldAddReview> {
  final TextEditingController _controllerFieldReview = TextEditingController();
  final TextEditingController _controllerFieldName = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controllerFieldReview.dispose();
    _controllerFieldName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 10,
      ),
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 10,
      ),
      child: Column(
        children: [
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 4,
            controller: _controllerFieldReview,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Tulis review di sini...',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _controllerFieldName,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                      hintText: 'Nama',
                      label: Text('Kirim review sebagai...'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 214, 106, 18),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Consumer<RestaurantDetailProvider>(
                builder: (context, state, _) {
                  void onSubmit() async {
                    try {
                      await state.addReview(
                        id: widget.restaurantId,
                        name: _controllerFieldName.value.text,
                        review: _controllerFieldReview.value.text,
                      );
                      if (state.state == ResultState.hasDataAdd) {
                        _controllerFieldReview.clear();
                        _controllerFieldName.clear();
                      }
                      snackbar(context, state.message);
                    } catch (_) {
                      snackbar(context, state.message);
                    }
                  }

                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(120, 40),
                    ),
                    onPressed: () {
                      if (_controllerFieldReview.value.text != '' &&
                          _controllerFieldName.value.text != '') {
                        onSubmit();
                      } else if (_controllerFieldReview.value.text == '') {
                        snackbar(context, 'Review harus diisi');
                      } else if (_controllerFieldName.value.text == '') {
                        snackbar(context, 'Nama harus diisi');
                      }
                    },
                    child: Text(
                      state.state == ResultState.loadingAdd
                          ? "Loading..."
                          : "Kirim",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
