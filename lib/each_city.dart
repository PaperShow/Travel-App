import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/models/todo.dart';

class CityPageScrolling extends StatefulWidget {
  final list;
  CityPageScrolling({Key? key, required this.list}) : super(key: key);

  @override
  State<CityPageScrolling> createState() => _CityPageScrollingState();
}

class _CityPageScrollingState extends State<CityPageScrolling> {
  late final String cityName;
  late CollectionReference eachCity;
  @override
  void initState() {
    cityName = widget.list['name'];
    super.initState();
   eachCity =
        FirebaseFirestore.instance.collection(cityName);
  }

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        height: 280,
                        child: Stack(
                          children: [
                            Container(
                              height: 250,
                              color: Colors.blue,
                              child: Image.network(
                                widget.list['imageUrl'],
                                fit: BoxFit.fill,
                              ),
                            ),
                            Positioned(
                                bottom: 0,
                                left: 30,
                                child: Text(
                                  widget.list['name'],
                                  style: TextStyle(
                                      fontSize: 60,
                                      fontWeight: FontWeight.w900),
                                )),
                          ],
                        ),
                      )
                    ]),
                  ),
                ];
              },
              body: Column(
                children: [
                  TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.blueAccent[700],
                      indicatorPadding: EdgeInsets.only(left: 40, right: 20),
                      indicatorWeight: 4,
                      labelColor: Colors.black,
                      labelStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                      unselectedLabelColor: Colors.black26,
                      unselectedLabelStyle:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                      tabs: [
                        Tab(text: 'Entertain'),
                        Tab(text: 'Places'),
                        Tab(text: 'Foods'),
                        Tab(text: 'Monuments'),
                      ]),
                  Expanded(
                      child: TabBarView(children: [
                    diffrentTabList(context: context, name: 'Entertain'),
                    diffrentTabList(context: context, name: 'Places'),
                    diffrentTabList(context: context, name: 'Food'),
                    diffrentTabList(context: context, name: 'Monuments'),
                  ]))
                ],
              )),
          // child: CustomScrollView(
          //   slivers: [
          //     SliverPersistentHeader(
          //       delegate: CustomSliverAppBarDelegate(
          //           list: list, expandedHeight: size.height * 0.4),
          //       pinned: true,
          //     ),
          //     // sliverList(context),
          //     list2(context)
          //   ],
          // ),
        ),
      ),
    );
  }

  Widget diffrentTabList({context, name}) {
    return FutureBuilder<DocumentSnapshot>(
        future: eachCity.doc(name).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("Something went wrong");
          }

          if (snapshot.hasData && !snapshot.data!.exists) {
            return Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (ctx, index) {
                  // print(data['${index}']['name']);
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    height: 130,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(1, 1),
                                      blurRadius: 12)
                                ]),
                          ),
                        ),
                        Positioned(
                          left: index.isOdd
                              ? 0
                              : MediaQuery.of(context).size.width * 0.53 - 60,
                          child: SizedBox(
                            height: 130,
                            width: MediaQuery.of(context).size.width * 0.47,
                            child: Image.network(
                              'https://www.expatica.com/app/uploads/sites/10/2014/05/best-place-to-live-in-uk.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                            top: index.isEven ? 30 : 50,
                            left: index.isEven
                                ? 0
                                : MediaQuery.of(context).size.width * 0.53,
                            child: Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['${index}']['name'],
                                      style: TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 15),
                                    ),
                                    InkWell(
                                      onTap: () {},
                                      child: Row(
                                        children: [
                                          Text(
                                            'Explore',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.blue,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.blue,
                                            size: 15,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ))
                      ],
                    ),
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  // Widget sliverList(context) {
  //   return SliverToBoxAdapter(
  //     child: SizedBox(
  //       height: MediaQuery.of(context).size.height,
  //       width: MediaQuery.of(context).size.height,
  //       child: TabBarView(children: [
  //         diffrentTabList(context),
  //         diffrentTabList(context),
  //         diffrentTabList(context),
  //         diffrentTabList(context),
  //       ]),
  //     ),
  //   );
  // }

  // Widget list2(context) {
  //   return SliverList(
  //     delegate: SliverChildListDelegate([
  //       TabBar(
  //           isScrollable: true,
  //           indicatorColor: Colors.blueAccent[700],
  //           indicatorPadding: EdgeInsets.only(left: 40, right: 20),
  //           indicatorWeight: 4,
  //           labelColor: Colors.black,
  //           labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
  //           unselectedLabelColor: Colors.black26,
  //           unselectedLabelStyle:
  //               TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
  //           tabs: [
  //             Tab(text: 'Entertain'),
  //             Tab(text: 'Places'),
  //             Tab(text: 'Foods'),
  //             Tab(text: 'Monuments'),
  //           ]),
  //       SizedBox(
  //         height: MediaQuery.of(context).size.height,
  //         width: MediaQuery.of(context).size.height,
  //         child: TabBarView(children: [
  //           diffrentTabList(context),
  //           diffrentTabList(context),
  //           diffrentTabList(context),
  //           diffrentTabList(context),
  //         ]),
  //       ),
  //     ]),
  //   );
  // }
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double expandedHeight;
  const CustomSliverAppBarDelegate({required this.expandedHeight, this.list})
      : super();

  final list;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Opacity(
          opacity: disappear(shrinkOffset),
          child: SizedBox(
            height: size.height * 0.33,
            child: Image.network(
              list.imageUrl,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
            bottom: 30,
            left: 30,
            child: Text(
              list.name,
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.w900),
            )),
        // Positioned(
        //   bottom: 0,
        //   child: TabBar(
        //       isScrollable: true,
        //       indicatorColor: Colors.blueAccent[700],
        //       indicatorPadding: EdgeInsets.only(left: 40, right: 20),
        //       indicatorWeight: 4,
        //       labelColor: Colors.black,
        //       labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        //       unselectedLabelColor: Colors.black26,
        //       unselectedLabelStyle:
        //           TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
        //       tabs: [
        //         Tab(text: 'Entertain'),
        //         Tab(text: 'Places'),
        //         Tab(text: 'Foods'),
        //         Tab(text: 'Monuments'),
        //       ]),
        // ),
        buildAppBar(shrinkOffset),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;

  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

  Widget buildAppBar(double shrinkOffset) {
    return Opacity(
        opacity: appear(shrinkOffset),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: TabBar(
              isScrollable: true,
              indicatorColor: Colors.blueAccent[700],
              indicatorPadding: EdgeInsets.only(left: 40, right: 20),
              indicatorWeight: 4,
              labelColor: Colors.black,
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              unselectedLabelColor: Colors.black26,
              unselectedLabelStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
              tabs: [
                Tab(text: 'Entertain'),
                Tab(text: 'Places'),
                Tab(text: 'Foods'),
                Tab(text: 'Monuments'),
              ]),
        ));
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
