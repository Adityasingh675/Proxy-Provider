import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:proxy_provider_app/screens/welcome.dart';
import 'package:proxy_provider_app/services/geolocator_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GeoLocatorService geoLocatorService = GeoLocatorService();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider(create: (BuildContext context) => geoLocatorService.getCoords(),),
        ProxyProvider<Position, Future<List<Placemark>>>(update: (BuildContext context, position, placemarks) => (position != null) ? geoLocatorService.getAddress(position) : null),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Proxy Provider',
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText2: TextStyle(
              fontSize: 20.0,
            ),
          ),
          primarySwatch: Colors.blue,
        ),
        home: Welcome(),
      ),
    );
  }
}
