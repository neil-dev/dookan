import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderScreen extends StatefulWidget {
  final document;

  OrderScreen(this.document);
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final Map<String, int> _items = {
    'dal': 4,
    'potato': 6,
    'rice': 8,
    'maggi': 10,
    'biscuit': 3,
    'milk': 7,
  };
  // Map<String, dynamic> _items = {};

  Map<String, bool> checkList = {};
  Map<String, double> order = {};

  void initState() {
    super.initState();
    // Firestore.instance
    //     .collection('items')
    //     .document(widget.document['ID'])
    //     .get()
    //     .then((value) {
    //   value.data.forEach((title, quantity) {
    //     _items[title] = double.parse(quantity);
    //   });
    //   return value.data;
    // });
    // print(_items);
    _items.forEach((item, _) {
      checkList[item] = false;
    });
  }

  List<Widget> items() {
    List<Widget> itemList = [];
    _items.forEach((item, quantity) {
      if (quantity > 0) {
        itemList.add(
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 15,
              horizontal: 20,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  item,
                  style: TextStyle(fontSize: 20),
                ),
                // SizedBox(width: 20),
                Row(
                  children: <Widget>[
                    if (checkList[item] == true)
                      Text(
                        'QTY: ',
                        style: TextStyle(fontSize: 20),
                      ),
                    if (checkList[item] == true)
                      Container(
                        height: 30,
                        width: 40,
                        // alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                        ),
                        padding: EdgeInsets.only(left: 5),
                        child: TextField(
                          style: TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '0.0',
                          ),
                          onChanged: (val) {
                            order[item] = double.parse(val);
                          },
                        ),
                      ),
                    SizedBox(width: 20),
                    Checkbox(
                      value: checkList[item],
                      onChanged: (bool val) {
                        print(val);
                        setState(() {
                          checkList[item] = val;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }
    });
    return itemList;
  }

  @override
  Widget build(BuildContext context) {
    // print(checkList);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text(
          'Place your Order',
        ),
        // centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ...items(),
            SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: RaisedButton(
                onPressed: () {
                  order.removeWhere((_, val) {
                    return val == 0;
                  });
                  Map<String, dynamic> orderInfo = {
                    'ID': widget.document['ID']
                  };
                  final custID = 'CU01ST001';
                  orderInfo['order'] = {
                    custID: {
                      'delivery': widget.document['Delivery'],
                      'items': order,
                      'slot': '11:00',
                    }
                  };

                  Firestore.instance
                      .collection('orders')
                      .document(widget.document['ID'])
                      .setData(orderInfo);
                  Navigator.of(context).pop();
                  print(order);
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
          // children: <Widget>[
          //   SizedBox(height: 20),
          //   Container(
          //     margin: EdgeInsets.symmetric(horizontal: 20),
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: <Widget>[],
          //     ),
          //   ),
          // ],
        ),
      ),
    );
  }
}
