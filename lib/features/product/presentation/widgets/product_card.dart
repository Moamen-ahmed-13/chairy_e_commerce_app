import 'package:chairy_e_commerce_app/constants.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/cart_bloc/cart_event.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/cart_bloc/cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product.dart';
import '../pages/product_details_screen.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product, required this.index});
  final ProductEntity product;
  final int index;
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
    String imageUrl = assetImages[index % assetImages.length];
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(
              product: product,
              imageUrl: imageUrl,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12)),
                          color: Colors.grey.shade100),
                    ),
                  ],
                ),
                imageUrl.isNotEmpty
                    ? Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      )
                    : Center(
                        child: const Icon(Icons.image,
                            size: 50, color: Colors.grey)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chair',
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
                Text(
                  product.title ?? '',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 20),
                product.discount != '0.00' ? hasDiscount() : hasNoDiscount(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget hasDiscount() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '₤',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(width: 4),
            Text(
              '${product.price}',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Text(
              '₤',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 4),
            Text(
              product.discountPrice.toString(),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                  color: mainColor, borderRadius: BorderRadius.circular(20)),
              child: Text(
                "${product.discount}%",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    context.read<CartBloc>().add(AddToCartEvent(product!));
                    print('add to cart');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget hasNoDiscount() {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Text(
              '₤',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 4),
            Text(
              '${product.price}',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return GestureDetector(
                  onTap: () {
                    context.read<CartBloc>().add(AddToCartEvent(product!));
                    print('add to cart');
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
