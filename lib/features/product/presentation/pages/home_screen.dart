import 'package:chairy_e_commerce_app/config/router/app_router.dart';
import 'package:chairy_e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/home_category.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/home.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    stops: [0.1, 0.7],
                    colors: [
                      Colors.white.withOpacity(1),
                      Colors.white.withOpacity(.0),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 40),
                  child: Column(
                    children: [
                      CustomAppBar(
                        color: Colors.white,
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          textAlign: TextAlign.center,
                          '\nMake Your Interior More Minimalistic & Modern',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          '\nTurn your room with panto into a lot more minimalist and modern with ease and speed',
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.651),
                              height: 1.8,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 15.0),
                  width: MediaQuery.of(context).size.width / 2,
                  child: Text(
                    '\nOur Categories',
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Image.asset('assets/images/home2.png')),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 40.0, top: 40.0, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  HomeCategory(
                    image: 'assets/images/list1.png',
                    title: 'Living Room',
                    description:
                        '\nSofas, loveseats, armchairs, coffee tables, end tables, entertainment centers, bookshelves.',
                  ),
                  SizedBox(height: 20),
                  HomeCategory(
                    image: 'assets/images/home3.png',
                    title: 'Bedroom',
                    description:
                        '\Beds, nightstands, dressers, chests of drawers, wardrobes, vanities.',
                  ),
                  SizedBox(height: 20),
                  HomeCategory(
                    image: 'assets/images/home4.png',
                    title: 'Kitchen',
                    description:
                        '\nKitchen cabinets, kitchen islands, dining tables, chairs.',
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Image.asset('assets/images/vector2.png'),
              ],
            ),
            HomeCategory(
              title: '\nFurnish Your Dreams, Choose Wisely',
              description:
                  '\nDiscover quality furniture, curated styles, and exceptional service at Our Store. We make furnishing your home easy and enjoyable.',
              image: 'assets/images/home5.png',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset('assets/images/vector1.png'),
              ],
            ),
            Container(
              width: double.infinity,
              height: 510,
              color: Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Text(
                      'SOME OF OUR',
                      style: TextStyle(
                        color: mainColor,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Features We Offer To You',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 350,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(width: 20),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/images/Frame.png'),
                          ),
                          SizedBox(width: 15),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/images/list2.png'),
                          ),
                          SizedBox(width: 15),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('assets/images/list3.png'),
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Image.asset('assets/images/Group.png'),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
