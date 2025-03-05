// import 'package:chairy_e_commerce_app/constants.dart';
// import 'package:chairy_e_commerce_app/features/product/data/helper/auth_service.dart';
// import 'package:chairy_e_commerce_app/features/product/presentation/widgets/custom_text_form_field.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import '../../blocs/check_out_bloc/checkout_bloc.dart';
// import '../../blocs/check_out_bloc/checkout_event.dart';
// import '../../widgets/custom_button.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class Register extends StatefulWidget {
//   Register({super.key});

//   @override
//   State<Register> createState() => _RegisterState();
// }

// class _RegisterState extends State<Register> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = GoogleSignIn();

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController firstNameController = TextEditingController();
//   final TextEditingController lastNameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final AuthService _authService = AuthService();

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   bool _isSignIn = true; // Initial state: Sign In is active
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     firstNameController.dispose();
//     lastNameController.dispose();
//     super.dispose();
//   }

//   Future<void> _signInWithGoogle() async {
//     setState(() {
//       _isLoading = true;
//     });
//     try {
//       final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) {
//         setState(() {
//           _isLoading = false;
//         });
//         return; // User canceled the process
//       }

//       final GoogleSignInAuthentication googleAuth =
//           await googleUser.authentication;
//       final AuthCredential credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth.accessToken,
//         idToken: googleAuth.idToken,
//       );

//       await _auth.signInWithCredential(credential);
//       context.read<CheckoutBloc>().add(ChangeStepEvent(1));
//       Fluttertoast.showToast(
//         msg: "Logged in successfully with Google!",
//         toastLength: Toast.LENGTH_SHORT, // Duration of the toast
//         gravity: ToastGravity.BOTTOM, // Position of the toast
//         backgroundColor: Colors.red, // Background color
//         textColor: Colors.white, // Text color
//       );
//     } on FirebaseAuthException catch (e) {
//       print("Google Sign-In Error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//           content: Text("Failed to sign in with Google: ${e.message}")));
//     } catch (e) {
//       print("Google Sign-In Error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("An unexpected error occurred.")));
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   textAlign: TextAlign.center,
//                   'Welcome to Our store',
//                   style: TextStyle(
//                       fontSize: 30,
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   'Bringing Your Style Home',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 16,
//                   ),
//                 ),
//                 SizedBox(height: 25),
//               ],
//             ),
//           ),
//           _tabSwitcher(context),
//           _isSignIn ? _signinContainer(context) : _signUpContainer(context),
//         ],
//       ),
//     );
//   }

//   Widget _signinContainer(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.grey.shade100,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               children: [
//                 Text(
//                   textAlign: TextAlign.center,
//                   'I am already a customer'.toUpperCase(),
//                   style: TextStyle(
//                       fontSize: 14,
//                       color: Theme.of(context).primaryColor,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 20),
//                 _textFieldWidget(
//                     icon: Icons.email,
//                     validatorText: 'Email',
//                     controller: emailController,
//                     hint: 'Email',
//                     isVisible: false),
//                 _textFieldWidget(
//                     icon: Icons.lock,
//                     validatorText: 'Password',
//                     controller: passwordController,
//                     hint: 'Password',
//                     isVisible: true),
//                 SizedBox(height: 30),
//                 _isLoading
//                     ? CircularProgressIndicator(
//                         color: mainColor,
//                       )
//                     : CustomButton(
//                         text: "Sign In",
//                         onPressed: () async {
//                           if (_formKey.currentState!.validate()) {
//                             setState(() {
//                               _isLoading = true;
//                             });
//                             try {
//                               String email = emailController.text.trim();
//                               String password = passwordController.text.trim();

//                               // Debug logs
//                               print("Email: $email");
//                               print("Password: $password");

//                               // Check if email and password are empty
//                               if (email.isEmpty || password.isEmpty) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content:
//                                           Text("Please fill in all fields.")),
//                                 );
//                                 return;
//                               }

//                               // Validate email format
//                               if (!RegExp(
//                                       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                   .hasMatch(email)) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content: Text(
//                                           "Please enter a valid email address.")),
//                                 );
//                                 return;
//                               }

