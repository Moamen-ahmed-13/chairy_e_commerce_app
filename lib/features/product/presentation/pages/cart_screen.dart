import 'package:chairy_e_commerce_app/constants.dart';
import 'package:chairy_e_commerce_app/features/product/domain/entities/product.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/cart_bloc/cart_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/cart_bloc/cart_bloc.dart';
import '../blocs/cart_bloc/cart_state.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import 'product_details_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  static const List<String> assetImages = [
    "assets/images/baltsar_ikea_chair.png",
    "assets/images/luxury_velvet_chair.png",
    "assets/images/scandinavian_chair.png",
    "assets/images/saarinen_executive_chair.png",
    "assets/images/beech_wood_chair.png",
    "assets/images/bouclé_chair.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40),
        child: Column(
          children: [
            CustomAppBar(
              color: Theme.of(context).primaryColor,
            ),
            Stack(
              children: [
                Positioned(
                    child: Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/cart1.png'))),
                )),
                Positioned(
                  top: 50,
                  left: 120,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Your Cart',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Review Your Items',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return Center(
                      child: CircularProgressIndicator(color: mainColor),
                    );
                  } else if (state is CartLoaded) {
                    if (state.cartItems.isEmpty) {
                      return _buildEmptyCart();
                    }
                    return _buildCartList(state);
                  } else if (state is CartError) {
                    return Center(child: Text("Failed to load cart items"));
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
            _buildCartSummary(context),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/empty_cart.png",
          height: 200,
          width: 200,
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "Cart is empty",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  Widget _buildCartList(CartLoaded state) {
    return Container(
      width: double.infinity,
      child: ListView.builder(
        itemCount: state.cartItems.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    product: state.cartItems[index],
                    imageUrl:
                        _getProductImagePath(state.cartItems[index].title),
                  ),
                ),
              );
            },
            child: ListTile(
              title: Text(
                state.cartItems[index].title,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
              ),
              subtitle: SizedBox(
                width: 100,
                child: _quantityControls(context, state.cartItems[index]),
              ),
              leading: Image.asset(
                  _getProductImagePath(state.cartItems[index].title),
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset('assets/images/bouclé_chair.png'),
                  height: 70,
                  width: 70,
                  fit: BoxFit.cover),
              trailing: Text(
                '₤ ${state.cartItems[index].discountPrice}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
              ),
            ),
          );
        },
      ),
    );
  }

  String _getProductImagePath(String title) {
    String formattedTitle = title
        .toLowerCase()
        .replaceAll(' ', '_'); // استبدال المسافات بشرطة سفلية
    return 'assets/images/$formattedTitle.png'; // إرجاع المسار الصحيح
  }

  Widget _quantityControls(BuildContext context, ProductEntity cartItem) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove, color: mainColor),
          onPressed: () {
            context.read<CartBloc>().add(UpdateCartQuantity(cartItem, -1));
          },
        ),
        Text(
          cartItem.quantity.toString(),
          style: TextStyle(fontSize: 16),
        ),
        IconButton(
          icon: Icon(Icons.add, color: mainColor),
          onPressed: () {
            context.read<CartBloc>().add(UpdateCartQuantity(cartItem, 1));
          },
        ),
      ],
    );
  }

  Widget _buildCartSummary(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          // final totalPrice = state.cartItems.fold(
          //     0.0,
          //     (num sum, item) =>
          //         sum +
          //         ((double.tryParse(item.discountPrice ?? '0.0') ?? 0.0) *
          //             item.quantity));

          return Column(
            children: [
              Divider(),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '₤ ${state.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 10),
              CustomButton(
                text: 'Place Order',
                onPressed: () {
                  Navigator.pushNamed(context, '/checkout');
                },
              ),
              SizedBox(height: 10),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
