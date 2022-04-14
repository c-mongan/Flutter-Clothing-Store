// import 'package:flutter/material.dart';

// class SignUpCrypto extends StatelessWidget {
//   const SignUpCrypto({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xff1b232A),
//       body: SafeArea(
//           bottom: false,
//           child: ListView(
//             children: const [
//               SizedBox(
//                 height: 25,
//               ),
//               Heading("Sign Up"),
//               SizedBox(
//                 height: 25,
//               ),
//               EmailInput(),
//               PasswordInput(),
//               ConfirmPasswordInput(),
//               Padding(
//                   padding: EdgeInsets.only(top: 0.0, left: 15.0),
//                   child: TextButton(
//                     child: Text(
//                       "Already have a login? Click here",
//                       style: TextStyle(
//                           fontWeight: FontWeight.normal,
//                           color: Color(0xff5ED5A8)),
//                     ),
//                     onPressed: null,
//                   )),
//               SignInButton(),
//               Align(
//                 alignment: Alignment.center,
//                 child: Padding(
//                   padding: EdgeInsets.only(top: 15.0),
//                   child: Text(
//                     "Or sign up with?",
//                     style: TextStyle(
//                         fontWeight: FontWeight.normal, color: Colors.grey),
//                   ),
//                 ),
//               ),
//               SocialButtons(),
//             ],
//           )),
//     );
//   }
// }

// class Heading extends StatelessWidget {
//   final String text;
//   const Heading(this.text,{Key? key}):super(key:key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 15.0, left: 15.0),
//       child: Text(
//         text,
//         style: const TextStyle(
//             fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
//       ),
//     );
//   }
// }

// class EmailInput extends StatelessWidget {
//   const EmailInput({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Price",
//             style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.white.withOpacity(.9)),
//           ),
//           SizedBox(
//             height: 8,
//           ),
//           Container(
//             height: 50,
//             decoration: BoxDecoration(boxShadow: [
//               BoxShadow(
//                   offset: const Offset(12, 26),
//                   blurRadius: 50,
//                   spreadRadius: 0,
//                   color: Colors.grey.withOpacity(.1)),
//             ]),
//             child: TextField(
//               onChanged: (value) {
//                 //Do something wi
//               },
//               style: const TextStyle(fontSize: 14, color: Colors.white),
//               decoration: InputDecoration(
//                 // prefixIcon: Icon(Icons.Price),
//                 filled: true,
//                 fillColor: const Color(0xff161C22),
//                 hintText: 'Enter your Price',
//                 hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
//                 border: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white, width: 0.0),
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white, width: 0.0),
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class PasswordInput extends StatelessWidget {
//   const PasswordInput({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Password",
//             style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.white.withOpacity(.9)),
//           ),
//           SizedBox(
//             height: 8,
//           ),
//           Container(
//             height: 50,
//             decoration: BoxDecoration(boxShadow: [
//               BoxShadow(
//                   offset: const Offset(12, 26),
//                   blurRadius: 50,
//                   spreadRadius: 0,
//                   color: Colors.grey.withOpacity(.1)),
//             ]),
//             child: TextField(
//               obscureText: true,
//               onChanged: (value) {
//                 //Do something wi
//               },
//               style: const TextStyle(fontSize: 14, color: Colors.white),
//               decoration: InputDecoration(
//                 // prefixIcon: Icon(Icons.Price),
//                 filled: true,
//                 fillColor: const Color(0xff161C22),
//                 hintText: 'Enter your password',
//                 hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
//                 border: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white, width: 0.0),
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white, width: 0.0),
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ConfirmPasswordInput extends StatelessWidget {
//   const ConfirmPasswordInput({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "Confirm Password",
//             style: TextStyle(
//                 fontSize: 14,
//                 fontWeight: FontWeight.normal,
//                 color: Colors.white.withOpacity(.9)),
//           ),
//           SizedBox(
//             height: 8,
//           ),
//           Container(
//             height: 50,
//             decoration: BoxDecoration(boxShadow: [
//               BoxShadow(
//                   offset: const Offset(12, 26),
//                   blurRadius: 50,
//                   spreadRadius: 0,
//                   color: Colors.grey.withOpacity(.1)),
//             ]),
//             child: TextField(
//               obscureText: true,
//               onChanged: (value) {
//                 //Do something wi
//               },
//               style: const TextStyle(fontSize: 14, color: Colors.white),
//               decoration: InputDecoration(
//                 // prefixIcon: Icon(Icons.email),
//                 filled: true,
//                 fillColor: const Color(0xff161C22),
//                 hintText: 'Enter your password',
//                 hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
//                 contentPadding:
//                     const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
//                 border: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white, width: 0.0),
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//                 focusedBorder: const OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.white, width: 0.0),
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SignInButton extends StatelessWidget {
//   const SignInButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 54,
//         width: double.infinity,
//         margin: const EdgeInsets.all(15),
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(15),
//             color: const Color(0xff5ED5A8),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xff5ED5A8).withOpacity(.15),
//                 offset: const Offset(0, 10),
//                 blurRadius: 20,
//                 spreadRadius: 0,
//               )
//             ]),
//         child: TextButton(
//           child: const Text("Sign Up", style: TextStyle(color: Colors.black)),
//           onPressed: () {
//             //Navigate Home Here

//             //or move screens
//           },
//         ));
//   }
// }

// class SocialButtons extends StatelessWidget {
//   const SocialButtons({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 15.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: const [FacebookBtn(), GoogleBtn()],
//       ),
//     );
//   }
// }

// class GoogleBtn extends StatelessWidget {
//   const GoogleBtn({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 54,
//         width: MediaQuery.of(context).size.width / 2.5,
//         margin: const EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: Colors.white,
//         ),
//         child: TextButton(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.network(
//                 "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/crypto%2Fsearch%20(2).png?alt=media&token=24a918f7-3564-4290-b7e4-08ff54b3c94c",
//                 width: 20,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               const Text("Google",
//                   style: TextStyle(color: Colors.black, fontSize: 16)),
//             ],
//           ),
//           onPressed: () {
//             //Navigate Home Here

//             //or move screens
//           },
//         ));
//   }
// }

// class FacebookBtn extends StatelessWidget {
//   const FacebookBtn({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         height: 54,
//         width: MediaQuery.of(context).size.width / 2.5,
//         margin: const EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: Colors.white,
//         ),
//         child: TextButton(
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.network(
//                 "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/crypto%2Ffacebook%20(2).png?alt=media&token=9c275bf0-2bf7-498a-9405-9ae99df8d8f2",
//                 width: 20,
//               ),
//               const SizedBox(
//                 width: 10,
//               ),
//               const Text("Facebook",
//                   style: TextStyle(color: Colors.black, fontSize: 16)),
//             ],
//           ),
//           onPressed: () {
//             //Navigate Home Here

//             //or move screens
//           },
//         ));
//   }
// }

// class FooterGraphic extends StatelessWidget {
//   const FooterGraphic({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Align(
//         alignment: Alignment.center,
//         child: Image.network(
//             "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/crypto%2FVector%20111%20(1).png?alt=media&token=28b01dc2-72c7-42e3-bb11-7003eeb4fb2a",
//             width: double.infinity));
//   }
// }