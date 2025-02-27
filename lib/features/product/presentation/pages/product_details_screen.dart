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
  ProductDetailsScreen({super.key, this.product, this.imageUrl});
  ProductEntity? product;
  String? imageUrl;

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
                      '  ${product?.title ?? 'Chair'}',
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
                        : const AssetImage('assets/images/6.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    product?.title ?? "Chaire",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '₤ ${product?.discountPrice ?? "90.99"}',
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
                '${product?.description ?? "\nAs the name suggests it, this is the ‘jack of all trades’ of chairs; it goes in any room, with any design and serves multiple purposes that go with all upholstery options.L45 x D47 x H90 cm"}',
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
                      context.read<CartBloc>().add(AddToCartEvent(product!));
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
