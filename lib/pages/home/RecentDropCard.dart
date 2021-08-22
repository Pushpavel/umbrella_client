import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:umbrella_client/data/models/UmbrellaRequest.dart';
import 'package:umbrella_client/data/providers/root.dart';
import 'package:umbrella_client/helpers/extensions/providerExtensions.dart';
import 'package:umbrella_client/resources/icons/AppIcons.dart';
import 'package:umbrella_client/pages/home/LocationStepUI.dart';

class RecentDropCard extends StatelessWidget {
  final UmbrellaRequest? recentRequest;

  const RecentDropCard({Key? key, required this.recentRequest}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final pickUpStand = ref.watch(standProvider(recentRequest!.pickup.standId)).asResult().getOrNull();
        final dropStand = ref.watch(standProvider(recentRequest!.drop!.standId)).asResult().getOrNull();

        if (pickUpStand == null || dropStand == null)
          return Center(
            child: CircularProgressIndicator(),
          );

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
                            child: SvgPicture.asset(
                              AppIcons.StepperIcon,
                              height: 24,
                              width: 18,
                              color: Colors.white,
                            ),
                          )),
                      Column(
                        children: [
                          LocationStep(pickUpStand.name, recentRequest?.pickup.time?.millisecondsSinceEpoch),
                          SizedBox(height: 19),
                          LocationStep(dropStand.name, recentRequest?.drop?.time.millisecondsSinceEpoch),
                        ],
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
