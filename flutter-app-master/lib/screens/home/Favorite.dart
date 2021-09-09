import 'package:flutter/material.dart';
import 'package:flutter_app/models/userr.dart';
import 'package:flutter_app/screens/shared/loading.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';


class Favorite extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr>(context);
    return Container(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').doc(user.uid).collection('items').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Loading();
            else {
              return new ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) =>
                      buildTripCard(context, snapshot.data.docs[index]));
            }
          }
      ),
    );
  }


  Widget buildTripCard(BuildContext context, DocumentSnapshot trip) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Text(trip.get('name'), style: new TextStyle(fontSize: 30.0),),
                  Spacer(),
                ]),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: Row(
                  children: <Widget>[
                    Text("₹${trip.get('price').toString()}"),
                    Spacer(),
                    Text(trip.get('Location')),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}