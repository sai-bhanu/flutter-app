import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/SearchService.dart';
import 'package:get/get.dart';

import 'DetailedScreen.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  QuerySnapshot snapshotData;
  bool isExecuted=false;
  @override
  Widget build(BuildContext context) {
    
    Widget searchedData(){
      return ListView.builder(
        itemCount: snapshotData.docs.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {return DetailedScreen();},
                settings: RouteSettings(arguments:snapshotData.docs[index]),
              ),
              );
            },
            child: ListTile(
              title: Text(
                snapshotData.docs[index].data()['name'],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),

              ),
              subtitle: Text(
                snapshotData.docs[index].data()['Location'],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),

              ),
            ),
          );
        },
      );
    }
    
    return Scaffold(
      floatingActionButton: FloatingActionButton(child: Icon(Icons.clear),onPressed: (){
        setState(() {
          isExecuted=false;
        });
      },),
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          GetBuilder<SearchService>(
            init: SearchService(),
            builder: (val){
              return IconButton(icon: Icon(Icons.search), onPressed: (){
                val.queryData(searchController.text).then((value){
                  snapshotData=value;
                  setState(() {
                    isExecuted=true;
                  });
                });
              });
            },
              
          )
        ],
        title: TextField(
          style: TextStyle(
            color: Colors.black
          ),
          decoration: InputDecoration(
            hintText: 'Search Items',
            hintStyle: TextStyle(color: Colors.black)
          ),
          controller: searchController,
        ),
        backgroundColor: Colors.green[100],
      ),
      body: isExecuted ? searchedData() : Container(
        child: Center(
          child: Text(
            'Search Items',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 30,
            ),
          ),
        ),
      ),
    );
  }
}
