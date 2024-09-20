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



  final Future<List<Map<String, dynamic>>> dataFuture =
        nearbyRestaurantData.fetchData(context);

     return Consumer<FilterProvider>(
    builder: (context, filterProvider, child) {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isSelected ? 75 : 70,
            width: isSelected ? 75 : 70,
            margin: const EdgeInsets.only(right: 2.0),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.8)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: isSelected
                  ? [BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: Offset(0, 2),
                    )]
                  : [],
              border: isSelected
                  ? Border.all(color: Theme.of(context).colorScheme.secondary, width: 2)
                  : null,
            ),
            child: Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        isSelected ? Colors.white : Colors.transparent,
                        BlendMode.srcATop,
                      ),
                      child: Image.asset(widget.img),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.0,
                      color: isSelected ? Colors.white : Color.fromRGBO(255, 181, 160, 1),
                    ),
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
