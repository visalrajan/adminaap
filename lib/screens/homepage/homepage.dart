

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {


  final Stream<QuerySnapshot> users =
  FirebaseFirestore.instance.collection("request").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin App"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 500,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: StreamBuilder<QuerySnapshot>(
                  stream: users,
                  builder: (
                      BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot,
                      ) {
                    if(snapshot.hasError){
                      return Text("Something wrong");
                    }
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    final data = snapshot.requireData;

                    return ListView.builder(

                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        return Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),

                            Text("Date : ${data.docs[index]["date"].toString()}"),

                        Text("Day Type: ${data.docs[index]["day"].toString()}"),
                        Text( "Leave Type: ${data.docs[index]["leave"].toString()}"),
                            Text( "Reason: ${data.docs[index]["reason"].toString()}"),
                          ],

                        );

                      },

                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
