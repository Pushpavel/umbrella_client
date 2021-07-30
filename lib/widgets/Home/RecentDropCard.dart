import 'package:flutter/material.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/widgets/Home/LocationStepUI.dart';

class RecentDropCard extends StatelessWidget {
  final UmbrellaRequest? recentRequest;

  const RecentDropCard({Key? key, required this.recentRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Card(
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 16),
                    child: CircleAvatar(
                      child: Icon(
                        Icons.arrow_downward,
                        color: Color.fromRGBO(4, 255, 195, 1),
                      ),
                      backgroundColor: Color.fromRGBO(85, 85, 85, 1),
                    ),
                  ),
                  Flexible(
                    child: Text(
                      "You have successfully dropped the Umbrella",
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Stack(
                children: [
                  Positioned(
                      left: 0,
                      top: 27.5,
                      child: Container(
                        height: 24,
                        width: 18,
                        color: Colors.white,
                      )),
                  Column(
                    children: [
                      LocationStep("Boys Hostel", "30 mins ago"),
                      SizedBox(height: 19),
                      LocationStep("Girls Hostel", "30 mins ago")
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
