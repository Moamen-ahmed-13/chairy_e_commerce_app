import 'package:chairy_e_commerce_app/features/product/domain/entities/cart_item.dart';
import 'package:chairy_e_commerce_app/features/product/domain/entities/product.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/cart_bloc/cart_event.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/widgets/custom_app_bar.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants.dart';
import '../blocs/cart_bloc/cart_bloc.dart';
import '../blocs/cart_bloc/cart_state.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductEntity product;
  final String? imageUrl;

  ProductDetailsScreen({
    super.key,
    required this.product,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 20.0, left: 20, right: 20, top: 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                color: Theme.of(context).primaryColor,
              ),
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
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/product-page');
                    },
                    child: Text(
                      'Living Room',
                      style: TextStyle(color: mainColor),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: mainColor,
                    size: 15,
                  ),
                  Expanded(
                    child: Text(
                      '  ${product.title}',
                      style: TextStyle(
                        color: mainColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                  image: DecorationImage(
                    image: imageUrl != null && imageUrl!.isNotEmpty
                        ? AssetImage(imageUrl!)
                        : const AssetImage('assets/images/bouclé_chair.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '₤ ${product.discountPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                product.description,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(height: 20),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return CustomButton(
                    text: 'Add to Cart',
                    onPressed: () {
                      final cartItem = CartItem(
                        id: product.id,
                        title: product.title,
                        price: product.discountPrice,
                        quantity: 1,
                      );
                      context.read<CartBloc>().add(AddToCart(cartItem));
                      Navigator.pushNamed(context, '/cart-page');
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
