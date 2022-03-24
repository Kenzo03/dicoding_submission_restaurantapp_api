import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/search_provider.dart';
import '../widgets/restaurant_card.dart';
import '../widgets/blankslate.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String queries = '';
  final TextEditingController _searchControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Search Restaurant')),
        body: SafeArea(
          child: Column(children: [
            _searchBar(),
            const SizedBox(height: 8),
            Expanded(
              child: Consumer<SearchRestaurantProvider>(
                  builder: (context, state, _) {
                if (state.state == ResultState.Loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.state == ResultState.HasData) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.result!.restaurants.length,
                      itemBuilder: (context, index) {
                        var restaurant = state.result!.restaurants[index];
                        return CardRestaurant(restaurant: restaurant);
                      });
                } else if (state.state == ResultState.NoData) {
                  return Center(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: const [
                      Icon(Icons.search_off, color: Colors.grey, size: 64),
                      SizedBox(height: 24),
                      Text('No restaurant found. Please recheck your keyword',
                          style: TextStyle(color: Colors.grey))
                    ],
                  ));
                } else if (state.state == ResultState.NoConnection) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Blankslate(),
                        const SizedBox(height: 8),
                        Text(state.message),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                } else if (state.state == ResultState.Error) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const Blankslate(),
                        const SizedBox(height: 8),
                        Text(state.message),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text(''));
                }
              }),
            )
          ]),
        ));
  }

  Widget _searchBar() {
    return Consumer<SearchRestaurantProvider>(builder: (context, state, _) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6.0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: TextField(
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: "Search by Resto name / Menu name",
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintStyle: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
              maxLines: 1,
              controller: _searchControl,
              onChanged: (String query) {
                if (query.isNotEmpty) {
                  setState(() {
                    queries = query;
                  });
                  state.fetchQueryRestaurant(query);
                }
              },
            ),
          ),
        ),
      );
    });
  }
}
