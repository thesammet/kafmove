import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:move/app/components/move_card_component.dart';
import 'package:move/app/models/EventResponse.dart';
import 'package:move/app/models/ProfileDetailResponse.dart';
import 'package:http/http.dart' as http;
import 'package:move/app/services/shared_config.dart';
import 'package:platform_device_id/platform_device_id.dart';

class Profile extends StatefulWidget {
  final ProfileResponse profResponse;

  const Profile({Key key, @required this.profResponse}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    _futureEvents = events();
  }

  var eventResponse;
  Future<EventResponse> events() async {
    final response = await http.post(
      Uri.parse('https://movetech.app/api/user/favorite_events'),
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

  Future<EventResponse> _futureEvents;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff000619),
        child: Column(
          children: <Widget>[
            // construct the profile details widget here
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/loginbg.png"),
                      fit: BoxFit.cover)),
              child: Container(
                width: double.infinity,
                height: 150,
                child: Container(
                  alignment: Alignment(0.0, 2.5),
                  child: CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.profResponse.user.profilePhoto),
                    radius: 60.0,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),

            Divider(
              color: Colors.white.withOpacity(0.1),
            ),
            Text(
              "${widget.profResponse.user.firstName}" +
                  " " +
                  "${widget.profResponse.user.lastName}",
              style: TextStyle(
                fontFamily: 'Nunito Sans',
                fontSize: 12,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.profResponse.location.city +
                  " " +
                  widget.profResponse.location.country,
              style: TextStyle(
                fontFamily: 'Nunito Sans',
                fontSize: 12,
                color: const Color(0xffffffff),
                letterSpacing: 6,
              ),
              textAlign: TextAlign.left,
            ),
            Divider(
              color: Colors.white.withOpacity(0.1),
            ),
            FutureBuilder<EventResponse>(
              future: _futureEvents,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  print("data var");

                  if (snapshot.data.success == true) {
                    if (snapshot.data.events.length == 0) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
                      ));
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.events.length,
                          itemBuilder: (context, index) {
                            return MoveCard(
                              eventData: snapshot.data,
                              index: index,
                            );
                          });
                    }
                  } else {
                    Icon(
                      Icons.warning,
                      color: Colors.white,
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
