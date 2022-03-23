import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//API
import '../data/api/api_service.dart';

//Constant
import '../common/constant.dart';

//Model
import '../data/model/restaurant.dart';

//Widgets
import '../widgets/icon_label.dart';
import '../widgets/card_image.dart';
import '../widgets/blankslate.dart';

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
                RestaurantInfo restoData = state.result.restaurant;
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
                            title: Text(restoData.name, textScaleFactor: 1),
                            background: Image.network(
                              Constant.baseUrl +
                                  'images/medium/' +
                                  restoData.pictureId,
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
                        SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //City and Rating
                                Row(
                                  children: [
                                    IconLabel(
                                        icon: Icons.location_on,
                                        color: Colors.black54,
                                        label: restoData.city),
                                    const SizedBox(width: 16),
                                    IconLabel(
                                        icon: Icons.star,
                                        color: Colors.orange,
                                        label: restoData.rating.toString()),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                const Text('Description',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54)),
                                const SizedBox(height: 8),
                                Text(restoData.description,
                                    style:
                                        const TextStyle(color: Colors.black45)),
                                const Divider(height: 20),
                                const Text('Category',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54)),
                                const SizedBox(height: 4),
                                SizedBox(
                                    height: 50,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children:
                                          restoData.categories.map((category) {
                                        return Row(
                                          children: [
                                            Chip(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                label: Text(category.name)),
                                            const SizedBox(width: 8)
                                          ],
                                        );
                                      }).toList(),
                                    )),
                                const Divider(height: 20),
                                const Text(
                                  'Foods',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                _horizontalMenuList(
                                    restoData.menus.foods, 'images/food.jpg'),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Text(
                                  'Drinks',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                _horizontalMenuList(
                                    restoData.menus.drinks, 'images/drink.jpg'),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: ListView(
                                        shrinkWrap: true,
                                        children: restoData.customerReviews
                                            .map((review) => Column(
                                                  children: [
                                                    ListTile(
                                                      title: Text(review.name),
                                                      subtitle: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(review.date,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left),
                                                          const SizedBox(
                                                              height: 4),
                                                          Text(review.review,
                                                              textAlign:
                                                                  TextAlign
                                                                      .left),
                                                        ],
                                                      ),
                                                    ),
                                                    const Divider()
                                                  ],
                                                ))
                                            .toList()))
                              ]),
                        )
                      ],
                    ),
                  ),
                );
              } else if (state.state == ResultState.NoData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Blankslate(),
                    const SizedBox(height: 8),
                    Text(state.message),
                    const SizedBox(height: 8),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Back'))
                  ],
                );
              } else if (state.state == ResultState.Error) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Blankslate(),
                    const SizedBox(height: 8),
                    Text(state.message),
                    const SizedBox(height: 8),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Back'))
                  ],
                );
              } else {
                return const Center(child: Text(''));
              }
            }),
          ),
        ));
  }

  Widget _horizontalMenuList(List<Category> items, String imgPath) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map((item) => Row(
                  children: [
                    CardImage(imgPath: imgPath, label: item.name),
                    const SizedBox(width: 8)
                  ],
                ))
            .toList(),
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
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
