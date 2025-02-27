import 'package:flutter/material.dart';

import '../../../../constants.dart';

class HomeCategory extends StatelessWidget {
  const HomeCategory({
    super.key,
    required this.title,
    required this.description,
    required this.image,
  });
  final String title;
  final String description;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(image),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Text(
            description,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        SizedBox(height: 20),
        TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/product-page');
          },
          child: Text(
            '  More Info >>',
            style: TextStyle(
              color: mainColor,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}
