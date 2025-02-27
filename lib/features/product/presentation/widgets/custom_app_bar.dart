import 'package:flutter/material.dart';

import '../../../../config/router/app_router.dart';
import '../../../../constants.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.color,
  });
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'LOGO',
          style: TextStyle(
              color: color,
              fontWeight: FontWeight.w900,
              fontSize: 30),
        ),
        Spacer(),
        IconButton(
          icon: Icon(
            Icons.search,
            color: mainColor,
            size: 35,
          ),
          onPressed: () {
            Navigator.pushNamed(
              context,
              AppRoutes.search,
            );
          },
        ),
        IconButton(
          icon: Icon(
            Icons.menu,
            weight: 900,
            color: mainColor,
            size: 35,
          ),
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.settingsMenu);
          },
        ),
      ],
    );
  }
}
