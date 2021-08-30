import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool status1 = false;
  bool status2 = false;
  bool status3 = false;
  bool status4 = false;
  bool status5 = false;
  bool status6 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xff52006A),
        centerTitle: true,
        title: Text(
          'Bildirim',
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
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
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
                    textAlign: TextAlign.left,
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
                          Text(
                            'Mesajlar',
                            style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 12,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          FlutterSwitch(
                            width: 50,
                            height: 22.5,
                            toggleSize: 20.0,
                            value: status1,
                            padding: 2.0,
                            toggleColor: const Color(0XFF0C0010),
                            activeColor: const Color(0xff390350),
                            inactiveColor: Colors.white,
                            onToggle: (val) {
                              setState(() {
                                status1 = val;
                              });
                            },
                          ),
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
                          Text(
                            'Gönderiler',
                            style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 12,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          FlutterSwitch(
                            width: 50,
                            height: 22.5,
                            toggleSize: 20.0,
                            value: status2,
                            padding: 2.0,
                            toggleColor: const Color(0XFF0C0010),
                            activeColor: const Color(0xff390350),
                            inactiveColor: Colors.white,
                            onToggle: (val) {
                              setState(() {
                                status2 = val;
                              });
                            },
                          ),
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
                          Text(
                            'Arkadaşlık İstekleri',
                            style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 12,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          FlutterSwitch(
                            width: 50,
                            height: 22.5,
                            toggleSize: 20.0,
                            value: status3,
                            padding: 2.0,
                            toggleColor: const Color(0XFF0C0010),
                            activeColor: const Color(0xff390350),
                            inactiveColor: Colors.white,
                            onToggle: (val) {
                              setState(() {
                                status3 = val;
                              });
                            },
                          ),
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
                          Text(
                            'Arkadaşının Aktiviteleri',
                            style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 12,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          FlutterSwitch(
                            width: 50,
                            height: 22.5,
                            toggleSize: 20.0,
                            value: status4,
                            padding: 2.0,
                            toggleColor: const Color(0XFF0C0010),
                            activeColor: const Color(0xff390350),
                            inactiveColor: Colors.white,
                            onToggle: (val) {
                              setState(() {
                                status4 = val;
                              });
                            },
                          ),
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
                          Text(
                            'Mekan Aktiviteleri',
                            style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 12,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          FlutterSwitch(
                            width: 50,
                            height: 22.5,
                            toggleSize: 20.0,
                            value: status5,
                            padding: 2.0,
                            toggleColor: const Color(0XFF0C0010),
                            activeColor: const Color(0xff390350),
                            inactiveColor: Colors.white,
                            onToggle: (val) {
                              setState(() {
                                status5 = val;
                              });
                            },
                          ),
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
                          Text(
                            'Yakındaki Etkinlikler',
                            style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 12,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          FlutterSwitch(
                            width: 50,
                            height: 22.5,
                            toggleSize: 20.0,
                            value: status6,
                            padding: 2.0,
                            toggleColor: const Color(0XFF0C0010),
                            activeColor: const Color(0xff390350),
                            inactiveColor: Colors.white,
                            onToggle: (val) {
                              setState(() {
                                status6 = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
