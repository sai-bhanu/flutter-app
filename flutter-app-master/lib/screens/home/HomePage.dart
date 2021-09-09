import 'package:flutter/material.dart';
import 'package:flutter_app/models/itemmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Add.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final newItem = new item('null', 0.0, null, 'null','null');
    return Scaffold(
      key: _key,
      drawer: Drawer(),
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: (){
              //Navigate
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Additem(Item: newItem)),
              );
            },
            color: Colors.black,
          )
        ],
        elevation: 0.0,
        backgroundColor: Colors.green[200],
        title: Center(
          child: Text(
              "Kissan Konnect",
              style: TextStyle(
                color: Colors.black,
              )
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            _key.currentState.openDrawer();
          },
          color: Colors.black,
        ),
        //actions: [
        //IconButton(icon: Icon(Icons.notifications_none),
        //  onPressed: () {},
        //color: Colors.black)
        //],

      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: Text(
                              "Browse categories",
                              style: TextStyle(
                                  fontSize: 15
                              )
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child: TextButton(
                            child: Text('See all'),

                            style: TextButton.styleFrom(

                                primary: Colors.black,
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                )
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  height: 100.0,
                  child:
                  ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        child: Column(
                          children: [
                            Expanded(
                              flex:5,
                              child: Icon(
                                Icons.fastfood_rounded,

                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                  "wheat"
                              ),
                            )
                          ],
                        ),
                        width: 100.0,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Expanded(
                              flex:5,
                              child: Icon(
                                Icons.fastfood_rounded,

                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                  "vegetable"
                              ),
                            )
                          ],
                        ),
                        width: 100.0,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Expanded(
                              flex:5,
                              child: Icon(
                                Icons.fastfood_rounded,

                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                  "fruits"
                              ),
                            )
                          ],
                        ),
                        width: 100.0,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Expanded(
                              flex:5,
                              child: Icon(
                                Icons.fastfood_rounded,

                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                  "poultry"
                              ),
                            )
                          ],
                        ),
                        width: 100.0,
                      ),
                      Container(
                        child: Column(
                          children: [
                            Expanded(
                              flex:5,
                              child: Icon(
                                Icons.fastfood_rounded,

                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                  "fish"
                              ),
                            )
                          ],
                        ),
                        width: 100.0,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance.collection('items').snapshots(),
                      builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return SafeArea(
                            child: Container(
                              color: Colors.white,
                            ),
                          );
                        } else {
                          return new ListView(
                              children: snapshot.data.docs
                                  .map((DocumentSnapshot document){
                                return builditemcard(context, document);
                              },
                              ).toList()
                          );
                        }
                      }
                  ),
                ),
              ]
          )
      ),
    );
  }

  Widget builditemcard (BuildContext context, DocumentSnapshot itemlist){
    return new Container(
      child: Card(
        child:
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(top:8.0, bottom: 4.0),
                  child: Row(
                    children: [
                      Text(itemlist.get('name'), style: new TextStyle(fontSize: 30.0),),
                      Spacer(),
                      //Image.network('https://www.almanac.com/sites/default/files/styles/primary_image_in_article/public/image_nodes/tomatoes_helios4eos_gettyimages-edit.jpeg?itok=4KrW14a4.jpeg'),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top:8.0, bottom:8.0),
                  child: Row(
                    children: <Widget>[
                      Text("₹${itemlist.get('price').toString()}"),
                      Spacer(),
                      Text(itemlist.get('Location')),
                    ],
                  ),
                ),

              ]
          ),
        ),

      ),
    );

  }
}