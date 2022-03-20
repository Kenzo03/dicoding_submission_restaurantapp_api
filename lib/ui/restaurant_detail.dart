import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  const RestaurantDetailPage({Key? key}) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 2,
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  pinned: false,
                  expandedHeight: 250.0,
                  flexibleSpace: FlexibleSpaceBar(
                    title: const Text('Goa', textScaleFactor: 1),
                    background: Image.asset(
                      'images/food.jpg',
                      fit: BoxFit.fill,
                    ),
                    stretchModes: const [StretchMode.zoomBackground],
                  ),
                  //collapsedHeight: 100,
                ),
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    TabBar(
                      tabs: [
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.info,
                                color: Colors.black54,
                              ),
                              SizedBox(width: 8),
                              Text('Restaurant Info',
                                  style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                        Tab(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Icon(
                                Icons.reviews,
                                color: Colors.black54,
                              ),
                              SizedBox(width: 8),
                              Text('Reviews',
                                  style: TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
              ];
            },
            body: const TabBarView(
              children: [
                Icon(Icons.flight, size: 350),
                Icon(Icons.directions_transit, size: 350),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