//                               // Validate password length
//                               if (password.length < 6) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content: Text(
//                                           "Password must be at least 6 characters long.")),
//                                 );
//                                 return;
//                               }

//                               User? user =
//                                   await _authService.login(email, password);
//                               if (user != null) {
//                                 print("Login successful as ${user.email}");
//                                 // Navigate or do something on successful login
//                                 context
//                                     .read<CheckoutBloc>()
//                                     .add(ChangeStepEvent(1));
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content: Text(
//                                           "Login failed. Invalid credentials.")),
//                                 );
//                               }
//                             } on FirebaseAuthException catch (e) {
//                               print(
//                                   "FirebaseAuthException: ${e.code} - ${e.message}");
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content:
//                                         Text("Login failed: ${e.message}")),
//                               );
//                             } catch (e) {
//                               print("Unexpected error: $e");
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content:
//                                         Text("An unexpected error occurred.")),
//                               );
//                             } finally {
//                               setState(() {
//                                 _isLoading = false;
//                               });
//                             }
//                           }
//                         },
//                       ),
//                 SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(height: 1, width: 100, color: Colors.black),
//                     Text(
//                       'Or',
//                       style: TextStyle(fontSize: 12),
//                     ),
//                     Container(height: 1, width: 100, color: Colors.black),
//                   ],
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   'Sign In with Google',
//                   style: TextStyle(color: Colors.grey, fontSize: 10),
//                 ),
//                 SizedBox(height: 5),
//                 GestureDetector(
//                     onTap: _signInWithGoogle,
//                     child: _isLoading
//                         ? CircularProgressIndicator(
//                             color: mainColor,
//                           )
//                         : Image.asset('assets/images/google.png')),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _signUpContainer(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
//       child: Container(
//         height: MediaQuery.of(context).size.height * 0.66,
//         decoration: BoxDecoration(
//           color: Colors.grey.shade100,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   textAlign: TextAlign.center,
//                   'I am new to this store'.toUpperCase(),
//                   style: TextStyle(
//                       fontSize: 14,
//                       color: Theme.of(context).primaryColor,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 _textFieldWidget(
//                   icon: Icons.person,
//                   validatorText: 'First Name',
//                   controller: firstNameController,
//                   isVisible: false,
//                   hint: 'First Name',
//                 ),
//                 _textFieldWidget(
//                   icon: Icons.person,
//                   validatorText: 'Last Name',
//                   controller: lastNameController,
//                   isVisible: false,
//                   hint: 'Last Name',
//                 ),
//                 _textFieldWidget(
//                     icon: Icons.email,
//                     validatorText: 'Email',
//                     controller: emailController,
//                     hint: 'Email',
//                     isVisible: false),
//                 _textFieldWidget(
//                     icon: Icons.lock,
//                     validatorText: 'Password',
//                     controller: passwordController,
//                     hint: 'Password',
//                     isVisible: true),
//                 SizedBox(height: 60),
//                 _isLoading
//                     ? CircularProgressIndicator(
//                         color: mainColor,
//                       ) // Show loading indicator
//                     : CustomButton(
//                         text: 'Sign Up',
//                         onPressed: () async {
//                           if (_formKey.currentState!.validate()) {
//                             setState(() {
//                               _isLoading = true; // Start loading
//                             });
//                             try {
//                               String email = emailController.text.trim();
//                               String password = passwordController.text.trim();

//                               // Debug logs
//                               print("Email: $email");
//                               print("Password: $password");

//                               // Check if email and password are empty
//                               if (email.isEmpty || password.isEmpty) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content:
//                                           Text("Please fill in all fields.")),
//                                 );
//                                 return;
//                               }

//                               // Validate email format
//                               if (!RegExp(
//                                       r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
//                                   .hasMatch(email)) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content: Text(
//                                           "Please enter a valid email address.")),
//                                 );
//                                 return;
//                               }

//                               // Validate password length
//                               if (password.length < 6) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(
//                                       content: Text(
//                                           "Password must be at least 6 characters long.")),
//                                 );
//                                 return;
//                               }

//                               User? user =
//                                   await _authService.register(email, password);
//                               if (user != null) {
//                                 print("Sign up successful as ${user.email}");
//                                 // Navigate or do something on successful signup
//                                 context
//                                     .read<CheckoutBloc>()
//                                     .add(ChangeStepEvent(1));
//                               } else {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text("Sign up failed.")),
//                                 );
//                               }
//                             } on FirebaseAuthException catch (e) {
//                               print(
//                                   "FirebaseAuthException: ${e.code} - ${e.message}");
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content:
//                                         Text("Sign up failed: ${e.message}")),
//                               );
//                             } catch (e) {
//                               print("Unexpected error: $e");
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content:
//                                         Text("An unexpected error occurred.")),
//                               );
//                             } finally {
//                               setState(() {
//                                 _isLoading = false; // Stop loading
//                               });
//                             }
//                           }
//                         },
//                       ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _textFieldWidget({
//     required IconData icon,
//     required String validatorText,
//     required TextEditingController controller,
//     required String hint,
//     bool isVisible = false,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Icon(icon, color: Colors.black),
//         SizedBox(width: 10),
//         Expanded(
//           child: CustomTextFormField(
//             fieldName: '',
//             hintText: hint,
//             validator: (value) {
//               if (value == null || value.isEmpty) {
//                 return 'Please enter $validatorText';
//               }
//               return null;
//             },
//             onSaved: (value) {
//               controller.text = value!;
//             },
//             secured: isVisible,
//             controller: controller,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _tabSwitcher(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         _tabButton(context, "Sign In", _isSignIn, () {
//           setState(() {
//             _isSignIn = true;
//           });
//         }),
//         _tabButton(context, "Sign Up", !_isSignIn, () {
//           setState(() {
//             _isSignIn = false;
//           });
//         }),
//       ],
//     );
//   }

//   Widget _tabButton(BuildContext context, String text, bool isActive,
//       VoidCallback onPressed) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Container(
//         width: MediaQuery.of(context).size.width * .5,
//         padding: EdgeInsets.all(10),
//         decoration: BoxDecoration(
//           color: isActive ? Colors.orange.shade100 : Colors.grey.shade100,
//           border: Border(
//               bottom: BorderSide(
//                   color: isActive ? mainColor : Colors.grey.shade100,
//                   width: 2)),
//         ),
//         child: Center(
//           child: Text(text,
//               style: TextStyle(color: isActive ? mainColor : Colors.grey)),
//         ),
//       ),
//     );
//   }
// }
import 'package:chairy_e_commerce_app/constants.dart';
import 'package:chairy_e_commerce_app/features/product/data/helper/auth_service.dart';
import 'package:chairy_e_commerce_app/features/product/presentation/widgets/custom_text_form_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../blocs/check_out_bloc/checkout_bloc.dart';
import '../../blocs/check_out_bloc/checkout_event.dart';
import '../../widgets/custom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  final AuthService _authService = AuthService();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isSignIn = true; // Initial state: Sign In is active
  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        setState(() {
          _isLoading = false;
        });
        return; // User canceled the process
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      context.read<CheckoutBloc>().add(ChangeStepEvent(1));
      Fluttertoast.showToast(
        msg: "Logged in successfully with Google!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey.shade200,
        textColor: Colors.green,
      );
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to sign in with Google: ${e.message}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey.shade200,
        textColor: Colors.red,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An unexpected error occurred.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey.shade200,
        textColor: Colors.red,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
          _tabSwitcher(context),
          _isSignIn ? _signinContainer(context) : _signUpContainer(context),
        ],
      ),
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
                _isLoading
                    ? CircularProgressIndicator(
                        color: mainColor,
                      )
                    : CustomButton(
                        text: "Sign In",
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            try {
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();

                              // Debug logs
                              print("Email: $email");
                              print("Password: $password");

                              // Check if email and password are empty
                              if (email.isEmpty || password.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: "Please fill in all fields.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey.shade200,
                                  textColor: Colors.red,
                                );
                                return;
                              }

                              // Validate email format
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email)) {
                                Fluttertoast.showToast(
                                  msg: "Please enter a valid email address.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey.shade200,
                                  textColor: Colors.red,
                                );
                                return;
                              }

                              // Validate password length
                              if (password.length < 6) {
                                Fluttertoast.showToast(
                                  msg:
                                      "Password must be at least 6 characters long.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey.shade200,
                                  textColor: Colors.red,
                                );
                                return;
                              }

                              User? user =
                                  await _authService.login(email, password);
                              if (user != null) {
                                Fluttertoast.showToast(
                                  msg: "Login successful as ${user.email}",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey.shade200,
                                  textColor: Colors.green,
                                );
                                print("Login successful as ${user.email}");
                                // Navigate or do something on successful login
                                context
                                    .read<CheckoutBloc>()
                                    .add(ChangeStepEvent(1));
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Login failed. Invalid credentials.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey.shade200,
                                  textColor: Colors.red,
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              Fluttertoast.showToast(
                                msg: "Login failed: ${e.message}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.grey.shade200,
                                textColor: Colors.red,
                              );
                            } catch (e) {
                              Fluttertoast.showToast(
                                msg: "An unexpected error occurred.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.grey.shade200,
                                textColor: Colors.red,
                              );
                            } finally {
                              setState(() {
                                _isLoading = false;
                              });
                            }
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
                    child: _isLoading
                        ? CircularProgressIndicator(
                            color: mainColor,
                          )
                        : Image.asset('assets/images/google.png')),
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
                _isLoading
                    ? CircularProgressIndicator(
                        color: mainColor,
                      ) // Show loading indicator
                    : CustomButton(
                        text: 'Sign Up',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true; // Start loading
                            });
                            try {
                              String email = emailController.text.trim();
                              String password = passwordController.text.trim();

                              // Debug logs
                              print("Email: $email");
                              print("Password: $password");

                              // Check if email and password are empty
                              if (email.isEmpty || password.isEmpty) {
                                Fluttertoast.showToast(
                                  msg: "Please fill in all fields.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey.shade200,
                                  textColor: Colors.red,
                                );
                                return;
                              }

                              // Validate email format
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(email)) {
                                Fluttertoast.showToast(
                                  msg: "Please enter a valid email address.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey.shade200,
                                  textColor: Colors.red,
                                );
                                return;
                              }

                              // Validate password length
                              if (password.length < 6) {
                                Fluttertoast.showToast(
                                  msg:
                                      "Password must be at least 6 characters long.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey.shade200,
                                  textColor: Colors.red,
                                );
                                return;
                              }

                              User? user =
                                  await _authService.register(email, password);
                              if (user != null) {
                                Fluttertoast.showToast(
                                  msg: "Login failed. Invalid credentials.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey.shade200,
                                  textColor: Colors.green,
                                );
                                print("Sign up successful as ${user.email}");
                                // Navigate or do something on successful signup
                                context
                                    .read<CheckoutBloc>()
                                    .add(ChangeStepEvent(1));
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Sign up failed.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: Colors.grey.shade200,
                                  textColor: Colors.red,
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              Fluttertoast.showToast(
                                msg: "Sign up failed: ${e.message}",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.grey.shade200,
                                textColor: Colors.red,
                              );
                            } catch (e) {
                              Fluttertoast.showToast(
                                msg: "An unexpected error occurred.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.grey.shade200,
                                textColor: Colors.red,
                              );
                            } finally {
                              setState(() {
                                _isLoading = false; // Stop loading
                              });
                            }
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

  Widget _tabSwitcher(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _tabButton(context, "Sign In", _isSignIn, () {
          setState(() {
            _isSignIn = true;
          });
        }),
        _tabButton(context, "Sign Up", !_isSignIn, () {
          setState(() {
            _isSignIn = false;
          });
        }),
      ],
    );
  }

  Widget _tabButton(BuildContext context, String text, bool isActive,
      VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
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
