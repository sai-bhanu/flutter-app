import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/userr.dart';
import 'package:flutter_app/services/database.dart';
import 'package:provider/provider.dart';

class EditInfo extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    TextEditingController _namecontroller = new TextEditingController();
    TextEditingController _contactcontroller = new TextEditingController();
    TextEditingController _locationcontroller = new TextEditingController();
    final user = Provider.of<Userr>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Edit Info"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(" Name"),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _namecontroller ,
                  autofocus: true,
                ),
              ),
              Text(" Contact number"),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _contactcontroller ,
                  autofocus: true,
                ),
              ),
              Text("Location"),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: _locationcontroller ,
                  autofocus: true,
                ),
              ),
              //dateinput
              ElevatedButton(
                child: Text("Update"),
                onPressed: () async {
                  DatabaseService(uid :user.uid).updateUserData(_namecontroller.text,_contactcontroller.text, _locationcontroller.text);
                  Navigator.pop(context);

                },

              )
            ],
          ),
        )

    );
  }
}
