import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fetch_data_api/movie_api.dart';

import 'tvshow.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TvShows>? tvShows;

  // bool _isLoading= true;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    tvShows = await fetchdata();
    setState(() {
      // _isLoading=true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Container(
          color: Colors.orange,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                height: 600,
                child: FutureBuilder(
                  future: fetchdata(),
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      return ListView.builder(
                        itemCount: tvShows!.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            width: MediaQuery.of(context).size.width,
                            height: 180,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.6),
                                  offset: Offset(
                                    0.0,
                                    10.0,
                                  ),
                                  blurRadius: 10.0,
                                  spreadRadius: -6.0,
                                ),
                              ],
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.35),
                                  BlendMode.dstATop,
                                ),
                                image: NetworkImage(
                                    '${tvShows![index].imageThumbnailPath}'),
                                fit: BoxFit.fill,
                                alignment: Alignment.centerLeft,
                              ),
                            ),
                            child: Stack(
                              children: [
                                Align(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 5.0,
                                    ),
                                    child: Text(
                                      '${tvShows![index].name}',
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapShot.hasError) {
                      return const Text('Failed');
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
