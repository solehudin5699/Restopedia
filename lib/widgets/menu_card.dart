import 'package:flutter/material.dart';

class MenuCard extends StatelessWidget {
  final String name;
  final String icon;
  const MenuCard({
    Key? key,
    required this.name,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      elevation: 1,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(icon),
            ),
            const SizedBox(
              height: 3,
            ),
            Expanded(
              flex: 1,
              child: Text(
                name,
                style: const TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
