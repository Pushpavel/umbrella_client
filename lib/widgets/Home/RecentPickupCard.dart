import 'package:flutter/material.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/widgets/Home/LocationStepUI.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RecentPickupCard extends StatelessWidget {
  final UmbrellaRequest? recentRequest;
  const RecentPickupCard({Key? key, required this.recentRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final stands = ref.watch(recentStandsProvider).asResult().getOrNull();
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
                            Icons.arrow_upward,
                            color: Color.fromRGBO(4, 255, 195, 1),
                          ),
                          backgroundColor: Color.fromRGBO(85, 85, 85, 1),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          "You have successfully picked up the Umbrella",
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  LocationStep(stands!.firstWhere((element) => element.id == recentRequest!.pickupStandId).name,
                      recentRequest?.pickupTime)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
