import 'package:card_swiper/card_swiper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/city_page.dart';
import 'package:travel_app/each_city.dart';
import 'package:travel_app/models/todo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/services/login_services.dart';

import 'login_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CollectionReference city = FirebaseFirestore.instance.collection('city');

  final social = SocialAuth();

  List<ToDo> getListToDoCity() {
    return [
      ToDo(
          title: 'Travel',
          imagePath: 'assets/travel.png',
          description: 'Discover the best sports in the city'),
      ToDo(
          title: 'Foods',
          imagePath: 'assets/restaurant.png',
          description: 'Discover the best sports in the city'),
      ToDo(
          title: 'Monument',
          imagePath: 'assets/monuments2.png',
          description: 'Discover the best sports in the city'),
      ToDo(
          title: 'Entertain',
          imagePath: 'assets/entertainment.png',
          description: 'Discover the best sports in the city'),
      ToDo(
          title: 'Sports',
          imagePath: 'assets/dumbbell.png',
          description: 'Discover the best sports in the city'),
    ];
  }

  List<City> getListCity() {
    return [
      City(
          name: 'Gaya',
          imageUrl:
              'https://bodhgaya.tourismindia.co.in/images/places-to-visit/header/metta-buddharam-temple-bodh-gaya-tourism-entry-fee-timings-holidays-reviews-header.jpg',
          description: 'Explore the countryside of tokyo and its activities'),
      City(
          name: 'Patna',
          imageUrl:
              'https://thumbs.dreamstime.com/b/takht-sri-patna-sahib-patna-bihar-takht-sri-patna-sahib-also-known-as-harmandir-sahib-gurdwara-neighbourhood-patna-168780878.jpg',
          description: 'Explore the countryside of tokyo and its activities'),
      City(
          name: 'Rajgir',
          imageUrl:
              'https://images.thrillophilia.com/image/upload/s--UYr7_IXd--/c_fill,h_775,q_auto,w_1600/f_auto,fl_strip_profile/v1/images/photos/000/365/023/original/1611126176_1_21053_02.jpg.jpg?1611126175',
          description: 'Explore the countryside of tokyo and its activities'),
      City(
          name: 'Muzaffarpur',
          imageUrl:
              'https://gumlet.assettype.com/Prabhatkhabar%2F2021-03%2F47a5c709-b4d7-424f-8484-41a576177f96%2Fdownload.jpg?format=webp&w=400&dpr=2.6',
          description: 'Explore the countryside of tokyo and its activities'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                      radius: 22,
                      backgroundImage:
                          NetworkImage(auth.currentUser!.photoURL.toString())),
                  Text(auth.currentUser!.displayName.toString()),
                  GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut().then((value) =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPage())));
                      },
                      child: SizedBox(
                          height: 22, child: Image.asset('assets/menu.png')))
                ],
              ),
              SizedBox(height: 20),
              Text(
                'To go',
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900),
              ),
              SizedBox(height: 25),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(1, 1),
                          blurRadius: 12)
                    ]),
                child: TextField(
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black26),
                  ),
                ),
              ),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Top trending',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Color(0xFFD3E5FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fixedSize: Size(80, 15),
                        padding: EdgeInsets.all(4)),
                    child: const Text(
                      'See all',
                      style: TextStyle(
                          color: Color(0xFF367CF7),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              FutureBuilder<DocumentSnapshot>(
                  future: city.doc('QpUvr5R0QtRvI9Q9hH9a').get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }

                    if (snapshot.hasData && !snapshot.data!.exists) {
                      return Text("Document does not exist");
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data =
                          snapshot.data!.data() as Map<String, dynamic>;

                      return SizedBox(
                          height: size.height * 0.3,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              // itemCount: getListCity().length,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                // print(data['${index}']);
                                return Column(
                                  children: [
                                    cityCard(
                                        size: size,
                                        context: context,
                                        onpress: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      CityPageScrolling(
                                                        list: data['${index}'],
                                                      )));
                                        },
                                        // name: getListCity()[index].name,
                                        name: data['${index}']['name'],
                                        url: data['${index}']['imageUrl'],
                                        desc: data['${index}']['description']),
                                    SizedBox(height: 5)
                                  ],
                                );
                              }));
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'What to do ?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        primary: Color(0xFFD3E5FF),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fixedSize: Size(80, 15),
                        padding: EdgeInsets.all(4)),
                    child: Text(
                      'See all',
                      style: TextStyle(
                          color: Color(0xFF367CF7),
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(
                  height: size.height * 0.23,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: getListToDoCity().length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                    top: 10, left: 10, right: 8),
                                height: size.height * 0.2,
                                width: size.width * 0.26,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          offset: const Offset(1, 1),
                                          blurRadius: 12)
                                    ]),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black,
                                      radius: 30,
                                      child: Image.asset(
                                        getListToDoCity()[index].imagePath,
                                        color: Colors.white,
                                        height: 30,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    FittedBox(
                                      child: Text(
                                        getListToDoCity()[index].title,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      'Discover sports during your trip',
                                      style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ],
                                )),
                            SizedBox(height: 5),
                          ],
                        );
                      })),
            ],
          ),
        ),
      )),
    );
  }

  Widget cityCard({size, name, url, desc, context, onpress}) {
    return Container(
      height: size.height * 0.3 - 15,
      width: size.width * 0.5,
      margin: const EdgeInsets.only(right: 20),
      child: Stack(
        children: [
          Center(
            child: Container(
              // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              padding: const EdgeInsets.only(left: 8, bottom: 12),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        offset: const Offset(1, 1),
                        blurRadius: 12)
                  ]),
              width: size.width * 0.5 - 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(desc,
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black38)),
                  SizedBox(height: 15),
                  InkWell(
                    onTap: onpress,
                    child: Row(
                      children: [
                        const Text(
                          'Explore',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        const Icon(
                          Icons.arrow_forward,
                          size: 15,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.16,
            child: Image.network(
              url,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: size.height * 0.11 - 10,
            left: size.width * 0.07,
            child: Text(
              name,
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900),
            ),
          ),
        ],
      ),
    );
  }
}
