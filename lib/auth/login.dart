import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner_up/auth/forgot_password.dart';
import 'package:partner_up/constants/colors.dart';
import 'package:partner_up/screens/interest.dart';
import 'package:partner_up/screens/speaker/home_become.dart';
import 'package:partner_up/screens/speaker/tabs_screen_become.dart';
import 'package:partner_up/screens/speaker/tabs_scren_find.dart';
import 'package:partner_up/screens/sponsor/becomeSponsor/tabscreen.dart';
import 'package:partner_up/screens/sponsor/findSponsor/tabscreen.dart';
import 'package:partner_up/services/firebase_services.dart';
import 'package:partner_up/utils/size_configs.dart';

class Login extends StatefulWidget {
  final VoidCallback showRegisterPage;
  static const routeName = '/login';
  const Login({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String userType = '';
  void initState() {
    super.initState();
  }

  Future<dynamic> getDetails() async {
    await FirebaseServices.getSelfInfo();
    userType = FirebaseServices.currentUser.userType;
  }

  Future signIn(TextEditingController emailController,
      TextEditingController passwordController) async {
    //loading circle

    try {
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      //Succesful login
      await getDetails();
      print(getDetails().toString());
      if (userType == 'speakerOrg') {
        return Navigator.of(context).popAndPushNamed(TabsScreenFind.routeName);
      } else if (userType == 'speaker') {
        return Navigator.of(context).popAndPushNamed(TabsScreenBecome.routeName);
      } else if (userType == 'sponsor') {
        return Navigator.of(context).popAndPushNamed(TabsScreenSponsorFind.routeName);
      }
        else if (userType == 'sponsorOrg') {
        return Navigator.of(context).popAndPushNamed(TabsScreenSponsorOrg.routeName);
      }
       print("Error");
      // Navigator.of(context).popAndPushNamed(TabsScreenSp.routeName);
    } catch (e) {
      // Fluttertoast.showToast(msg: e.toString(), gravity: ToastGravity.TOP);
      Navigator.of(context).pop();
    }
  }

  bool passwordShow = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
                    height: getProportionateScreenHeight(30),
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

                  const SizedBox(
                    height: 8,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 19.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const ForgotPasswordPage();
                                },
                              ),
                            );
                          },
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
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
                          signIn(_emailController, _passwordController);
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
                            'Login',
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
                        'New Member?  ',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: widget.showRegisterPage,
                        child: const Text(
                          'Register',
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
