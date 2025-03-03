import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/check_out_bloc/checkout_bloc.dart';
import '../../blocs/check_out_bloc/checkout_event.dart';
import '../../blocs/check_out_bloc/checkout_state.dart';
import '../../widgets/custom_button.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late String _selectedPaymentMethod; // ✅ تعريف متغير محلي لحفظ الخيار المختار

  @override
  void initState() {
    super.initState();
    // ✅ استرجاع القيمة المخزنة في Bloc عند بناء الشاشة
    _selectedPaymentMethod =
        BlocProvider.of<CheckoutBloc>(context).state.paymentMethod.isNotEmpty
            ? BlocProvider.of<CheckoutBloc>(context).state.paymentMethod
            : 'card'; // القيم الافتراضية إذا لم يكن هناك قيمة محفوظة
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // العنوان الرئيسي
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Your Customer Data For The Order',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Bringing Your Style Home',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // عنوان اختيار طريقة الدفع
              Text(
                'SELECT PAYMENT METHOD',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),

              // خيارات الدفع
              Column(
                children: [
                  RadioListTile<String>(
                    activeColor: const Color.fromRGBO(30, 200, 21, 1),
                    value: 'card',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value!;
                      });
                      BlocProvider.of<CheckoutBloc>(context)
                          .add(UpdatePaymentMethodEvent(value!));
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Card Payment'),
                        Image.asset('assets/images/visamastercard.png',
                            width: 70),
                      ],
                    ),
                  ),
                  RadioListTile<String>(
                    activeColor: const Color.fromRGBO(30, 200, 21, 1),
                    value: 'paypal',
                    groupValue: _selectedPaymentMethod,
                    onChanged: (value) {
                      setState(() {
                        _selectedPaymentMethod = value!;
                      });
                      BlocProvider.of<CheckoutBloc>(context)
                          .add(UpdatePaymentMethodEvent(value!));
                    },
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('PayPal'),
                        Image.asset('assets/images/paypal.png', width: 50),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              // زر المتابعة
              CustomButton(
                onPressed: () {
                  BlocProvider.of<CheckoutBloc>(context)
                      .add(ChangeStepEvent(3));
                },
                text: 'Next',
              ),
              SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
