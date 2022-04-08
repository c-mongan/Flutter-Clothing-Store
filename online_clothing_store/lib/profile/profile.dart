// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// import 'package:intl/intl.dart';

// import '../model/user_model.dart';


// class ProfileView extends StatelessWidget {

//   User? user = FirebaseAuth.instance.currentUser;
// UserModel loggedInUser = UserModel();

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         width: MediaQuery
//             .of(context)
//             .size
//             .width,
//         child: Column(
//           children: <Widget>[
           
//                    displayUserInformation(context, snapshot);
               
//           ],
//         ),
//       ),
//     );
//   }

//   Widget displayUserInformation(context, snapshot) {
//     final user = snapshot.data;

//     return Column(
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text(
//             "Name: ${user.displayName ?? 'Anonymous'}", style: TextStyle(fontSize: 20),),
//         ),

//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text("Email: ${user.email ?? 'Anonymous'}", style: TextStyle(fontSize: 20),),
//         ),

//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Text("Created: ${DateFormat('MM/dd/yyyy').format(
//               user.metadata.creationTime)}", style: TextStyle(fontSize: 20),),
//         ),

//         showSignOut(context, user.isAnonymous),
//       ],
//     );
//   }

//   Widget showSignOut(context, bool isAnonymous) {
//     if (isAnonymous == true) {
//       return RaisedButton(
//         child: Text("Sign In To Save Your Data"),
//         onPressed: () {
//           Navigator.of(context).pushNamed('/convertUser');
//         },
//       );
//     } else {
//       return RaisedButton(
//         child: Text("Sign Out"),
//         onPressed: () async {
//           try {
//             await Provider.of(context).auth.signOut();
//           } catch (e) {
//             print(e);
//           }
//         },
//       );
//     }
//   }
// }