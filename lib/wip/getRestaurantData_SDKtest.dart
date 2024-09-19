// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'locationDataProvider.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter_google_places_sdk/flutter_google_places_sdk.dart'
//     as places_sdk;
// //https://pub.dev/packages/flutter_google_places_sdk/example
// import 'mapFilterProvider.dart';

// class NearbyRestaurantData {
//   LocationProvider locationProvider = LocationProvider();
//   FilterProvider filterProvider = FilterProvider();

//   String googApikey = dotenv.env['googApikey']!;
//   final places = places_sdk.FlutterGooglePlacesSdk(dotenv.env['googApikey']!);

//   static final NearbyRestaurantData _instance =
//       NearbyRestaurantData._internal();
//   factory NearbyRestaurantData() {
//     return _instance;
//   }

//   NearbyRestaurantData._internal();

//   Future<List<Map<String, dynamic>>> fetchData() async {
//     await locationProvider.getLocation();
//     LatLng location = locationProvider.currentLocation!;
//     double lat = location.latitude;
//     double lng = location.longitude;
//     double? radius = filterProvider.apiRadius;
//     String? priceLevel = filterProvider.apiPriceLevel;
//     List? restaurantType = filterProvider.apiRestaurantType;

//     final result = await places.fetchPlace(
//       'AAA',
//       fields: [
//         places_sdk.PlaceField.Id,
//         places_sdk.PlaceField.Name,
//         places_sdk.PlaceField.Rating,
//         places_sdk.PlaceField.UserRatingsTotal,
//         places_sdk.PlaceField.Address,
//         places_sdk.PlaceField.PhotoMetadatas,
//         places_sdk.PlaceField.PriceLevel,
//       ],
//     );

//     return result.places.map((place) {
//       String getPhotoUrl(places_sdk.PhotoMetadata? photo,
//           {int maxWidth = 400, int maxHeight = 400}) {
//         return photo != null
//             ? places._fetchingPlacePhoto(photo,
//                 maxWidth: maxWidth, maxHeight: maxHeight)
//             : 'https://images.unsplash.com/photo-1514933651103-005eec06c04b?q=80&w=400&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';
//       }

//       return {
//         'id': place.placeId ?? '',
//         'name': place.name ?? 'No Name',
//         'address': place.formattedAddress ?? 'No Address',
//         'rating': place.rating ?? 0.0,
//         'ratingCount': place.userRatingsTotal ?? 0,
//         'priceLevel': place.priceLevel?.toString() ?? 'N/A',
//         'photo': getPhotoUrl(place.photoMetadatas?.first),
//       };
//     }).toList();
//   }
// }
