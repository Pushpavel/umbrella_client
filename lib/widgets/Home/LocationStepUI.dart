import 'package:flutter/material.dart';

class LocationStep extends StatelessWidget {
  final String location, time;
  const LocationStep(this.location, this.time, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.room,
          color: Color.fromRGBO(255, 255, 255, 0.95),
          size: 18,
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              location,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.95),
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              time,
              style: TextStyle(
                color: Color.fromRGBO(255, 255, 255, 0.6),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        )
      ],
    );
  }
}
