import 'package:chairy_e_commerce_app/features/product/presentation/pages/checkout_pages/Review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../constants.dart';
import '../blocs/check_out_bloc/checkout_bloc.dart';
import '../blocs/check_out_bloc/checkout_event.dart';
import '../blocs/check_out_bloc/checkout_state.dart';
import '../widgets/custom_app_bar.dart';
import 'checkout_pages/Data.dart';
import 'checkout_pages/Finish.dart';
import 'checkout_pages/Register.dart';
import 'checkout_pages/Payment.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        Widget currentStepWidget;

        switch (state.currentStep) {
          case CheckoutStep.register:
            currentStepWidget = Register();
            break;
          case CheckoutStep.data:
            currentStepWidget = Data();
            break;
          case CheckoutStep.payment:
            currentStepWidget = Payment();
            break;
          case CheckoutStep.review:
            currentStepWidget = Review();
            break;
          case CheckoutStep.finish:
            currentStepWidget = Finish();
        }

        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 20.0, left: 20, right: 20, top: 40),
                child: CustomAppBar(color: Theme.of(context).primaryColor),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (state.currentStep != CheckoutStep.register) {
                            context.read<CheckoutBloc>().add(
                                ChangeStepEvent(state.currentStep.index - 1));
                          } else {
                            Navigator.pop(context);
                          }
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: mainColor,
                        )),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: CheckoutStep.values
                          .where((step) => step != CheckoutStep.finish)
                          .map((step) {
                        return _buildStepIndicator(
                          context,
                          title: step.name.toUpperCase(),
                          isDone: step.index < state.currentStep.index,
                          isActive: step == state.currentStep,
                        );
                      }).toList(),
                    ),
                    Divider(
                      color: Colors.grey.shade300,
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Expanded(child: currentStepWidget),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStepIndicator(
    BuildContext context, {
    required String title,
    required bool isActive,
    required bool isDone,
  }) {
    return Row(
      children: [
        Container(
          height: 17,
          padding:
              const EdgeInsets.only(bottom: 1.0, top: 1.0, left: 1, right: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: isDone
                ? Color.fromRGBO(218, 255, 219, 1) // ✅ أخضر للمراحل المكتملة
                : (isActive
                    ? Color.fromRGBO(
                        255, 223, 186, 1) // 🔶 أصفر للمرحلة الحالية
                    : Colors.grey.shade200), // ⚪ رمادي للمراحل القادمة
          ),
          child: Row(
            children: [
              SizedBox(
                height: 20,
                width: 20,
                child: CircleAvatar(
                  backgroundColor: isDone
                      ? const Color.fromRGBO(30, 200, 21, 1) // ✅ أخضر مكتمل
                      : (isActive
                          ? const Color.fromRGBO(
                              255, 140, 0, 1) // 🟠 برتقالي للمرحلة الحالية
                          : Colors.grey), // ⚪ رمادي للمراحل القادمة
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12,
                  ),
                ),
              ),
              SizedBox(width: 5),
              Text(
                title,
                style: TextStyle(
                  color: isDone
                      ? const Color.fromARGB(255, 4, 221, 65) // ✅ أخضر مكتمل
                      : (isActive
                          ? const Color.fromARGB(
                              255, 255, 140, 0) // 🟠 برتقالي للمرحلة الحالية
                          : Colors.grey), // ⚪ رمادي للمراحل القادمة
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
        if (title != 'REVIEW')
          Container(
            // خط رمادي للمراحل القادمة
            height: 1,
            width: MediaQuery.of(context).size.width * .06,
            decoration: BoxDecoration(
              color: isDone
                  ? Color.fromARGB(255, 4, 221, 65)
                  : Colors.grey, // ✅ أخضر للمراحل السابقة، ⚪ رمادي للقادمة
            ),
          )
      ],
    );
  }
}
