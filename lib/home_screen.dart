import 'dart:async';

import 'package:fetch_data_api/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fetch_data_api/movie_api.dart';

import 'tvshow.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

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
    FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      print(auth.currentUser!.email);
    }

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
                height: 500,
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
              SizedBox(
                height: 10,
              ),
              Center(
                // height: 50,
                // padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: ElevatedButton(
                  style: raisedButtonStyle,
                  child: const Text("Log Out"),
                  onPressed: () async {
                    _signOut().then(
                      (value) => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.grey[200],
    primary: Colors.blue[400],
    minimumSize: const Size(100.0, 36.0),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.zero),
    ),
  );
}
