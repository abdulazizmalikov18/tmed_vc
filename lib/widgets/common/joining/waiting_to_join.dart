import 'package:flutter/material.dart';
import 'package:tmed_vc/utils/spacer.dart';

class WaitingToJoin extends StatelessWidget {
  const WaitingToJoin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            VerticalSpacer(20),
            Text(
              "Xona yaratilmoqda...",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
