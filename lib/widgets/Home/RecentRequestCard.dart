import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/pages/pickup/PickupCard.dart';
import 'package:umbrella_client/helpers/extensions/AsyncSnapshotExtension.dart';

class RecentRequestCard extends StatefulWidget {
  final String locationId;
  final DateTime requestTimeout;
  const RecentRequestCard({Key? key, required this.locationId, required this.requestTimeout}) : super(key: key);

  @override
  _RecentRequestCardState createState() => _RecentRequestCardState();
}

class _RecentRequestCardState extends State<RecentRequestCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => print("clicked"),
      child: Consumer(
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
                            child: StreamBuilder<int?>(
                              stream: _timeoutStream(widget.requestTimeout),
                              builder: (context, snapshot) {
                                final time = snapshot.asResult().getOrNull();
                                if (time == null)
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                return Text(
                                  time.toString(),
                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
                                );
                              },
                            ),
                            backgroundColor: Color.fromRGBO(85, 85, 85, 1),
                          ),
                        ),
                        Flexible(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Pickup the Umbrella",
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
      ),
    );
  }

  Stream<int?> _timeoutStream(DateTime start) async* {
    Duration time = DateTime.now().difference(start);
    while (time.inSeconds <= TIMEOUT_SECONDS) {
      yield TIMEOUT_SECONDS - time.inSeconds;
      await Future.delayed(Duration(seconds: 1));
      time = DateTime.now().difference(start);
    }
    yield null;
  }
}
