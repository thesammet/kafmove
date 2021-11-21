import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:move/app/components/move_card_component.dart';
import 'package:move/app/models/EventResponse.dart';
import 'package:move/app/models/ProfileDetailResponse.dart';
import 'package:http/http.dart' as http;
import 'package:move/app/models/photo_response.dart';
import 'package:move/app/services/shared_config.dart';
import 'package:move/app/view/menu_dashboard_layout.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

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
    setState(() {
      _futureEvents = events();
    });
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

  var photoResponse;
  Future<EventResponse> profilephoto(String photoPath) async {
    final response = await http.post(
        Uri.parse('https://movetech.app/api/user/profile_photo'),
        headers: {
          "Authorization":
              "z8Aq9GkZap3rFytZXlvAIsfIfFkyiUadltS5KD9IijQ36Xtk11iEPNl2lA9n",
          "X-Token": StorageUtil.getString("token"),
          "Device": _deviceId
        },
        body: {
          "file": _image.path
        });

    if (response.statusCode == 200) {
      print("içeride foto ");
      print(response.body);
      SchedulerBinding.instance.addPostFrameCallback((_) {
        setState(() {
          eventResponse = EventResponse.fromJson(jsonDecode(response.body));
        });
      });

      return EventResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 400) {
      print("400 foto");
      setState(() {
        eventResponse = EventResponse.fromJson(jsonDecode(response.body));
      });

      print("400 dönüyor kullanıcı not ok. foto ");
      print(response.body);
      return EventResponse.fromJson(jsonDecode(response.body));
    } else {
      print("hatta foto");
    }
  }

  Future<PhotoResponse> uploadFile() async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(_imageFile.openRead()));
    // get file length
    var length = await _imageFile.length(); //imageFile is your image file
    Map<String, String> headers = {
      "Authorization":
          "z8Aq9GkZap3rFytZXlvAIsfIfFkyiUadltS5KD9IijQ36Xtk11iEPNl2lA9n",
      "X-Token": StorageUtil.getString("token"),
      "Device": _deviceId
    }; // ignore this headers if there is no authentication

    // string to uri
    var uri = Uri.parse("https://movetech.app/api/user/profile_photo");

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFileSign = new http.MultipartFile('file', stream, length,
        filename: basename(_imageFile.path));

    // add file to multipart
    request.files.add(multipartFileSign);

    //add headers
    request.headers.addAll(headers);
    // send
    var response = await request.send();

    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Future<PhotoResponse> _futurePhoto;

  File _image;

  File _imageFile;
  Future<void> _selectAndPickImage() async {
    _imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = _imageFile;
    });

    SchedulerBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _futurePhoto = uploadFile();
        Fluttertoast.showToast(
            msg:
                "Profil fotoğrafı değiştirildi.\nİşlenmesi biraz zaman alabilir.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.yellow,
            textColor: Colors.white,
            fontSize: 16.0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff000619),
        child: Column(
          children: <Widget>[
            // construct the profile details widget here
            Stack(
              alignment: Alignment.topLeft,
              children: [
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
                        child: GestureDetector(
                            onTap: () {
                              print("a");
                              _selectAndPickImage();
                            },
                            child: Stack(
                              alignment: Alignment.bottomRight,
                              children: [
                                CircleAvatar(
                                  backgroundImage: _image == null
                                      ? NetworkImage(
                                          widget.profResponse.user.profilePhoto)
                                      : FileImage(_image),
                                  radius: 60.0,
                                ),
                                Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            )),
                      ),
                    )),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MenuDashboardPage()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0, left: 25),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
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
            _futureEvents == null
                ? Container()
                : FutureBuilder<EventResponse>(
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
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.events.length,
                                  itemBuilder: (context, index) {
                                    return MoveCard(
                                      eventData: snapshot.data,
                                      index: index,
                                    );
                                  }),
                            );
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
