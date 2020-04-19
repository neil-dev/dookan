import 'package:flutter/material.dart';

import '../screens/shopscreen.dart';

class ShopCard extends StatelessWidget {
  final document;

  ShopCard(this.document);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => ShopScreen(document),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.orange[300],
            style: BorderStyle.solid,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 5,
          vertical: 20,
        ),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                document['imgurl'],
                fit: BoxFit.cover,
                height: mediaQuery.size.height * 0.24,
                width: double.infinity,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                // color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    document['Name'],
                    style: TextStyle(
                      fontSize: 20,
                      // fontFamily: 'Caviar Dreams',
                      fontWeight: FontWeight.bold,
                      // color: Theme.of(context).textTheme.subtitle.color,
                    ),
                  ),
                  SizedBox(width: mediaQuery.size.width * 0.005),
                  Icon(
                    Icons.location_on,
                    // color: Theme.of(context).textTheme.subtitle.color,
                  ),
                  Text(
                    document['Location'],
                    style: TextStyle(
                      // fontFamily: 'Caviar Dreams',
                      fontWeight: FontWeight.bold,
                      // color: Theme.of(context).textTheme.subtitle.color,
                    ),
                  ),
                  SizedBox(width: mediaQuery.size.width * 0.005),
                  Icon(
                    Icons.directions_bike,
                    // color: Theme.of(context).textTheme.subtitle.color,
                  ),
                  Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: document['Delivery'] ? Colors.green : Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
