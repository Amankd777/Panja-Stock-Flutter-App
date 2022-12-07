import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panja/screens/prediction.dart';

class DisplayPred extends StatefulWidget {
  DisplayPred({Key? key}) : super(key: key);

  @override
  State<DisplayPred> createState() => _DisplayPredState();
}

class _DisplayPredState extends State<DisplayPred> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff10151E),
        appBar:
            AppBar(title: Text(predname), backgroundColor: Color(0xff10151E)),
        body: getPics());
  }
}

getPics() {
  return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('Stocks')
          .where("ticker", isEqualTo: predval)
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        final userSnapshot = snapshot.data?.docs;
        if (userSnapshot!.isEmpty) {
          return const Text("no data");
        }
        return ListView.builder(
            itemCount: userSnapshot.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Container(
                      width: 400,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff1D2235)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text("Actual values",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 166, 0),
                                    fontSize: 17)),
                            SizedBox(height: 5),
                            Image.network(userSnapshot[index]["actualUrl"]),
                          ],
                        ),
                      )),
                  SizedBox(height: 10),
                  Container(
                      width: 400,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff1D2235)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text("Predicted values",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 217, 168, 255),
                                    fontSize: 17)),
                            SizedBox(height: 5),
                            Image.network(userSnapshot[index]["predictedUrl"]),
                          ],
                        ),
                      )),
                  SizedBox(height: 10),
                  Container(
                      width: 400,
                      height: 300,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0xff1D2235)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            Text("Predicted values of next month",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 120, 228, 255),
                                    fontSize: 17)),
                            SizedBox(height: 5),
                            Image.network(
                                userSnapshot[index]["predictedZoomUrl"]),
                          ],
                        ),
                      )),
                ],
              );
            });
      });
}
