import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../widgets/shopcard.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Geolocator geolocator = Geolocator();
  Position userLocation;
  String userPlace = '';

  @override
  void initState() {
    super.initState();
    _getLocation().then((position) {
      setState(() {
        userLocation = position;
      });
      _getPlace(userLocation).then((place) {
        // place.forEach((p) => print('${p.name} ${p.locality} ${p.position}'));
        setState(() {
          userPlace = place[0].locality;
        });
      });
    });
  }

  Future<List<Placemark>> _getPlace(userLocation) async {
    List<Placemark> currentPlace;
    try {
      currentPlace = await Geolocator().placemarkFromCoordinates(
          userLocation.latitude, userLocation.longitude);
    } catch (e) {
      currentPlace = null;
    }
    return currentPlace;
  }

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.location_searching,
                  color: Colors.orange,
                ),
                SizedBox(width: 10),
                userLocation == null
                    ? CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.orange),
                      )
                    : Text(userPlace),
                // : Text("Location:" +
                //     userLocation.latitude.toString() +
                //     " " +
                //     userLocation.longitude.toString()),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(color: Colors.orange),
            ),
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 10),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Colors.orange,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Nearby Shops',
                      hintStyle: TextStyle(
                        color: Colors.orange,
                      ),
                    ),
                  ),
                ),
                Icon(
                  Icons.mic,
                  color: Colors.orange,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            // height: MediaQuery.of(context).size.height * 0.5,
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('shops').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError)
                  return new Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return new Text('Loading...');
                  default:
                    return new ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return new ShopCard(document);
                      }).toList(),
                    );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
