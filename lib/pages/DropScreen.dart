import 'package:flutter/material.dart';
import 'package:umbrella_client/models/UmbrellaRequest.dart';
import 'package:umbrella_client/widgets/OwnedUmbrellaCard.dart';

class DropScreen extends StatelessWidget {
  final Stream<UmbrellaRequest> requestStream;
  DropScreen({required this.requestStream});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<String?>(
        stream: requestStream
            .map<String>((request) => request.umbrellaId!)
            .distinct(),
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (snapshot.data == null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [CircularProgressIndicator()],
                )
              else ...[
                OwnedUmbrellaCard(
                  umbrellaId: snapshot.data!,
                )
              ],
              // SelectedStandCard(),
            ],
          );
        },
      ),
    );
  }
}
