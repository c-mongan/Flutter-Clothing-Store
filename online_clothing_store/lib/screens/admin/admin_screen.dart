import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:health_app_fyp/screens/authentication/login_screen.dart';
import '../home/home_page.dart';
import 'admin_inventory/admin_home.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  _AdminLoginScreenState createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  //form key
  final _formKey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  _isAdmin(email, password) {
    if (email == "admin123@gmail.com" && password == "admin123") {
      return true;
    } else {
      return false;
    }
  }

  //firebase
  final _auth = FirebaseAuth.instance;

  //error message
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
//email field
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Please enter your Email");
          }
          //reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Please enter a valid Email");
          }

          return null;
        },
        onSaved: (value) {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

//passwordField
    final passwordField = TextFormField(
        autofocus: false,
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          //Fire Base needs a minimum of 6 characters in a password to register a user
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Password is required for Login");
          }
          if (!regex.hasMatch(value)) {
            return ("Password must be at least 6 characters in length");
          }
        },
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.vpn_key),
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

//Login Button
    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color.fromARGB(255, 212, 11, 62), //Color of button
      child: MaterialButton(
          padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          minWidth: MediaQuery.of(context)
              .size
              .width, //resizes button to width of fields
          //When the button is pressed , use the controllers to set the text
          onPressed: () {
            signIn(emailController.text, passwordController.text);
            //Navigator.pushReplacement(context,
            // MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          child: const Text(
            "Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    // colors: [Colors.red, Colors.white, Colors.red],
                    colors: [
                  Colors.red,
                  Colors.blue,
                  // Colors.red,
                  //Colors.blue,

                  // Colors.orange,
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Online E-Store",
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightBlue,
                        ),
                    
                      ),
                      SizedBox(
                        height: 200,
                        // child: Image.asset(
                        //   "assets/healthy1.png",
                        //   fit: BoxFit.contain,
                        // )
                      ),
                      Text(
                        "Admin Login",
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue),
                      ),
                      const SizedBox(height: 45),
                      emailField,
                      const SizedBox(height: 25),
                      passwordField,
                      const SizedBox(height: 35),
                      loginButton,
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      
                          GestureDetector(
                            onTap: () {
                              Get.to(const LoginScreen());
                            },
                            child: const Text("Customer Login",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 212, 11, 62),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )));
  }

//Login Method
//Google async function
  void signIn(String email, String password) async {
    _isAdmin(email, password);



    if (_formKey.currentState!.validate() && !_isAdmin(email, password)) {
      print("NOT ADMIN");

      Fluttertoast.showToast(msg: "Invalid Admin Details! ");
    } else if (_formKey.currentState!.validate() && _isAdmin(email, password)) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
//If Login is a success we will pass it the UserID
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful! "),
                  //Login Success message
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const AdminHomePage())),
                  //Navigates the user to Home Screen
                });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be invalid.";

            break;
          case "wrong-password":
            errorMessage = "Your password is incorrect.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An unexpected Error has occurred.";
        }
        Fluttertoast.showToast(msg: errorMessage!);

        print(error.code);
      }
    }
  }
}
