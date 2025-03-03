import 'package:equatable/equatable.dart';

abstract class CheckoutEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// تغيير الصفحة
class ChangeStepEvent extends CheckoutEvent {
  final int stepIndex;
  ChangeStepEvent(this.stepIndex);

  @override
  List<Object?> get props => [stepIndex];
}

// حفظ بيانات تسجيل الحساب
class SaveAuthSignUpEvent extends CheckoutEvent {
  final int stepIndex;
  final String email;
  final String password;
  final String firstName;
  final String lastName;

  SaveAuthSignUpEvent(
      this.stepIndex, this.email, this.password, this.firstName, this.lastName);

  @override
  List<Object?> get props => [stepIndex, email, password, firstName, lastName];
}

// تسجيل الدخول
class SaveAuthSigninEvent extends CheckoutEvent {
  final int stepIndex;
  final String email;
  final String password;

  SaveAuthSigninEvent(this.stepIndex, this.email, this.password);

  @override
  List<Object?> get props => [stepIndex, email, password];
}

// تحديث وسيلة الدفع
class UpdatePaymentMethodEvent extends CheckoutEvent {
  final String paymentMethod;
  UpdatePaymentMethodEvent(this.paymentMethod);

  @override
  List<Object?> get props => [paymentMethod]; // ✅ إضافة `props`
}

// حفظ العنوان
class SaveAddressEvent extends CheckoutEvent {
  final String street1;
  final String street2;
  final String city;
  final String state;
  final String country;
  final int stepIndex; // ✅ إضافة `stepIndex` لتحديد المرحلة الحالية

  SaveAddressEvent({
    required this.street1,
    required this.street2,
    required this.city,
    required this.state,
    required this.country,
    required this.stepIndex, // ✅ مطلوب لتحديث الحالة بشكل صحيح
  });

  @override
  List<Object?> get props => [street1, street2, city, state, country, stepIndex];
}
