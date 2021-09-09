import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/itemmodel.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/models/userr.dart';
class Additem extends StatelessWidget {
  final db = FirebaseFirestore.instance;
  final item Item;
  Additem({Key key, @required this.Item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Userr>(context);

    TextEditingController _namecontroller = new TextEditingController();
    TextEditingController _locationcontroller = new TextEditingController();
    TextEditingController _pricecontroller = new TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text("Add"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Enter item"),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _namecontroller ,
                  autofocus: true,
                ),
              ),
              Text("Enter price"),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _pricecontroller ,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Text("Enter location"),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _locationcontroller ,
                  autofocus: true,
                ),
              ),

              //dateinput
              ElevatedButton(
                child: Text("Add"),
                onPressed: () async {
                  Item.name = _namecontroller.text;
                  Item.price = double.parse(_pricecontroller.text);
                  Item.dateadded = DateTime.now();
                  Item.location = _locationcontroller.text;
                  Item.userid= user.uid;

                  await db.collection("items").add(
                      {'name': Item.name,
                        'price': Item.price,
                        'Date of Harvest/Produce': Item.dateadded,
                        'Location': Item.location,
                        'user': Item.userid,
                      }
                  );



                  db.collection("users").doc(Item.userid).collection("items").add(
                      {
                        'name': Item.name,
                        'price': Item.price,
                        'Date of Harvest/Produce': Item.dateadded,
                        'Location': Item.location,
                      });
                  Navigator.pop(context);

                },

              )
            ],
          ),
        )

    );
  }
}