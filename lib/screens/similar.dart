import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

bool isSearched = false;

class SimilarStocks extends StatefulWidget {
  SimilarStocks({Key? key}) : super(key: key);

  @override
  State<SimilarStocks> createState() => _SimilarStocksState();
}

class _SimilarStocksState extends State<SimilarStocks> {
  final TextEditingController search = TextEditingController();

  @override
  void initState() {
    setState(() {
      isSearched = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff10151E),
        appBar: AppBar(
            title: Text("Similar Stocks"), backgroundColor: Color(0xff10151E)),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 300,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xff363333),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 20,
                          child: TextFormField(
                            controller: search,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search...",
                              hintStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200),
                              contentPadding: EdgeInsets.all(8),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0xff635652),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8))),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                isSearched = true;
                              });
                            },
                            icon: Icon(Icons.search,
                                color: Colors.white, size: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                isSearched
                    ? Container(
                        height: 300,
                        width: 370,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Stocks')
                                .where('ticker', isEqualTo: search.text.trim())
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const CircularProgressIndicator();
                              }

                              final userSnapshot = snapshot.data?.docs;
                              if (userSnapshot!.isEmpty) {
                                return const Text("no data");
                              }
                              return ListView.builder(
                                  itemCount: userSnapshot.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 70,
                                        width: 270,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color(0xff1D2235),
                                        ),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: CircleAvatar(
                                                    radius: 30,
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: Text(
                                                        userSnapshot[index]
                                                                    ["similar"]
                                                                [0][0] +
                                                            userSnapshot[index]
                                                                    ["similar"]
                                                                [0][1],
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600))),
                                              ),
                                              SizedBox(
                                                  width: 140,
                                                  child: Text(
                                                      userSnapshot[index]
                                                          ["similar"][index],
                                                      style: TextStyle(
                                                          color: Colors
                                                                  .orangeAccent[
                                                              700]))),
                                              SizedBox(
                                                  width: 120,
                                                  child: Center(
                                                    child: Text(
                                                        userSnapshot[index]
                                                            ["ticker"],
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  )),
                                            ]),
                                      ),
                                    );
                                  });
                            }),
                      )
                    : SizedBox(
                        height: 470,
                        width: 250,
                        child: Column(
                          children: [
                            SizedBox(height: 100),
                            Image.asset(
                              "assets/images/searching.png",
                            ),
                            SizedBox(height: 50),
                            Text(
                                "Enter the stock's ticker in the search bar to find the most correlated stock",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18))
                          ],
                        )),
              ],
            ),
          ),
        ));
  }
}
