// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: NativePluginWidget(),
//     );
//   }
// }
//
// class NativePluginWidget extends StatefulWidget {
//   @override
//   NativePluginWidgetState createState() => NativePluginWidgetState();
// }
//
// class NativePluginWidgetState extends State<NativePluginWidget> {
//   String? latitude;
//   String? longitude;
//   LatLng? currentLocation;
//   late GoogleMapController mapController;
//
//   getGeoData() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('permissions are denied');
//       }
//     }
//
//     Position position = await Geolocator.getCurrentPosition();
//     setState(() {
//       latitude = position.latitude.toString();
//       longitude = position.longitude.toString();
//       currentLocation = LatLng(position.latitude, position.longitude);
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     getGeoData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Geolocator & Google Maps")),
//       body: currentLocation == null
//           ? Center(child: CircularProgressIndicator())
//           : Container(
//               child: GoogleMap(
//                 onMapCreated: (GoogleMapController controller) {
//                   mapController = controller;
//                 },
//                 initialCameraPosition: CameraPosition(
//                   target: currentLocation!,
//                   zoom: 15.0,
//                 ),
//               ),
//             ),
//     );
//   }
// }
