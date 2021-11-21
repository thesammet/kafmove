import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:move/app/models/SearchResponse.dart';
import 'package:http/http.dart' as http;
import 'package:move/app/models/SearchResponseTwo.dart';
import 'package:move/app/services/shared_config.dart';
import 'package:platform_device_id/platform_device_id.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  String _deviceId;

  Future<void> initPlatformState() async {
    String deviceId;

    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get deviceId.';
    }

    if (!mounted) return;

    setState(() {
      _deviceId = deviceId;
      print("deviceId->$_deviceId");
    });
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<SearchResponseTwo> _futureEventsLocation2;
  var eventResponse2;
  Future<SearchResponseTwo> search2(
      String url, String searchQuery, String type) async {
    final response = await http.post(Uri.parse(url), headers: {
      "Authorization":
          "z8Aq9GkZap3rFytZXlvAIsfIfFkyiUadltS5KD9IijQ36Xtk11iEPNl2lA9n",
      "X-Token": StorageUtil.getString("token"),
      "Device": _deviceId
    }, body: {
      "search_query": searchQuery == null ? "a" : searchQuery,
      "type": type
    });

    if (response.statusCode == 200) {
      print("içeride");
      print(response.body);
      setState(() {
        eventResponse2 = SearchResponseTwo.fromJson(jsonDecode(response.body));
      });

      return SearchResponseTwo.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      setState(() {
        eventResponse2 = SearchResponseTwo.fromJson(jsonDecode(response.body));
      });

      print("400 dönüyor kullanıcı not ok.");
      print(response.body);
      return SearchResponseTwo.fromJson(jsonDecode(response.body));
    } else {
      print("hattaa");
    }
  }

  Future<SearchResponse> _futureEventsLocation;
  var eventResponse;
  Future<SearchResponse> search(
      String url, String searchQuery, String type) async {
    final response = await http.post(Uri.parse(url), headers: {
      "Authorization":
          "z8Aq9GkZap3rFytZXlvAIsfIfFkyiUadltS5KD9IijQ36Xtk11iEPNl2lA9n",
      "X-Token": StorageUtil.getString("token"),
      "Device": _deviceId
    }, body: {
      "search_query": searchQuery == null ? "a" : searchQuery,
      "type": type
    });

    if (response.statusCode == 200) {
      print("içeride");
      print(response.body);
      setState(() {
        eventResponse = SearchResponse.fromJson(jsonDecode(response.body));
      });

      return SearchResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      setState(() {
        eventResponse = SearchResponse.fromJson(jsonDecode(response.body));
      });

      print("400 dönüyor kullanıcı not ok.");
      print(response.body);
      return SearchResponse.fromJson(jsonDecode(response.body));
    } else {
      print("hattaa");
    }
  }

  Future<SearchResponse> _futureFriendAdd;
  var friendAddResponse;
  Future<SearchResponse> addFriend(String url, int friendId) async {
    final response = await http.post(Uri.parse(url), headers: {
      "Authorization":
          "z8Aq9GkZap3rFytZXlvAIsfIfFkyiUadltS5KD9IijQ36Xtk11iEPNl2lA9n",
      "X-Token": StorageUtil.getString("token"),
      "Device": _deviceId
    }, body: {
      "friend_id": friendId.toString()
    });

    if (response.statusCode == 200) {
      print("içeride");
      print(response.body);
      setState(() {
        eventResponse = SearchResponse.fromJson(jsonDecode(response.body));
      });

      return SearchResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      setState(() {
        eventResponse = SearchResponse.fromJson(jsonDecode(response.body));
      });

      print("400 dönüyor kullanıcı not ok.");
      print(response.body);
      return SearchResponse.fromJson(jsonDecode(response.body));
    } else {
      print("hattaa");
    }
  }

  Future<SearchResponse> _futureFriendRemove;
  var friendRemoveResponse;
  Future<SearchResponse> removeFriend(String url, int friendId) async {
    final response = await http.post(Uri.parse(url), headers: {
      "Authorization":
          "z8Aq9GkZap3rFytZXlvAIsfIfFkyiUadltS5KD9IijQ36Xtk11iEPNl2lA9n",
      "X-Token": StorageUtil.getString("token"),
      "Device": _deviceId
    }, body: {
      "friend_id": friendId.toString()
    });

    if (response.statusCode == 200) {
      print("içeride");
      print(response.body);
      setState(() {
        eventResponse = SearchResponse.fromJson(jsonDecode(response.body));
      });

      return SearchResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      setState(() {
        eventResponse = SearchResponse.fromJson(jsonDecode(response.body));
      });

      print("400 dönüyor kullanıcı not ok.");
      print(response.body);
      return SearchResponse.fromJson(jsonDecode(response.body));
    } else {
      print("hattaa");
    }
  }

  int i = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xff52006A),
        centerTitle: true,
        title: Text(
          'Arama',
          style: TextStyle(
            fontFamily: 'Nunito Sans',
            fontSize: 14,
            color: const Color(0xffffffff),
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.left,
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
      ),
      backgroundColor: const Color(0XFF52006A),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0)
                        .copyWith(bottom: 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          i = 1;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(7.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Arkadaş"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          i = 2;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white54,
                            borderRadius: BorderRadius.circular(7.0)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Mekan"),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 10.0),
                child: TextField(
                  controller: searchController,
                  cursorColor: Colors.white,
                  onChanged: (String pin) {
                    setState(() {
                      i == 1
                          ? _futureEventsLocation = search(
                              "https://movetech.app/api/user/search",
                              searchController.text.toString(),
                              "1")
                          : _futureEventsLocation2 = search2(
                              "https://movetech.app/api/user/search",
                              searchController.text.toString(),
                              "2");

                      if (pin == "") {
                        _futureEventsLocation = null;
                        _futureEventsLocation2 == null;
                      } else
                        print("bloc search null değil");
                    });
                  },
                  style: TextStyle(
                      fontFamily: 'OpenSans-Regular',
                      fontSize: 15,
                      color: Colors.white),
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child:
                            Icon(Icons.search, color: const Color(0xff909090)),
                      ),
                    ),
                    hintText: i == 1 ? "Arkadaş Ara" : "Mekan Ara",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    border: InputBorder.none,
                  ),
                ),
              ),
              i == 1
                  ? _futureEventsLocation == null
                      ? Text("Yeni arkadaşlar aramaya başla")
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: FutureBuilder<SearchResponse>(
                            future: _futureEventsLocation,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                print("data var");

                                if (snapshot.data.success == true) {
                                  return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          snapshot.data.users.length == null
                                              ? 0
                                              : snapshot.data.users.length,
                                      itemBuilder: (context, index) {
                                        return snapshot.data.users.length == 0
                                            ? Text("Hiç arkadaşın yok")
                                            : Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        print(
                                                            "arkadaş eklendi.");
                                                        setState(() {
                                                          if (snapshot
                                                              .data
                                                              .users[index]
                                                              .isFriend) {
                                                            _futureFriendAdd = addFriend(
                                                                "https://movetech.app/api/user/remove_friend",
                                                                int.parse(snapshot
                                                                    .data
                                                                    .users[
                                                                        index]
                                                                    .uid));
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "Arkadaş çıkarıldı.",
                                                                toastLength: Toast
                                                                    .LENGTH_LONG,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    3,
                                                                backgroundColor:
                                                                    Colors
                                                                        .yellow,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                            Future.delayed(
                                                                Duration(
                                                                    seconds:
                                                                        2));
                                                            _futureEventsLocation = search(
                                                                "https://movetech.app/api/user/search",
                                                                searchController
                                                                    .text
                                                                    .toString(),
                                                                "1");
                                                          } else {
                                                            setState(() {
                                                              _futureFriendAdd = addFriend(
                                                                  "https://movetech.app/api/user/add_friend",
                                                                  int.parse(snapshot
                                                                      .data
                                                                      .users[
                                                                          index]
                                                                      .uid));
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      "Arkadaş eklendi",
                                                                  toastLength: Toast
                                                                      .LENGTH_LONG,
                                                                  gravity:
                                                                      ToastGravity
                                                                          .BOTTOM,
                                                                  timeInSecForIosWeb:
                                                                      3,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .yellow,
                                                                  textColor:
                                                                      Colors
                                                                          .white,
                                                                  fontSize:
                                                                      16.0);
                                                              Future.delayed(
                                                                  Duration(
                                                                      seconds:
                                                                          2));
                                                              _futureEventsLocation2 = search2(
                                                                  "https://movetech.app/api/user/search",
                                                                  searchController
                                                                      .text
                                                                      .toString(),
                                                                  "2");
                                                              _futureEventsLocation = search(
                                                                  "https://movetech.app/api/user/search",
                                                                  searchController
                                                                      .text
                                                                      .toString(),
                                                                  "1");
                                                            });
                                                          }
                                                        });
                                                      },
                                                      child: Icon(
                                                        snapshot
                                                                .data
                                                                .users[index]
                                                                .isFriend
                                                            ? Icons.remove
                                                            : Icons.add,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    CircleAvatar(
                                                      backgroundImage: NetworkImage(
                                                          "https://movetech.app" +
                                                              snapshot
                                                                  .data
                                                                  .users[index]
                                                                  .profilePhoto),
                                                    ),
                                                    SizedBox(
                                                      width: 10,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            "${snapshot.data.users[index].name}" +
                                                                " " +
                                                                "${snapshot.data.users[index].surname}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Nunito Sans',
                                                              fontSize: 16,
                                                              color: const Color(
                                                                  0xffffffff),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        Align(
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            snapshot
                                                                .data
                                                                .users[index]
                                                                .username,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white60),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                      });
                                } else {
                                  Icon(Icons.warning);
                                }
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }

                              return const CircularProgressIndicator(
                                color: Colors.red,
                              );
                            },
                          ))
                  : _futureEventsLocation2 == null
                      ? Text("Yeni mekanlar aramaya başla")
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: FutureBuilder<SearchResponseTwo>(
                            future: _futureEventsLocation2,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                print("data var");

                                if (snapshot.data.success == true) {
                                  if (snapshot.data.places != null) {
                                    return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: snapshot.data.places.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Column(
                                              children: [
                                                Image.network(
                                                  "https://movetech.app" +
                                                      snapshot.data
                                                          .places[index].photo,
                                                  fit: BoxFit.cover,
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object exception,
                                                      StackTrace stackTrace) {
                                                    // Appropriate logging or analytics, e.g.
                                                    // myAnalytics.recordError(
                                                    //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                                                    //   exception,
                                                    //   stackTrace,
                                                    // );
                                                    return Container(
                                                      height: 200,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Center(
                                                            child: Icon(
                                                                Icons.warning),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                              "Resim bulunamadı :(")
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  height: 200,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "${snapshot.data.places[index].name}",
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Nunito Sans',
                                                          fontSize: 16,
                                                          color: const Color(
                                                              0xffffffff),
                                                          fontWeight:
                                                              FontWeight.w900,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        });
                                  } else
                                    return Text("Hiç mekan bulunamadı");
                                } else {
                                  Icon(Icons.warning);
                                }
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }

                              return const CircularProgressIndicator(
                                color: Colors.red,
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
}
