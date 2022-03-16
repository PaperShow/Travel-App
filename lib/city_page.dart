// import 'package:flutter/material.dart';

// class CityPage extends StatefulWidget {
//   const CityPage({Key? key, this.list}) : super(key: key);
//   final list;

//   @override
//   State<CityPage> createState() => _CityPageState();
// }

// class _CityPageState extends State<CityPage> with TickerProviderStateMixin {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return DefaultTabController(
//       length: 4,
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             children: [
//               Container(
//                 height: size.height * 0.36 + 5,
//                 child: Stack(
//                   children: [
//                     SizedBox(
//                       height: size.height * 0.33,
//                       child: Hero(
//                         tag: widget.list.imageUrl,
//                         child: Image.network(
//                           widget.list.imageUrl,
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                     ),
//                     Positioned(
//                         bottom: 0,
//                         left: 30,
//                         child: Text(
//                           widget.list.name,
//                           style: TextStyle(
//                               fontSize: 60, fontWeight: FontWeight.w900),
//                         ))
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TabBar(
//                     isScrollable: true,
//                     // controller: tabController,
//                     indicatorColor: Colors.blueAccent[700],
//                     indicatorPadding: EdgeInsets.only(left: 40, right: 20),
//                     indicatorWeight: 4,
//                     labelColor: Colors.black,
//                     labelStyle:
//                         TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
//                     unselectedLabelColor: Colors.black26,
//                     unselectedLabelStyle:
//                         TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
//                     tabs: [
//                       Tab(text: 'Entertain'),
//                       Tab(text: 'Places'),
//                       Tab(text: 'Foods'),
//                       Tab(text: 'Monuments'),
//                     ]),
//               ),
//               SizedBox(
//                 width: size.width,
//                 height: size.height * 0.4,
//                 child: TabBarView(children: [
//                   Container(
//                     height: 200,
//                     width: 200,
//                     color: Colors.red,
//                     child: Text('enetertainment'),
//                   ),
//                   Container(
//                     height: 200,
//                     width: 200,
//                   ),
//                   Container(
//                     height: 200,
//                     width: 200,
//                   ),
//                   Container(
//                     height: 200,
//                     width: 200,
//                   ),
//                 ]),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
