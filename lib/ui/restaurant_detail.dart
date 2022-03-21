import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//API
import '../data/api/api_service.dart';

//Constant
import '../common/constant.dart';

//Provider
import '../provider/get_detail_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';
  final String id;

  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
        create: (_) =>
            RestaurantDetailProvider(apiService: ApiService(), id: id),
        child: Scaffold(
          body: SafeArea(
            child: Consumer<RestaurantDetailProvider>(
                builder: (context, state, _) {
              if (state.state == ResultState.Loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.state == ResultState.HasData) {
                return DefaultTabController(
                  length: 2,
                  child: NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          pinned: true,
                          expandedHeight: 250.0,
                          flexibleSpace: FlexibleSpaceBar(
                            title: Text(state.result.restaurant.name,
                                textScaleFactor: 1),
                            background: Image.network(
                              Constant.baseUrl +
                                  'images/medium/' +
                                  state.result.restaurant.pictureId,
                              fit: BoxFit.cover,
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
                                          style:
                                              TextStyle(color: Colors.black54)),
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
                                          style:
                                              TextStyle(color: Colors.black54)),
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
                    body: TabBarView(
                      children: [
                        ListView(children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: state.result.restaurant.categories
                                      .map((category) => Text(category.name))
                                      .toList(),
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Menu',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SingleChildScrollView(
                                  padding: const EdgeInsets.all(8),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: state
                                        .result.restaurant.menus.foods
                                        .map((food) => Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      children: <Widget>[
                                                        const Icon(Icons.shop),
                                                        Text(food.name),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ))
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Drinks',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SingleChildScrollView(
                                  padding: const EdgeInsets.all(8),
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: state
                                        .result.restaurant.menus.drinks
                                        .map((drink) => Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Column(
                                                      children: <Widget>[
                                                        const Icon(Icons.shop),
                                                        Text(drink.name),
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ))
                                        .toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        Icon(Icons.directions_transit, size: 350),
                      ],
                    ),
                  ),
                );
              } else if (state.state == ResultState.NoData) {
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.Error) {
                return Center(child: Text(state.message));
              } else {
                return const Center(child: Text(''));
              }
            }),
          ),
        ));
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
