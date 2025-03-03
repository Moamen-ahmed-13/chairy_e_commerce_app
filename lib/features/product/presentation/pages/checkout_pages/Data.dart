import 'package:chairy_e_commerce_app/features/product/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/check_out_bloc/checkout_bloc.dart';
import '../../blocs/check_out_bloc/checkout_event.dart';
import '../../blocs/check_out_bloc/checkout_state.dart';
import '../../widgets/custom_text_form_field.dart';

class Data extends StatefulWidget {
  Data({super.key});

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController street1Controller = TextEditingController();

  final TextEditingController street2Controller = TextEditingController();

  final TextEditingController cityController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController countryController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    street1Controller.dispose();
    street2Controller.dispose();
    cityController.dispose();
    stateController.dispose();
    countryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CheckoutBloc, CheckoutState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        'Your Customer Data For The Order',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Bringing Your Style Home',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Text(
                    'delivery address'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextFormField(
                    fieldName: '',
                    hintText: 'Street ',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter street ' : null,
                    onSaved: (String? value) {
                      street1Controller.text = value!;
                    },
                    secured: false,
                    controller: street1Controller,
                  ),
                  CustomTextFormField(
                    controller: cityController,
                    fieldName: '',
                    hintText: 'City',
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter city' : null,
                    onSaved: (String? value) {
                      cityController.text = value!;
                    },
                    secured: false,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          controller: stateController,
                          fieldName: '',
                          hintText: 'State',
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter state' : null,
                          onSaved: (String? value) {
                            stateController.text = value!;
                          },
                          secured: false,
                        ),
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: CustomTextFormField(
                          controller: countryController,
                          fieldName: '',
                          hintText: 'Country',
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter country' : null,
                          onSaved: (String? value) {
                            countryController.text = value!;
                          },
                          secured: false,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 120),
                  CustomButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        BlocProvider.of<CheckoutBloc>(context).add(
                          SaveAddressEvent(stepIndex: 1,
                            street1: street1Controller.text,
                            street2: street2Controller.text,
                            city: cityController.text,
                            state: stateController.text,
                            country: countryController.text,
                          ),
                        );
                      }
                    },
                    text: 'Next',
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
