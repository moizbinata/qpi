import 'dart:convert';

import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qpi/components/components.dart';
import 'package:qpi/splash/views/home.dart';
import 'package:qpi/utils/constants.dart';
import 'package:qpi/utils/size_config.dart';

class History extends StatefulWidget {
  const History({Key key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  int count = 1;
  int _itemCount = 0;
  GetStorage box = GetStorage();
  StreamController _postsController;
  Future fetchPost() async {
    final response = await http.get(Uri.parse(
        "http://www.qpifoods.com/mystore/jatpat_get_custorders.php?mobile=${box.read('mobile')}"));
    print("response" + response.body.toString());
    if (response.statusCode == 200) {
      print(response);
      print("length:" + response.contentLength.toString());
      setState(() {
        _itemCount = response.contentLength;
      });
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load post');
    }
  }

  loadPosts() async {
    fetchPost().then((res) async {
      _postsController.add(res);
      return res;
    });
  }

  showSnack() {
    return scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text('New content loaded'),
      ),
    );
  }

  Future<Null> _handleRefresh() async {
    count++;
    print(count);
    fetchPost().then((res) async {
      _postsController.add(res);
      showSnack();
      return null;
    });
  }

  @override
  void initState() {
    _postsController = new StreamController();
    loadPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leading: SizedBox(),
            title: Center(
              child: regularText(
                  "Order History", 2.2, Constants.darkBlue, FontWeight.bold, 1),
            )),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: regularText("Orders: " + _itemCount.toString() ?? 0,
                      1.9, Constants.grey, FontWeight.bold, 2),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: _postsController.stream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    print('Has error: ${snapshot.hasError}');
                    print('Has data: ${snapshot.hasData}');
                    print('Snapshot Data ${snapshot.data}');

                    if (snapshot.hasError) {
                      return regularText("Something went wrong", 2.0,
                          Constants.grey, FontWeight.bold, 1);
                    }

                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          Expanded(
                            child: Scrollbar(
                              child: RefreshIndicator(
                                onRefresh: _handleRefresh,
                                child: ListView.builder(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    var post = snapshot.data[index];

                                    return Container(
                                      margin: EdgeInsets.all(
                                          SizeConfig.heightMultiplier),
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(
                                              1.0,
                                              1.0,
                                            ),
                                            blurRadius: 7.0,
                                            spreadRadius: 2.0,
                                          ),
                                        ],
                                      ),
                                      child: ListTile(
                                        leading: Image.asset(
                                          'assets/img/rupeeicon.png',
                                          width:
                                              SizeConfig.heightMultiplier * 8,
                                          height:
                                              SizeConfig.heightMultiplier * 8,
                                        ),
                                        title: regularText(
                                          post['bstatus'].toString(),
                                          2.0,
                                          Colors.black,
                                          FontWeight.normal,
                                          0,
                                        ),
                                        subtitle: regularText(
                                          "Order Date: " +
                                              post['orderdate'].toString() +
                                              "\n" +
                                              "Order ID: " +
                                              post['id'].toString(),
                                          2.0,
                                          Colors.black,
                                          FontWeight.normal,
                                          0,
                                        ),
                                        trailing: regularText(
                                            "₹\n" + post['price'].toString(),
                                            1.9,
                                            Constants.grey,
                                            FontWeight.bold,
                                            0),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }

                    if (snapshot.connectionState != ConnectionState.done) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (!snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return regularText("No History Available", 2.0,
                          Constants.grey, FontWeight.bold, 1);
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
