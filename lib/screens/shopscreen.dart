import 'package:flutter/material.dart';

import './orderscreen.dart';

class ShopScreen extends StatelessWidget {
  final document;

  ShopScreen(this.document);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          document['Name'],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              width: mediaQuery.size.width * 0.9,
              height: mediaQuery.size.height * 0.4,
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  document['imgurl'],
                  fit: BoxFit.cover,
                  // height: mediaQuery.size.height * 0.24,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                document['Name'],
                style: TextStyle(fontSize: 30),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                document['Vendor'],
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                document['Phone number'],
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    document['Location'],
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 50),
                  Text(
                    'Delivery',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(width: 8),
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
            SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => OrderScreen(document),
                  ));
                },
                color: Colors.orange,
                child: Text(
                  'Order',
                  style: TextStyle(
                    color: Color(0xedffffff),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
