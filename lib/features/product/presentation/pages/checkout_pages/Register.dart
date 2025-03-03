import 'package:chairy_e_commerce_app/constants.dart';
import 'package:chairy_e_commerce_app/features/product/data/datasource/auth_remote_data_source.dart';
import 'package:chairy_e_commerce_app/features/product/domain/repositories/auth_repository.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/blocs/auth_bloc/auth_event.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/widgets/custom_text_form_field.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/widgets/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../blocs/auth_bloc/auth_state.dart';
import '../../blocs/check_out_bloc/checkout_bloc.dart';
import '../../blocs/check_out_bloc/checkout_event.dart';
import '../../widgets/custom_button.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // المستخدم ألغى العملية

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      context.read<CheckoutBloc>().add(ChangeStepEvent(1));
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Logged in successfully with Google!")));
    } catch (e) {
      print("Google Sign-In Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to sign in with Google.")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      textAlign: TextAlign.center,
                      'Welcome to Our store',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Bringing Your Style Home',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 25),
                  ],
                ),
              ),
              _tabSwitcher(context, state),
              state is SignInState
                  ? _signinContainer(context)
                  : _signUpContainer(context),
            ],
          ),
        );
      },
    );
  }

  Widget _signinContainer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'I am already a customer'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                _textFieldWidget(
                    icon: Icons.email,
                    validatorText: 'Email',
                    controller: emailController,
                    hint: 'Email',
                    isVisible: false),
                _textFieldWidget(
                    icon: Icons.lock,
                    validatorText: 'Password',
                    controller: passwordController,
                    hint: 'Password',
                    isVisible: true),
                SizedBox(height: 30),
                CustomButton(
                  text: "Sign In",
                  onPressed: () async {
                    try {
                      if (_formKey.currentState!.validate()) {
                        // context.read<AuthBloc>().add(SignInState(
                        //       email: emailController.text.trim(),
                        //       password: passwordController.text.trim(),
                        //     ));
                        context.read<CheckoutBloc>().add(ChangeStepEvent(1));
                      }
                    } catch (e) {
                      print("Login Error: $e");
                    }
                  },
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(height: 1, width: 100, color: Colors.black),
                    Text(
                      'Or',
                      style: TextStyle(fontSize: 12),
                    ),
                    Container(height: 1, width: 100, color: Colors.black),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  'Sign In with Google',
                  style: TextStyle(color: Colors.grey, fontSize: 10),
                ),
                SizedBox(height: 5),
                GestureDetector(
                  onTap: _signInWithGoogle,
                  child: Image.asset('assets/images/google.png'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUpContainer(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.66,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'I am new to this store'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                _textFieldWidget(
                  icon: Icons.person,
                  validatorText: 'First Name',
                  controller: firstNameController,
                  isVisible: false,
                  hint: 'First Name',
                ),
                _textFieldWidget(
                  icon: Icons.person,
                  validatorText: 'Last Name',
                  controller: lastNameController,
                  isVisible: false,
                  hint: 'Last Name',
                ),
                _textFieldWidget(
                    icon: Icons.email,
                    validatorText: 'Email',
                    controller: emailController,
                    hint: 'Email',
                    isVisible: false),
                _textFieldWidget(
                    icon: Icons.lock,
                    validatorText: 'Password',
                    controller: passwordController,
                    hint: 'Password',
                    isVisible: true),
                SizedBox(height: 60),
                CustomButton(
                  text: 'Sign Up',
                  onPressed: () async {
                    try {
                      if (_formKey.currentState!.validate()) {
                        // context.read<AuthBloc>().add((
                        //       email: emailController.text.trim(),
                        //       password: passwordController.text.trim(),
                        //       name:
                        //           "${firstNameController.text.trim()} ${lastNameController.text.trim()}",
                        //     ));
                        context.read<CheckoutBloc>().add(ChangeStepEvent(1));
                      }
                    } catch (e) {
                      print("Login Error: $e");

                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Sign up failed: $e")));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _textFieldWidget({
    required IconData icon,
    required String validatorText,
    required TextEditingController controller,
    required String hint,
    bool isVisible = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Icon(icon, color: Colors.black),
        SizedBox(width: 10),
        Expanded(
          child: CustomTextFormField(
            fieldName: '',
            hintText: hint,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $validatorText';
              }
              return null;
            },
            onSaved: (value) {
              controller.text = value!;
            },
            secured: isVisible,
            controller: controller,
          ),
        ),
      ],
    );
  }

  Widget _tabSwitcher(BuildContext context, AuthState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _tabButton(context, "Sign In", state is SignInState, ShowSignInEvent()),
        _tabButton(context, "Sign Up", state is SignUpState, ShowSignUpEvent()),
      ],
    );
  }

  Widget _tabButton(
      BuildContext context, String text, bool isActive, AuthEvent event) {
    return GestureDetector(
      onTap: () {
        context.read<AuthBloc>().add(event);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * .5,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isActive ? Colors.orange.shade100 : Colors.grey.shade100,
          border: Border(
              bottom: BorderSide(
                  color: isActive ? mainColor : Colors.grey.shade100,
                  width: 2)),
        ),
        child: Center(
          child: Text(text,
              style: TextStyle(color: isActive ? mainColor : Colors.grey)),
        ),
      ),
    );
  }
}
