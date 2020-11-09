import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final position = Provider.of<Position>(context);
    final addressProxy = Provider.of<Future<List<Placemark>>>(context);
    return FutureProvider(
      create: (BuildContext context) => addressProxy,
      child: Scaffold(
        body: (addressProxy != null)
            ? Consumer<List<Placemark>>(
                builder: (BuildContext context, addressList, widget) {
                  return (addressList != null)
                      ? _buildList(position, addressList[0])
                      : Center(
                          child: CircularProgressIndicator(),
                        );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}

Widget _buildList(Position position, Placemark placemark) {
  return ListView(
    children: [
      ListTile(title: Text('Your Position', style: TextStyle(fontSize: 25.0),),),
      ListTile(leading: Text('Latitude'), trailing: Text(position.latitude.toString()),),
      ListTile(leading: Text('Longitude'), trailing: Text(position.longitude.toString()),),
      ListTile(leading: Text('Speed'), trailing: Text(position.speed.toString()),),
      ListTile(leading: Text('City'), trailing: Text(placemark.locality),),
      ListTile(leading: Text('Country'), trailing: Text(placemark.country),),
      ListTile(leading: Text('Flag'), trailing: Image.network("https://www.countryflags.io/${placemark.isoCountryCode}/flat/32.png"),)
    ],
  );
}
