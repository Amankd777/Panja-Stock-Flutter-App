import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:iconsax/iconsax.dart';
import 'package:ionicons/ionicons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:panja/AuthMethods/login.dart';
import 'package:panja/navbar.dart';
import 'package:panja/screens/stockscreens/app.dart';
import 'package:panja/screens/stockscreens/extension.dart';
import 'package:panja/screens/stockscreens/search.dart';
import 'package:panja/screens/stockscreens/stock_card.dart';
import 'package:panja/screens/stockscreens/stock_tile.dart';
import 'package:panja/screens/stockscreens/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'company_provider.dart';
import 'endpoints.dart';
import 'error_widget.dart';
import 'loading_indicator.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin {
  static String myVideoId = 't_aO4EMP-i0';
  static String myVideoId0 = 'p7HKvqRI_Bo';

  final YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: myVideoId0,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );
  final YoutubePlayerController _controller2 = YoutubePlayerController(
    initialVideoId: myVideoId,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );
  final YoutubePlayerController _controller3 = YoutubePlayerController(
    initialVideoId: myVideoId,
    flags: const YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );
  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<AppProvider>(
          builder: (context, notifier, child) => InkWell(
              onTap: () {
                notifier.toggleTheme();
              },
              child: notifier.dark
                  ? const Icon(Ionicons.sunny)
                  : const Icon(Ionicons.moon)),
        ),
        centerTitle: true,
        title: const Text('Stocks Panja'),
        actions: [
          IconButton(
            onPressed: () async {
              List companies = [];
              final url = Endpoints.companyURL;
              final response = await http.get(Uri.parse(url));
              final responseData = jsonDecode(response.body);
              for (var compItem in responseData["data"]) {
                companies.add(compItem);
              }
              showSearch(
                context: context,
                delegate: StockSearch(all: companies),
              );
            },
            icon: const Icon(Iconsax.search_normal),
          ).fadeInList(0, false),
          const SizedBox(width: 20.0),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Text(
                'Watchlist',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ).fadeInList(0, true),
            ),

            // SizedBox(
            //   height: 185.0,
            //   width: MediaQuery.of(context).size.width,
            //   child: FutureBuilder(
            //       future: Provider.of<CompanyProvider>(context, listen: false)
            //           .fetchAndSetCompanyItems(),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState == ConnectionState.waiting) {
            //           return loadingIndicator(context);
            //         } else if (snapshot.error == null) {
            //           return Consumer<CompanyProvider>(
            //               builder: (context, company, _) {
            //             return ListView.builder(
            //               itemCount: 3,
            //               scrollDirection: Axis.horizontal,
            //               padding: const EdgeInsets.symmetric(horizontal: 10.0),
            //               itemBuilder: (BuildContext context, int index) {
            //                 return StockCard(
            //                   index: index,
            //                   company: company.companies[index],
            //                 ).fadeInList(index, false);
            //               },
            //             );
            //           });
            //         }
            //         return MyErrorWidget(
            //           refreshCallBack: () =>
            //               Provider.of<CompanyProvider>(context, listen: false)
            //                   .fetchAndSetCompanyItems(),
            //         );
            //       }),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 250,
                width: 400,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 240,
                        width: 340,
                        child: Column(
                          children: [
                            YoutubePlayer(
                              controller: _controller,
                              liveUIColor: Colors.amber,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Beginner",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 240,
                        width: 340,
                        child: Column(
                          children: [
                            YoutubePlayer(
                              controller: _controller2,
                              liveUIColor: Colors.amber,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Beginner",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 240,
                        width: 340,
                        child: Column(
                          children: [
                            YoutubePlayer(
                              controller: _controller3,
                              liveUIColor: Colors.amber,
                            ),
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Beginner",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Text(
                'Top U.S Stocks',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ).fadeInList(1, true),
            ),
            SizedBox(
              height: 810,
              child: FutureBuilder(
                  future: Provider.of<CompanyProvider>(context, listen: false)
                      .fetchAndSetCompanyItems(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return loadingIndicator(context);
                    } else if (snapshot.error == null) {
                      return Consumer<CompanyProvider>(
                          builder: (context, company, _) {
                        return ListView.builder(
                          itemCount: 10,
                          reverse: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          itemBuilder: (BuildContext context, int index) {
                            return StockTile(
                              company: company,
                              index: index,
                            ).fadeInList(index, false);
                          },
                        );
                      });
                    }
                    return MyErrorWidget(
                      refreshCallBack: () =>
                          Provider.of<CompanyProvider>(context, listen: false)
                              .fetchAndSetCompanyItems(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
