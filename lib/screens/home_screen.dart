import 'package:flutter/material.dart';
import 'package:tmed_vc/constants/colors.dart';
import 'package:tmed_vc/screens/speaker_join_screen.dart';
import 'package:tmed_vc/screens/viewer_join_screen.dart';
import 'package:tmed_vc/utils/spacer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/tmed.png',
                height: 48,
                color: Colors.white,
              ),
              const Spacer(),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: purple,
                  child: const Text("Konferensiya yaratish",
                      style: TextStyle(fontSize: 16)),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SpeakerJoinScreen(
                                    isCreateMeeting: true)))
                      }),
              const VerticalSpacer(32),
              const Row(
                children: [
                  Expanded(
                      child: Divider(
                    thickness: 1,
                    color: black750,
                  )),
                  HorizontalSpacer(),
                  Text("OR"),
                  HorizontalSpacer(),
                  Expanded(
                      child: Divider(
                    thickness: 1,
                    color: black750,
                  )),
                ],
              ),
              const VerticalSpacer(32),
              // MaterialButton(
              //     shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12)),
              //     padding: const EdgeInsets.symmetric(vertical: 16),
              //     color: black750,
              //     child: const Text("Konferensiyaga qo'shilish ",
              //         style: TextStyle(fontSize: 16)),
              //     onPressed: () => {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => const SpeakerJoinScreen(
              //                       isCreateMeeting: false)))
              //         }),
              // const VerticalSpacer(12),
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  color: black750,
                  child: const Text("Jonli Konfrensiyaga qoshilish qo'shilish ",
                      style: TextStyle(fontSize: 16)),
                  onPressed: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewerJoinScreen()))
                      }),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
