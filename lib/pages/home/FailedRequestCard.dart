import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';

class FailedRequestCard extends StatefulWidget {
  final String locationId;

  const FailedRequestCard({Key? key, required this.locationId}) : super(key: key);

  @override
  _FailedRequestCardState createState() => _FailedRequestCardState();
}

class _FailedRequestCardState extends State<FailedRequestCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final location = ref.watch(standProvider(this.widget.locationId)).asResult().getOrNull();

        if (location == null)
          return Center(
            child: CircularProgressIndicator(),
          );

        return Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Card(
            color: Theme.of(context).accentColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 16),
                        child: CircleAvatar(
                          child: Icon(
                            Icons.close,
                            color: Color.fromRGBO(4, 255, 195, 1),
                          ),
                          backgroundColor: Color.fromRGBO(85, 85, 85, 1),
                        ),
                      ),
                      Flexible(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Failed",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.room,
                        color: Color.fromRGBO(255, 255, 255, 0.95),
                        size: 18,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        location.name,
                        style: TextStyle(
                          color: Color.fromRGBO(255, 255, 255, 0.95),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Flexible(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Color.fromRGBO(255, 255, 255, 0.6),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
