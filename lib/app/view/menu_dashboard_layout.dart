import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:move/app/components/move_card_component.dart';
import 'package:move/app/models/EventResponse.dart';
import 'package:move/app/models/ProfileDetailResponse.dart';
import 'package:move/app/services/shared_config.dart';
import 'package:move/app/view/authPages/login.dart';
import 'package:move/app/view/naviPages/about_us.dart';
import 'package:move/app/view/naviPages/notifications.dart';
import 'package:move/app/view/naviPages/privacy.dart';
import 'package:move/app/view/naviPages/profile_settings.dart';
import 'package:http/http.dart' as http;
import 'package:move/app/view/profile.dart';
import 'package:move/app/view/search_page.dart';
import 'package:platform_device_id/platform_device_id.dart';

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage> {
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
    print(StorageUtil.getString("token"));
    initPlatformState();
    _futureProfile = profiledetail();
    _futureProfileIcon = profiledetail();
    _futureEventsLast = events("https://movetech.app/api/user/events/last");
    _futureEventsLocation =
        events("https://movetech.app/api/user/events/location");
    _futureEventsTonight =
        events("https://movetech.app/api/user/events/tonight");
  }

  var profileResponse;
  Future<ProfileResponse> profiledetail() async {
    final response = await http.post(
      Uri.parse('https://movetech.app/api/user/details'),
      headers: {
        "Authorization":
            "z8Aq9GkZap3rFytZXlvAIsfIfFkyiUadltS5KD9IijQ36Xtk11iEPNl2lA9n",
        "Content-Type": "application/json",
        "X-Token": StorageUtil.getString("token"),
        "Device": _deviceId
      },
    );

    if (response.statusCode == 200) {
      print("içeride");
      print(response.body);
      setState(() {
        profileResponse = ProfileResponse.fromJson(jsonDecode(response.body));
      });

      return ProfileResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      setState(() {
        profileResponse = ProfileResponse.fromJson(jsonDecode(response.body));
      });

      print("400 dönüyor kullanıcı not ok.");
      print(response.body);
      return ProfileResponse.fromJson(jsonDecode(response.body));
    } else {
      print("hattaa");
    }
  }

  var eventResponse;
  Future<EventResponse> events(String url) async {
    final response = await http.post(Uri.parse(url), headers: {
      "Authorization":
          "z8Aq9GkZap3rFytZXlvAIsfIfFkyiUadltS5KD9IijQ36Xtk11iEPNl2lA9n",
      "X-Token": StorageUtil.getString("token"),
      "Device": _deviceId
    }, body: {
      "latitude": "39.925533",
      "longitude": "32.866287"
    });

    if (response.statusCode == 200) {
      print("içeride");
      print(response.body);
      setState(() {
        eventResponse = EventResponse.fromJson(jsonDecode(response.body));
      });

      return EventResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      setState(() {
        eventResponse = ProfileResponse.fromJson(jsonDecode(response.body));
      });

      print("400 dönüyor kullanıcı not ok.");
      print(response.body);
      return EventResponse.fromJson(jsonDecode(response.body));
    } else {
      print("hattaa");
    }
  }

  Future<EventResponse> _futureEventsLocation;
  Future<EventResponse> _futureEventsTonight;
  Future<EventResponse> _futureEventsLast;

  Future<ProfileResponse> _futureProfile;
  Future<ProfileResponse> _futureProfileIcon;

  bool isCollapsed = true;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff43025A),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _futureProfile == null
                      ? CircularProgressIndicator(
                          color: Colors.red,
                        )
                      : FutureBuilder<ProfileResponse>(
                          future: _futureProfile,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              print("data var");

                              if (snapshot.data.success == true) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Profile(
                                                profResponse: snapshot.data,
                                              )),
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              isCollapsed = !isCollapsed;
                                            });
                                          },
                                          icon: Icon(
                                            Icons.arrow_back_ios,
                                            color: Colors.white,
                                          )),
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            snapshot.data.user.profilePhoto),
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
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${snapshot.data.user.firstName}" +
                                                  " " +
                                                  "${snapshot.data.user.lastName}",
                                              style: TextStyle(
                                                fontFamily: 'Nunito Sans',
                                                fontSize: 16,
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w900,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "${snapshot.data.user.email}",
                                              style: TextStyle(
                                                fontFamily: 'Nunito Sans',
                                                fontSize: 14,
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w300,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                );
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
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _futureProfileIcon == null
                          ? NavItem(
                              ic: Icons.settings,
                              text: "Profil Ayarları",
                              vC: () {
                                Fluttertoast.showToast(
                                    msg: "Profil verileri yükleniyor...",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 3,
                                    backgroundColor: Colors.yellow,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              },
                            )
                          : FutureBuilder<ProfileResponse>(
                              future: _futureProfile,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  print("data var");

                                  if (snapshot.data.success == true) {
                                    return NavItem(
                                      ic: Icons.settings,
                                      text: "Profil Ayarları",
                                      vC: () {
                                        print("Profil Ayarları Tıklandı.");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProfileSettings(
                                                    profResponse: snapshot.data,
                                                  )),
                                        );
                                      },
                                    );
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
                      SizedBox(
                        height: 10,
                      ),
                      NavItem(
                        ic: Icons.search,
                        text: "Arama",
                        vC: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchPage()),
                          );
                          print("Arama Tıklandı.");
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      /*NavItem(
                        ic: Icons.privacy_tip,
                        text: "Gizlilik",
                        vC: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Privacy()),
                          );
                          print("Gizlilik Tıklandı.");
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),*/
                      /*NavItem(
                        ic: Icons.notifications,
                        text: "Bildirim",
                        vC: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Notifications()),
                          );
                          print("Bildirim Ayarları Tıklandı.");
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),*/
                      NavItem(
                        ic: Icons.settings,
                        text: "Hakkımızda",
                        vC: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AboutUs()),
                          );
                          print("Hakkımızda Tıklandı.");
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      NavItem(
                        ic: Icons.logout_outlined,
                        text: "Çıkış",
                        vC: () {
                          print("Çıkış Tıklandı.");
                          StorageUtil.putString("token", "");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: Text(
                        'Move aracı bir sosyal medya uygulamasıdır.\nEğlence işletmeleri ve organizatörler için birlikte eğitilmesi kolay ve montajı kolay bir mobil uygulamadır.hangi parti nerede? Ne zaman? Kim gidecek?tüm bu bilgiler için MOVE.',
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: 10,
                          color: const Color(0x78ffffff),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            top: isCollapsed ? 0 : 0.2 * size.height,
            bottom: isCollapsed ? 0 : 0.2 * size.width,
            left: isCollapsed ? 0 : 0.6 * size.width,
            right: isCollapsed ? 0 : -0.4 * size.width,
            child: DefaultTabController(
              length: 3,
              child: Scaffold(
                  backgroundColor: const Color(0xff000619),
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    bottom: TabBar(
                      indicatorColor: Colors.red,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        Tab(
                          text: "Yakınlarda",
                        ),
                        Tab(
                          text: "Bu Gece",
                        ),
                        Tab(
                          text: "Geçmiş",
                        ),
                      ],
                    ),
                    backgroundColor: const Color(0xff000619),
                    elevation: 0.0,
                    title: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isCollapsed = !isCollapsed;
                              });
                              print("nav menu tıklandı");
                            },
                            icon: Icon(
                              Icons.menu,
                              color: Colors.white,
                            ),
                          ),
                          _futureProfileIcon == null
                              ? Icon(
                                  Icons.person_outline,
                                  color: Colors.white.withOpacity(.2),
                                )
                              : FutureBuilder<ProfileResponse>(
                                  future: _futureProfile,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      print("data var");

                                      if (snapshot.data.success == true) {
                                        return IconButton(
                                          onPressed: () {
                                            print("profil tıklandı");

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Profile(
                                                        profResponse:
                                                            snapshot.data,
                                                      )),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.person_outline,
                                            color: Colors.white,
                                          ),
                                        );
                                      } else {
                                        Icon(Icons.warning);
                                      }
                                    } else if (snapshot.hasError) {
                                      return Text('${snapshot.error}');
                                    }

                                    return Icon(
                                      Icons.person_outline,
                                      color: Colors.white.withOpacity(.5),
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      FutureBuilder<EventResponse>(
                        future: _futureEventsLocation,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print("data var");

                            if (snapshot.data.success == true) {
                              if (snapshot.data.events.length == 0) {
                                return Container(
                                  color: const Color(0xff000619),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.no_drinks_outlined,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Hiç etkinlik bulunamadı!",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )),
                                );
                              } else {
                                return Container(
                                    width: size.width,
                                    height: size.height,
                                    color: const Color(0xff000619),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: ListView.builder(
                                          itemCount:
                                              snapshot.data.events.length,
                                          itemBuilder: (context, index) {
                                            return MoveCard(
                                              eventData: snapshot.data,
                                              index: index,
                                            );
                                          }),
                                    ));
                              }
                            } else {
                              Icon(
                                Icons.warning,
                                color: Colors.white,
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}',
                                style: TextStyle(color: Colors.white));
                          }

                          return Center(
                            child: Container(
                                width: 70,
                                height: 70,
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                )),
                          );
                        },
                      ),
                      FutureBuilder<EventResponse>(
                        future: _futureEventsTonight,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print("data var");

                            if (snapshot.data.success == true) {
                              if (snapshot.data.events.length == 0) {
                                return Container(
                                  color: const Color(0xff000619),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.no_drinks_outlined,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Hiç etkinlik bulunamadı!",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )),
                                );
                              } else {
                                return Container(
                                    width: size.width,
                                    height: size.height,
                                    color: const Color(0xff000619),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: ListView.builder(
                                          itemCount:
                                              snapshot.data.events.length,
                                          itemBuilder: (context, index) {
                                            return MoveCard(
                                              eventData: snapshot.data,
                                              index: index,
                                            );
                                          }),
                                    ));
                              }
                            } else {
                              Icon(
                                Icons.warning,
                                color: Colors.white,
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}',
                                style: TextStyle(color: Colors.white));
                          }

                          return Center(
                            child: Container(
                                width: 70,
                                height: 70,
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                )),
                          );
                        },
                      ),
                      FutureBuilder<EventResponse>(
                        future: _futureEventsLast,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            print("data var");

                            if (snapshot.data.success == true) {
                              if (snapshot.data.events.length == 0) {
                                return Container(
                                  color: const Color(0xff000619),
                                  child: Center(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 40),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.no_drinks_outlined,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          "Hiç etkinlik bulunamadı!",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  )),
                                );
                              } else {
                                return Container(
                                    width: size.width,
                                    height: size.height,
                                    color: const Color(0xff000619),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: ListView.builder(
                                          itemCount:
                                              snapshot.data.events.length,
                                          itemBuilder: (context, index) {
                                            return MoveCard(
                                              eventData: snapshot.data,
                                              index: index,
                                            );
                                          }),
                                    ));
                              }
                            } else {
                              Icon(
                                Icons.warning,
                                color: Colors.white,
                              );
                            }
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}',
                                style: TextStyle(color: Colors.white));
                          }

                          return Center(
                            child: Container(
                                width: 70,
                                height: 70,
                                child: CircularProgressIndicator(
                                  color: Colors.red,
                                )),
                          );
                        },
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  final IconData ic;
  final String text;
  final VoidCallback vC;

  const NavItem(
      {Key key, @required this.ic, @required this.text, @required this.vC})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5.0),
      child: GestureDetector(
        onTap: vC,
        child: Row(
          children: [
            Icon(
              ic,
              color: Colors.white,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              text,
              style: TextStyle(
                fontFamily: 'Nunito Sans',
                fontSize: 11,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
