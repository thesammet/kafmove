import 'dart:convert';
import 'dart:io';
import 'package:flutter/scheduler.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:move/app/models/ProfileDetailResponse.dart';
import 'package:move/app/models/UserProfileResponse.dart';
import 'package:move/app/services/shared_config.dart';
import 'package:platform_device_id/platform_device_id.dart';

import '../menu_dashboard_layout.dart';

class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key key, this.profResponse}) : super(key: key);
  final ProfileResponse profResponse;

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController username = TextEditingController();

  String _platform;
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

  Future<void> platformState() async {
    String platform;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      if (Platform.isAndroid) {
        setState(() {
          platform = "Android";
        });
      } else if (Platform.isIOS) {
        platform = "IOS";
      }
    } on PlatformException {
      setState(() {
        platform = 'Failed to get deviceId.';
      });
    }

    setState(() {
      _platform = platform;
      print("platform->$_platform");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
    platformState();
  }

  var usernameChangeResponse;
  Future<UserSettingsResponse> spesificChange(
      String spesific, String value) async {
    final response = await http.post(
      Uri.parse('https://movetech.app/api/user/personal/update/' + spesific),
      headers: {
        "Authorization":
            "z8Aq9GkZap3rFytZXlvAIsfIfFkyiUadltS5KD9IijQ36Xtk11iEPNl2lA9n",
        "X-Token": StorageUtil.getString("token"),
        "Device": _deviceId,
      },
      body: {"$spesific": value},
    );

    if (response.statusCode == 200) {
      print("içeride");
      print(response.body);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {
          usernameChangeResponse =
              UserSettingsResponse.fromJson(jsonDecode(response.body));
        });
      });

      return UserSettingsResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {
          usernameChangeResponse =
              UserSettingsResponse.fromJson(jsonDecode(response.body));
        });
      });

      print("400 dönüyor kullanıcı not ok.");
      print(response.body);
      return UserSettingsResponse.fromJson(jsonDecode(response.body));
    } else {
      print("hattaa");
    }
  }

  Future<UserSettingsResponse> _futureEmail;
  Future<UserSettingsResponse> _futurePhone;
  Future<UserSettingsResponse> _futureUsername;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xff52006A),
        centerTitle: true,
        title: Text(
          'Profil Ayarları',
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0XFF52006A), const Color(0xFF05091A)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Bildirimlerini buradan açıp kapaya bilirsin.',
                  style: TextStyle(
                    fontFamily: 'Nunito Sans',
                    fontSize: 10,
                    color: const Color(0x80ffffff),
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 7.0,
                ),
                child: Container(
                  decoration: new BoxDecoration(
                      color: const Color(0xff000619),
                      borderRadius: new BorderRadius.all(
                        Radius.circular(7.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                backgroundImage: NetworkImage(
                                    widget.profResponse.user.profilePhoto)),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${widget.profResponse.user.firstName}" +
                                        " " +
                                        "${widget.profResponse.user.lastName}",
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
                                    widget.profResponse.user.email,
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
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 25),
                child: Text(
                  'Kişisel Bilgiler',
                  style: TextStyle(
                    fontFamily: 'Nunito Sans',
                    fontSize: 12,
                    color: const Color(0x80ffffff),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: Container(
                  decoration: new BoxDecoration(
                      color: const Color(0xff000619),
                      borderRadius: new BorderRadius.all(
                        Radius.circular(7.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: TextField(
                            controller: email,
                            cursorColor: const Color(0xff303030),
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 12,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: const Color(0xff52006A), width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff909090))),
                              hintText: "EMAIL",
                              hintStyle: TextStyle(
                                fontFamily: 'Gotham',
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _futureEmail =
                                spesificChange("email", email.text.toString());
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MenuDashboardPage()));
                            });
                          },
                          child: Text(
                            'DEĞİŞTİR',
                            style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 10,
                              color: const Color(0x80ffffff),
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: Container(
                  decoration: new BoxDecoration(
                      color: const Color(0xff000619),
                      borderRadius: new BorderRadius.all(
                        Radius.circular(7.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: TextField(
                            controller: phoneNumber,
                            cursorColor: const Color(0xff303030),
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 12,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: const Color(0xff52006A), width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff909090))),
                              hintText: "Telefon numarası",
                              hintStyle: TextStyle(
                                fontFamily: 'Gotham',
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _futureEmail = spesificChange(
                                "phone", phoneNumber.text.toString());
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MenuDashboardPage()));
                            });
                          },
                          child: Text(
                            'DEĞİŞTİR',
                            style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 10,
                              color: const Color(0x80ffffff),
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0)
                    .copyWith(bottom: 30),
                child: Container(
                  decoration: new BoxDecoration(
                      color: const Color(0xff000619),
                      borderRadius: new BorderRadius.all(
                        Radius.circular(7.0),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 2.3,
                          child: TextField(
                            controller: username,
                            cursorColor: const Color(0xff303030),
                            keyboardType: TextInputType.name,
                            style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 12,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: const Color(0xff52006A), width: 2.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff909090))),
                              hintText: "Kullanıcı Adı",
                              hintStyle: TextStyle(
                                fontFamily: 'Gotham',
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _futureEmail = spesificChange(
                                "username", username.text.toString());
                            SchedulerBinding.instance.addPostFrameCallback((_) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MenuDashboardPage()));
                            });
                          },
                          child: Text(
                            'DEĞİŞTİR',
                            style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 10,
                              color: const Color(0x80ffffff),
                              fontWeight: FontWeight.w300,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
