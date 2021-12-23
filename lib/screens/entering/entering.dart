import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Entering extends StatelessWidget {

  final Stream<QuerySnapshot> user =
  FirebaseFirestore.instance.collection("entering").snapshots();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ENTERING"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              padding: EdgeInsets.symmetric(vertical: 20),
              child: StreamBuilder<QuerySnapshot>(
                  stream: user,

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

                            Text("Punch in Date : ${data.docs[index]["date"]}"),

                            Text("Punch in Time: ${data.docs[index]["time"]}"),
                            // Text( "Punch out Date: ${data.docs[index]["dated"]}"),
                            // Text( "Punch out Time: ${data.docs[index]["timing"]}"),
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
