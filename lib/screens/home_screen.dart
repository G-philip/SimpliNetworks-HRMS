import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Welcome to the Home Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        
      ],
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:hrms_app/layout.dart'; // Import the layout.dart file

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Layout(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             'Welcome to the Home Screen',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
          
//         ],
//       ),
//     );
//   }
// }