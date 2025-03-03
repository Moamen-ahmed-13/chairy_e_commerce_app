import 'package:chairy_e_commerce_app/constants.dart';
import 'package:chairy_e_commerce_app/features/product/domain/entities/cart_item.dart';
import 'package:chairy_e_commerce_app/features/product/domain/entities/product.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/cart_bloc/cart_bloc.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/cart_bloc/cart_event.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/cart_bloc/cart_state.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/check_out_bloc/checkout_state.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/pages/product_details_screen.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/widgets/custom_button.dart';
import 'package:chairy_e_commerce_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../blocs/check_out_bloc/checkout_bloc.dart';
import '../../blocs/check_out_bloc/checkout_event.dart';

class Review extends StatelessWidget {
  const Review({super.key});

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'chairy_app_channel',
      'Chairy App Notifications',
      channelDescription: 'This channel is used for Chairy app notifications.',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Chairy App',
      'Your Order Has Been Placed Successfully!',
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Text(
                    'Your Customer Data For The Order',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Bringing Your Style Home',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25),
            _buildInfoSection(context),
            SizedBox(height: 20),
            _buildCartSummary(context),
            SizedBox(height: 10),
            Divider(),
            _buildTotalPrice(context),
            SizedBox(height: 20),
            CustomButton(
              onPressed: () {
                BlocProvider.of<CheckoutBloc>(context).add(ChangeStepEvent(4));
                showNotification();
              },
              text: 'Place Order',
            ),
          ],
        ),
      ),
    );
  }

  /// ✅ **عرض عنوان الشحن وطريقة الدفع**
  Widget _buildInfoSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfoCard(
          'Delivery Address',
          '123 Main St, Apt 101, New York, NY 10001',
          context,
        ),
        BlocBuilder<CheckoutBloc, CheckoutState>(
          builder: (context, state) {
            String paymentMethod = state.paymentMethod.isNotEmpty
                ? state.paymentMethod
                : 'No Payment Selected';
            String? paymentImage;

            if (state.paymentMethod == 'card') {
              paymentImage = 'assets/images/mastercard.png';
            } else if (state.paymentMethod == 'paypal') {
              paymentImage = 'assets/images/paypal.png';
            }

            return _buildInfoCard('Payment', paymentMethod, context,
                image: paymentImage);
          },
        ),
      ],
    );
  }

  /// ✅ **كارت معلومات العنوان أو الدفع**
  Widget _buildInfoCard(String title, String content, BuildContext context,
      {String? image}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              fontSize: 13,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        Container(
          height: 120,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  style: TextStyle(color: Colors.black54),
                ),
                if (image != null) ...[
                  SizedBox(height: 10),
                  Image.asset(image, height: 30, width: 50),
                ],
                SizedBox(height: 10),
                Text(
                  'Edit',
                  style: TextStyle(
                    color: const Color.fromARGB(255, 8, 41, 91),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/empty_cart.png", height: 200, width: 200),
          SizedBox(height: 10),
          Text("Cart is empty",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  /// ✅ **عرض ملخص المنتجات في السلة**
  Widget _buildCartSummary(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          BlocSelector<CartBloc, CartState, int>(
            selector: (state) =>
                state is CartLoaded ? state.cartItems.length : 0,
            builder: (context, count) {
              return Text(
                'Your shopping cart ($count)',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black),
              );
            },
          ),
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoading) {
                  return Center(
                      child: CircularProgressIndicator(color: mainColor));
                } else if (state is CartLoaded) {
                  return state.cartItems.isEmpty
                      ? _buildEmptyCart()
                      : _buildCartList(state);
                } else {
                  return Center(child: Text("Failed to load cart items"));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  /// ✅ **عرض المنتجات في السلة**
  Widget _buildCartList(CartLoaded state) {
    return ListView.builder(
      itemCount: state.cartItems.length,
      itemBuilder: (context, index) {
        final cartItem = state.cartItems[index];
        return ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Image.asset(
            _getProductImagePath(cartItem.title),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          title: Text(
            cartItem.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black),
          ),
          subtitle: Text(
            '₤ ${cartItem.price.toStringAsFixed(2)}',
            style: TextStyle(color: Colors.black54),
          ),
          trailing: Text(
            'x${cartItem.quantity}',
            style: TextStyle(color: Colors.black54),
          ),
        );
      },
    );
  }

  /// ✅ **حساب وإظهار السعر الإجمالي**
  Widget _buildTotalPrice(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('₤ ${state.totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            ],
          );
        }
        return SizedBox.shrink();
      },
    );
  }

  String _getProductImagePath(String title) {
    return 'assets/images/${title.toLowerCase().replaceAll(' ', '_')}.png';
  }
}
