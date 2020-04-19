import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Map<String, dynamic> _profile = {};
  final GlobalKey<FormState> _formKey = GlobalKey();

  void _submit() {
     if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save() ;
    {_profile['id'] = 'CS01A002';
    Firestore.instance
        .collection('customers')
        .document(_profile['id'])
        .setData(_profile);
    Navigator.of(context).pop();}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 20),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  onSaved: (value) {
                    _profile['name'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-Mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return 'Invalid email!';
                    }
                  },
                  onSaved: (value) {
                    _profile['email'] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  validator: (value) {
                    if (value.isEmpty || value.length != 10) {
                      return 'Enter a valid phone number!';
                    }
                  },
                  onSaved: (value) {
                    _profile['phone'] = value;
                  },
                ),
                SizedBox(height: 30),
                RaisedButton(
                  child: Text('Submit'),
                  onPressed: _submit,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
                  color: Colors.orange,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
