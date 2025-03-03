import 'package:chairy_e_commerce_app/constants.dart';
import 'package:chairy_e_commerce_app/features/product/domain/entities/product.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/product_bloc/product_event.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/product_bloc/product_bloc.dart';
import '../blocs/product_bloc/product_state.dart';
import '../widgets/product_card.dart';

class ProductPage extends StatefulWidget {
  ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductEntity> products = [];

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40),
              child: CustomAppBar(
                color: Theme.of(context).primaryColor,
              ),
            ),
            Image.asset('assets/images/search.png'),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/home');
                  },
                  child: Text(
                    'Categories',
                    style: TextStyle(color: mainColor),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: mainColor,
                  size: 15,
                ),
                Text(
                  '  Living Room',
                  style: TextStyle(color: mainColor),
                ),
              ],
            ),
            Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('assets/images/home2.png'),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'All Living Room',
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\nSofas, loveseats, armchairs, coffee tables, end tables, entertainment centers, bookshelves.',
                        style: TextStyle(),
                      )
                    ],
                  ),
                ),
              ],
            ),
            productsView(),
          ],
        ),
      ),
    );
  }

  Widget productsView() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state is ProductLoading) {
          return Center(
              child: CircularProgressIndicator(
            color: mainColor,
          ));
        } else if (state is ProductLoaded) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 1.45,
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 40,
                  childAspectRatio: .5,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    productEntity: state.products[index],
                    index: index,
                  );
                }),
          );
        } else if (state is ProductError) {
          print("🔴 Error: ${state.message}");
          return Container(
            height: 100,
            width: double.infinity,
            child: Center(
              child: MaterialButton(
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
                color: Colors.grey.shade300,
                onPressed: () {
                  context.read<ProductBloc>().add(LoadProductEvent());
                },
                child: Container(
                  width: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        Icons.restart_alt_rounded,
                        color: Colors.grey.shade600,
                      ),
                      Text(
                        'Retry',
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return const Center(child: Text('No products available'));
      },
    );
  }
}
