import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:move/app/models/EventResponse.dart';
import 'package:move/app/view/move_detail.dart';

class MoveCard extends StatefulWidget {
  final EventResponse eventData;
  final int index;

  const MoveCard({Key key, @required this.eventData, @required this.index})
      : super(key: key);

  @override
  _MoveCardState createState() => _MoveCardState();
}

class _MoveCardState extends State<MoveCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MoveCardDetail(
                    eventData: widget.eventData,
                    index: widget.index,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Column(
          children: [
            SizedBox(
              height: 300,
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
              padding: const EdgeInsets.only(top: 8.0),
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
              padding: const EdgeInsets.symmetric(vertical: 2.0),
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
    );
  }
}
