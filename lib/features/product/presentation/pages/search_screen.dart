import 'package:chairy_e_commerce_app/features/product/domain/entities/product.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/product_bloc/product_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../blocs/product_bloc/product_bloc.dart';
import '../widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  late List<ProductEntity> searchedProducts;
  late List<ProductEntity> allProducts;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadsearchProducts();
  }

  Future<void> _loadsearchProducts() async {
    final products =
        await BlocProvider.of<ProductBloc>(context).repository.fetchProducts();
    setState(() {
      allProducts = products;
      searchedProducts = products;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'LOGO',
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 30),
                ),
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.close_rounded,
                    color: mainColor,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              '\nChic Furnishings Online Furniture Store',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text('Discover Elegant Comfort for Every Room'),
            SizedBox(height: 30),
            TextField(
              cursorColor: mainColor,
              controller: _searchController,
              onChanged: (value) {
                searchedProducts = allProducts
                    .where((product) => product.title
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                    .toList();
                setState(() {});
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: .5,
                    color: mainColor,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                suffixIcon: Icon(Icons.search, color: mainColor, size: 30),
                labelText: 'Search',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: mainColor,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: mainColor,
                      ),
                    );
                  } else if (state is ProductLoaded) {
                    if (state.products.isEmpty) {
                      return Center(
                        child: Text(
                          'No products found',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: mainColor,
                          ),
                        ),
                      );
                    }
                    return _searchController.text.isNotEmpty
                        ? GridView.builder(
                            padding: EdgeInsets.all(16),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 20,
                                    crossAxisSpacing: 40,
                                    childAspectRatio: .4),
                            itemCount: _searchController.text.isNotEmpty
                                ? searchedProducts.length
                                : allProducts.length,
                            itemBuilder: (context, index) {
                              return ProductCard(
                                  product: _searchController.text.isNotEmpty
                                      ? searchedProducts[index]
                                      : allProducts[index],
                                  index: index);
                            },
                          )
                        : Column(
                            children: [
                              SizedBox(height: 60),
                              Image.asset('assets/images/search.png'),
                            ],
                          );
                    ;
                  } else if (state is ProductError) {
                    return Center(
                      child: Text(
                        'Error loading products',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: mainColor,
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      SizedBox(height: 60),
                      Image.asset('assets/images/search.png'),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
