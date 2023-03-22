import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner_up/auth/verify.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/utils/size_configs.dart';

class SignInPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const SignInPage({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool passwordShow = true;
  bool confirm = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassword.dispose();
    super.dispose();
  }

  Future signUp(TextEditingController emailController,
      TextEditingController passwordController) async {
    try {
      if (passwordConfirmed()) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        )
            .then((_) {
          Navigator.of(context).pushReplacementNamed(Verification.routeName);
        });
      }
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
    }
  }

  bool passwordConfirmed() {
    if (_passwordController.text.trim() == _confirmPassword.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Image(
            image: AssetImage('assets/images/BG.png'),
          ),
          Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: getProportionateScreenHeight(210),
                  ),
                  const Text(
                    'Welcome to PartnerUp',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 29,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: getProportionateScreenHeight(40),
                  ),

                  //email field
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: TextFormField(
                      key: const ValueKey('email'),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Please enter your email';
                        } else {
                          return null;
                        }
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: PUColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: PUColors.primaryColor,
                          ),
                        ),
                        hintText: 'Enter Email',
                        focusColor: PUColors.primaryColor,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),

                  //password field
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: getProportionateScreenWidth(20),
                    ),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: passwordShow,
                      validator: (password) {
                        if (password == " ") {
                          return 'Please enter a valid password';
                        } else if (password!.length < 8) {
                          return "Password is too short";
                        }
                        return " ";
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: PUColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: PUColors.primaryColor,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: passwordShow == false
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black,
                                ),
                          onPressed: () {
                            setState(() {
                              passwordShow = !passwordShow; //show password
                            });
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        hintText: 'Password',
                      ),
                    ),
                  ),

                  //confirm password field
                  SizedBox(
                    height: getProportionateScreenHeight(20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextFormField(
                      cursorColor: Colors.black,
                      controller: _confirmPassword,
                      obscureText: confirm,
                      validator: (password) {
                        if (password == " ") {
                          return 'Please enter a valid password';
                        } else if (password!.length < 8) {
                          return "Password is too short";
                        }
                        return " ";
                      },
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: PUColors.primaryColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: PUColors.primaryColor,
                          ),
                        ),
                        suffixIcon: IconButton(
                          icon: confirm == false
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black,
                                ),
                          onPressed: () {
                            setState(() {
                              confirm = !confirm; //show password
                            });
                            FocusScope.of(context).unfocus();
                          },
                        ),
                        hintText: 'Confirm Password',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();
                        } else {
                          signUp(_emailController, _passwordController);
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already a Member?  ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: widget.showLoginPage,
                        child: const Text(
                          'Login Now',
                          style: TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
