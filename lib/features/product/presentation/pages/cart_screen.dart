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
                    print(state.message);
                    return Center(child: Text("Failed to load cart items"));
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
            _buildCartTotalPrice(context),
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
              // ✅ Convert `CartItem` to `ProductEntity` before passing it
              ProductEntity productEntity = ProductEntity(
                id: state.cartItems[index].id,
                title: state.cartItems[index].title,
                description:
                    "The ${state.cartItems[index].title} combines modern elegance with exceptional comfort. Designed for professionals, this chair features a sleek, ergonomic design with premium leather upholstery and a swivel base, making it perfect for office spaces or home offices. Its timeless design ensures it complements any decor.", // Add proper description
                price: state.cartItems[index].price,
                discount: "0", // Adjust discount if needed
                discountPrice: state.cartItems[index].price, // Modify if needed
                quantity: state.cartItems[index].quantity,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailsScreen(
                    product: productEntity,
                    imageUrl:
                        _getProductImagePath(state.cartItems[index].title),
                  ),
                ),
              );
            },
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Container(
                height: 150,
                width: 70,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                      _getProductImagePath(state.cartItems[index].title),
                    ),
                  ),
                ),
              ),
              title: Text(
                "    ${state.cartItems[index].title}",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {
                        context
                            .read<CartBloc>()
                            .add(RemoveFromCart(state.cartItems[index].id));
                      },
                      icon: Icon(
                        Icons.delete_outline_outlined,
                        color: Colors.red,
                      )),
                  SizedBox(width: 8),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: IconButton(
                      iconSize: 15,
                      style: IconButton.styleFrom(
                        backgroundColor: mainColor,
                      ),
                      color: Colors.white,
                      icon: Icon(Icons.remove),
                      onPressed: () {
                        if (state.cartItems[index].quantity > 1) {
                          context.read<CartBloc>().add(UpdateCartQuantity(
                              state.cartItems[index].id,
                              state.cartItems[index].quantity - 1));
                        } else {
                          context
                              .read<CartBloc>()
                              .add(RemoveFromCart(state.cartItems[index].id));
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    state.cartItems[index].quantity.toString(),
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: IconButton(
                      iconSize: 15,
                      style: IconButton.styleFrom(
                        backgroundColor: mainColor,
                      ),
                      color: Colors.white,
                      icon: Icon(Icons.add),
                      onPressed: () {
                        context.read<CartBloc>().add(UpdateCartQuantity(
                            state.cartItems[index].id,
                            state.cartItems[index].quantity + 1));
                      },
                    ),
                  ),
                ],
              ),
              trailing: Text(
                '₤ ${state.cartItems[index].price.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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

  Widget _buildCartTotalPrice(BuildContext context) {
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
