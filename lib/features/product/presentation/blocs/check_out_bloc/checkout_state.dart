import 'package:equatable/equatable.dart';

enum CheckoutStep { register, data, payment, review, finish }

class CheckoutState extends Equatable {
  final CheckoutStep currentStep;
  final String street1;
  final String street2;
  final String city;
  final String state;
  final String country;
  final int step;
  final String paymentMethod;

  const CheckoutState({
    this.currentStep = CheckoutStep.register,
    this.street1 = '',
    this.street2 = '',
    this.city = '',
    this.state = '',
    this.country = '',
    this.step = 0,  // إضافة قيمة افتراضية
    this.paymentMethod = '',
  });

  CheckoutState copyWith({
    CheckoutStep? currentStep,
    String? street1,
    String? street2,
    String? city,
    String? state,
    String? country,
    int? step,
    String? paymentMethod,
  }) {
    return CheckoutState(
      currentStep: currentStep ?? this.currentStep,
      street1: street1 ?? this.street1,
      street2: street2 ?? this.street2,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      step: step ?? this.step,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  @override
  List<Object?> get props => [currentStep, street1, street2, city, state, country, step, paymentMethod];
}
