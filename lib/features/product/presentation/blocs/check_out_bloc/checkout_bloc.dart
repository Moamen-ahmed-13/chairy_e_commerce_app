import 'package:flutter_bloc/flutter_bloc.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(const CheckoutState(step: 1)) {
    on<ChangeStepEvent>((event, emit) {
      emit(state.copyWith(
        currentStep: CheckoutStep.values[event.stepIndex],
        step: event.stepIndex, // ✅ تحديث `step`
      ));
    });

    on<SaveAuthSignUpEvent>((event, emit) {
      emit(state.copyWith(
        currentStep: CheckoutStep.values[event.stepIndex],
        step: event.stepIndex, // ✅ تحديث `step`
      ));
    });

    on<SaveAuthSigninEvent>((event, emit) {
      emit(state.copyWith(
        currentStep: CheckoutStep.values[event.stepIndex],
        step: event.stepIndex, // ✅ تحديث `step`
      ));
    });

    on<UpdatePaymentMethodEvent>((event, emit) {
      emit(state.copyWith(paymentMethod: event.paymentMethod));
    });

    on<SaveAddressEvent>((event, emit) {
      emit(state.copyWith(
        street1: event.street1,
        street2: event.street2,
        city: event.city,
        state: event.state,
        country: event.country,
        currentStep: CheckoutStep.payment,
        step: CheckoutStep.payment.index, // ✅ تحديث `step`
      ));
    });
  }
}
