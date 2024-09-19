import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'spinner_spinBottomSheet.dart';
import 'package:restaurant_picker/utils/restaurantTypeNames.dart';
import 'package:restaurant_picker/services/getRestaurantData.dart';
import 'package:restaurant_picker/services/locationDataProvider.dart';
import 'package:restaurant_picker/services/mapFilterProvider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TypeItem extends StatefulWidget {
  const TypeItem({super.key, required this.name, required this.img});
  final String name;
  final String img;

  @override
  State<TypeItem> createState() => _TypeItemState();
}

class _TypeItemState extends State<TypeItem> {
  bool isSelected = false;
  NearbyRestaurantData nearbyRestaurantData = NearbyRestaurantData();

  @override
  Widget build(BuildContext context) {
    final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    final locationProvider =
    Provider.of<LocationProvider>(context, listen: false);
    LatLng location = locationProvider.searchedLocation!;
    double radius = filterProvider.apiRadius;
    List<String> restaurantType = filterProvider.apiRestaurantType;

    final Future<List<Map<String, dynamic>>> dataFuture =
        nearbyRestaurantData.fetchData(
            location: location, radius: radius, restaurantType: restaurantType);

    return Consumer<FilterProvider>(
      builder: (context, filterProvider, child) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            child: Container(
              height: 70,
              width: 70,
              margin: const EdgeInsets.only(right: 2.0),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.surface.withOpacity(0.3)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                      child: Image.asset(widget.img),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 10.0),
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              List<String> updatedList =
                  List<String>.from(filterProvider.apiRestaurantType);
              if (isSelected) {
                updatedList.remove(convertToAPIName(widget.name));
              } else {
                print('${widget.name}, ${convertToAPIName(widget.name)}');

                updatedList = [convertToAPIName(widget.name)!];
              }
              filterProvider.updateRestaurantType(updatedList);
              SpinnerBottomSheet.show(context, dataFuture);
              setState(() => isSelected = !isSelected);
            },
          ),
        );
      },
    );
  }
}

class RestaurantTypeFilterRow extends StatefulWidget {
  const RestaurantTypeFilterRow({super.key});

  @override
  _RestaurantTypeFilterRowState createState() =>
      _RestaurantTypeFilterRowState();
}

class _RestaurantTypeFilterRowState extends State<RestaurantTypeFilterRow>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;
  final ScrollController _scrollController = ScrollController();

  final List<String> displayTypeList = [
    'Brunch',
    'Cafe',
    'Chinese',
    'Hamburger',
    'Korean',
    'Pizza',
    'Ramen',
    'Sushi',
    'Thai',
    'Vegetarian',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 30),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1.0, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));

    _animation.addListener(() {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = maxScroll * _animation.value.dx.abs();
        _scrollController.jumpTo(currentScroll);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.stop(),
      onTapUp: (_) => _controller.repeat(reverse: true),
      child: SizedBox(
        height: 80,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: _scrollController,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            children: [
              ...displayTypeList.map((type) => TypeItem(
                    name: type,
                    img: 'assets/foodType/${type.toLowerCase()}.png',
                  )),
              ...displayTypeList.map((type) => TypeItem(
                    name: type,
                    img: 'assets/foodType/${type.toLowerCase()}.png',
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
