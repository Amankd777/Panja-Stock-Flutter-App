import 'package:cloud_firestore/cloud_firestore.dart';

class Stock {
  final String actualUrl;
  final String predictedUrl;
  final String predictedZoomUrl;
  final String ticker;
  final String name;

  const Stock({
    required this.name,
    required this.actualUrl,
    required this.predictedUrl,
    required this.predictedZoomUrl,
    required this.ticker,
  });

  static Stock fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Stock(
      actualUrl: snapshot["actualUrl"],
      predictedUrl: snapshot["predictedUrl"],
      predictedZoomUrl: snapshot["predictedZoomUrl"],
      ticker: snapshot["ticker"],
      name: snapshot["name"],
    );
  }

  Map<String, dynamic> toJson() => {
        "actualUrl": actualUrl,
        "predictedUrl": predictedUrl,
        "predictedZoomUrl": predictedZoomUrl,
        "ticker": ticker,
        "name": name,
      };
}
