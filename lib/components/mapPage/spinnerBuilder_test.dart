// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'spinner_spinnerCard.dart';
// import '../../services/getRestaurantData_test.dart';
// import '../../services/firestoreService.dart';
// import 'package:provider/provider.dart';
// import '../../services/locationDataProvider.dart';
// import '../../services/mapFilterProvider.dart';

// enum DataSource {
//   nearbyRestaurants,
//   favoriteRestaurants,
// }

// class SpinnerBuilder extends StatefulWidget {
//   final String? loggedinUserID;
//   final DataSource dataSource;

//   const SpinnerBuilder({
//     Key? key,
//     this.loggedinUserID,
//     required this.dataSource,
//   }) : super(key: key);

//   @override
//   SpinnerBuilderState createState() => SpinnerBuilderState();
// }

// class SpinnerBuilderState extends State<SpinnerBuilder> {
//   late StreamController<int> controller;
//   List<Map<String, dynamic>> allRestaurants = [];
//   List<Map<String, dynamic>> displayedRestaurants = [];
//   int spinCount = 0;
//   final int maxSpinBeforeRefresh = 15;
//   int? lastSelectedIndex;
//   bool isLoading = false;

//   @override
//   void initState() {
//     super.initState();
//     controller = StreamController<int>.broadcast();
//     _initializeDataSource();
//   }

//   @override
//   void dispose() {
//     controller.close();
//     super.dispose();
//   }

//   Future<void> _initializeDataSource() async {
//     setState(() {
//       isLoading = true;
//     });

//     try {
//       if (widget.dataSource == DataSource.nearbyRestaurants) {
//         await _loadNearbyRestaurants();
//       } else {
//         await _loadFavoriteRestaurants();
//       }
//       _selectRandomRestaurants();
//     } catch (e) {
//       print('Error initializing data source: $e');
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   Future<void> _loadNearbyRestaurants() async {
//     final locationProvider = Provider.of<LocationProvider>(context, listen: false);
//     final filterProvider = Provider.of<FilterProvider>(context, listen: false);
    
//     LatLng searchedLocation = locationProvider.searchedLocation ?? locationProvider.currentLocation!;
//     double radius = filterProvider.apiRadius!;
//     List<String> restaurantType = filterProvider.apiRestaurantType;

//     NearbyRestaurantData placesService = NearbyRestaurantData();
//     allRestaurants = await placesService.fetchData(
//       location: searchedLocation,
//       radius: radius,
//       restaurantType: restaurantType,
//     );
//   }

//   Future<void> _loadFavoriteRestaurants() async {
//     if (widget.loggedinUserID == null) {
//       throw Exception('User ID is required for favorite restaurants');
//     }
//     FirestoreService firestoreService = FirestoreService();
    
//     // 獲取 QuerySnapshot 並轉換為 List<Map<String, dynamic>>
//     QuerySnapshot querySnapshot = await firestoreService.fetchFavoriteRestaurants(widget.loggedinUserID!).first;
//     allRestaurants = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
//   }

//   void _selectRandomRestaurants() {
//     if (allRestaurants.length <= 5) {
//       displayedRestaurants = List.from(allRestaurants);
//     } else {
//       displayedRestaurants = List.from(allRestaurants)..shuffle();
//       displayedRestaurants = displayedRestaurants.take(5).toList();
//     }
//     lastSelectedIndex = null;
//   }

//   Future<void> spinAgain() async {
//     setState(() {
//       spinCount++;
//       if (spinCount >= maxSpinBeforeRefresh) {
//         _initializeDataSource();
//         spinCount = 0;
//       } else {
//         _selectRandomRestaurants();
//       }

//       int newIndex;
//       do {
//         newIndex = Random().nextInt(displayedRestaurants.length);
//       } while (newIndex == lastSelectedIndex && displayedRestaurants.length > 1);

//       lastSelectedIndex = newIndex;
//       controller.add(newIndex);
//     });
//   }

//   Widget _buildSpinner() {
//     if (displayedRestaurants.isEmpty) {
//       return Text('No restaurants found. Please try again later.');
//     }

//     List<FortuneItem> fortuneItems = displayedRestaurants
//         .map((restaurant) => buildRestaurantData(restaurant))
//         .toList();

//     return Column(
//       children: [
//         FortuneBar(
//           height: MediaQuery.of(context).size.height * 0.3,
//           styleStrategy: UniformStyleStrategy(
//             color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
//             borderColor: Theme.of(context).colorScheme.surface.withOpacity(0.8),
//           ),
//           selected: controller.stream,
//           visibleItemCount: 1,
//           items: fortuneItems,
//           indicators: <FortuneIndicator>[
//             FortuneIndicator(
//               alignment: Alignment.topCenter,
//               child: RectangleIndicator(
//                 color: Colors.transparent,
//                 borderColor: Colors.transparent,
//               ),
//             ),
//           ],
//         ),
//         FilledButton(
//           child: Text(
//             'Try Again',
//             style: const TextStyle(
//               color: Colors.white,
//               fontSize: 20.0,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//           onPressed: spinAgain,
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return Center(child: CircularProgressIndicator());
//     }

//     return _buildSpinner();
//   }
// }