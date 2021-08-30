import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:move/app/models/EventResponse.dart';
import 'package:url_launcher/url_launcher.dart';

class MoveCardDetail extends StatefulWidget {
  final EventResponse eventData;
  final int index;

  const MoveCardDetail(
      {Key key, @required this.eventData, @required this.index})
      : super(key: key);
  @override
  _MoveCardDetailState createState() => _MoveCardDetailState();
}

class _MoveCardDetailState extends State<MoveCardDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000619),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xff000619),
        centerTitle: true,
        title: Column(
          children: [
            Text(
              widget.eventData.events[widget.index].title,
              style: TextStyle(
                fontFamily: 'Nunito Sans',
                fontSize: 17,
                color: const Color(0xffffffff),
                fontWeight: FontWeight.w900,
              ),
              textAlign: TextAlign.left,
            ),
            Text(
              widget.eventData.events[widget.index].city,
              style: TextStyle(
                fontFamily: 'Nunito Sans',
                fontSize: 10,
                color: const Color(0x80ffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ],
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: widget.eventData.events[widget.index].photo,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                const Color(0xff000619).withOpacity(0.2),
                                BlendMode.colorBurn)),
                      ),
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(top: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.eventData.events[widget.index].place,
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: 12,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "+" +
                            widget.eventData.events[widget.index].friends
                                .toString() +
                            ' Arkadaş',
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: 12,
                          color: const Color(0x80ffffff),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.eventData.events[widget.index].date,
                      style: TextStyle(
                        fontFamily: 'Nunito Sans',
                        fontSize: 10,
                        color: const Color(0x80ffffff),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              widget.eventData.events[widget.index].description,
              style: TextStyle(
                fontFamily: 'Nunito Sans',
                fontSize: 10,
                color: const Color(0xffffffff),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 20)
                .copyWith(bottom: 0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color(0xffdb3022),
              ),
              child: GestureDetector(
                onTap: () async {
                  await canLaunch(
                          widget.eventData.events[widget.index].location)
                      ? await launch(
                          widget.eventData.events[widget.index].location)
                      : throw 'Harita konumu açılamıyor.';
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        Icons.map,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        'HARİTA',
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                          fontSize: 12,
                          color: const Color(0xffffffff),
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
