import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmed_vc/utils/spacer.dart';

class WaitingForHLS extends StatelessWidget {
  final bool isStopped;
  const WaitingForHLS({super.key, required this.isStopped});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
              isStopped ? 'assets/ic_stop.svg' : 'assets/ic_loading_hls.svg'),
          const VerticalSpacer(20),
          Text(
            isStopped
                ? "Host has stopped the live streaming"
                : "Waiting for speaker to start the live streaming",
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
