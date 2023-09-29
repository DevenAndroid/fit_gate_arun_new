// // ignore_for_file: prefer_const_constructors
//
// import 'package:flutter/material.dart';
// import '../screens/bottom_bar_screens/account_screen.dart';
// import '../screens/bottom_bar_screens/home_page.dart';
// import '../screens/check_in_page.dart';
// import '../screens/map_page.dart';
// import '../utils/my_color.dart';
// import '../utils/my_images.dart';
//
// class CustomBottomBar extends StatefulWidget {
//   final Function(int)? onClick;
//
//   const CustomBottomBar({Key? key, this.onClick}) : super(key: key);
//
//   @override
//   State<CustomBottomBar> createState() => _CustomBottomBarState();
// }
//
// class _CustomBottomBarState extends State<CustomBottomBar> {
//   int currentIndex = 0;
//   int activateIndex = 0;
//
//   getCurrentPage() {
//     List<Widget> myPages = [
//       HomePage(),
//       ExplorePage(),
//       CheckInPage(),
//       AccountScreen(),
//     ];
//
//     return myPages[currentIndex];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Container(
//         height: MediaQuery.of(context).size.height * 0.08,
//         color: MyColors.white,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Expanded(
//               child: GestureDetector(
//                 onTap: () {
//                   currentIndex = 0;
//                   setState(() {});
//                   // widget.onClick!(currentIndex);
//                 },
//                 child: customBottomText(
//                     Icons.home_outlined, currentIndex, "Home", 0),
//               ),
//             ),
//             Expanded(
//               child: GestureDetector(
//                 onTap: () {
//                   currentIndex = 1;
//                   setState(() {});
//                   // widget.onClick!(currentIndex);
//                 },
//                 child: customBottomText(
//                     Icons.explore_outlined, currentIndex, "Explore", 1),
//               ),
//             ),
//             Expanded(
//               child: GestureDetector(
//                 onTap: () {
//                   currentIndex = 2;
//                   setState(() {});
//                   // widget.onClick!(currentIndex);
//                 },
//                 child: customBottomText(Icons.document_scanner_outlined,
//                     currentIndex, "Check In", 2),
//               ),
//             ),
//             Expanded(
//               child: GestureDetector(
//                 onTap: () {
//                   currentIndex = 3;
//                   setState(() {});
//                   // widget.onClick!(currentIndex);
//                 },
//                 child: customBottomText(
//                     Icons.person_outline_sharp, currentIndex, "Account", 3),
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: getCurrentPage(),
//     );
//   }
//
//   Padding customBottomText(icon, index, title, selectedIndex) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 8.0),
//       child: Column(
//         children: [
//           Icon(
//             icon,
//             // MyImages.add,
//             // height: 22,
//             color: index == selectedIndex
//                 ? MyColors.orange
//                 : MyColors.grey.withOpacity(.70),
//           ),
//           Text(
//             "$title",
//             style: TextStyle(
//                 color: index == selectedIndex
//                     ? MyColors.orange
//                     : MyColors.grey.withOpacity(.70)),
//           )
//         ],
//       ),
//     );
//   }
// }
