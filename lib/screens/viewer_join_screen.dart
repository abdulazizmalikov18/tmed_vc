import 'package:flutter/material.dart';
import 'package:videosdk/videosdk.dart';
import 'package:tmed_vc/screens/ils_screen.dart';
import 'package:tmed_vc/utils/api.dart';

import '../constants/colors.dart';
import '../utils/spacer.dart';
import '../utils/toast.dart';

// Join Screen
class ViewerJoinScreen extends StatefulWidget {
  const ViewerJoinScreen({super.key, required this.id});

  final String id;

  @override
  State<ViewerJoinScreen> createState() => _ViewerJoinScreenState();
}

class _ViewerJoinScreenState extends State<ViewerJoinScreen> {
  String _token = "";
  TextEditingController meetingIdTextController = TextEditingController();
  TextEditingController nameTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    meetingIdTextController.text = widget.id;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final token = await fetchToken(context);
      setState(() {
        _token = token;
      });
    });
  }

  @override
  setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        title: const Text(
          "Kuzatuvchi sifatida qo'shilish",
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: black750),
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          controller: nameTextController,
                          decoration: const InputDecoration(
                              hintText: "Ismingizni kiriting",
                              hintStyle: TextStyle(
                                color: textGray,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                      const VerticalSpacer(16),
                      Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: black750),
                        child: TextField(
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                          controller: meetingIdTextController,
                          decoration: const InputDecoration(
                              hintText: "Kodni kiriting",
                              hintStyle: TextStyle(
                                color: textGray,
                              ),
                              border: InputBorder.none),
                        ),
                      ),
                      const VerticalSpacer(16),
                      MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        color: purple,
                        child: const Text("Qo'shilish", style: TextStyle(fontSize: 16)),
                        onPressed: () {
                          joinMeeting();
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> joinMeeting() async {
    if (meetingIdTextController.text.isEmpty) {
      showSnackBarMessage(message: "Iltimos kodni to'g'ri kiriting", context: context);
      return;
    }

    if (nameTextController.text.isEmpty) {
      showSnackBarMessage(message: "Iltimos Ismingizni kiriting", context: context);
      return;
    }
    String meetingId = meetingIdTextController.text;
    String name = nameTextController.text;
    if (context.mounted) {
      if (true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ILSScreen(
              token: _token,
              meetingId: meetingId,
              displayName: name,
              micEnabled: false,
              camEnabled: false,
              mode: Mode.VIEWER,
            ),
          ),
        );
      } else {
        showSnackBarMessage(message: "Noto'g'ri Meeting ID", context: context);
      }
    }

    // validateMeeting(_token, meetingId).then((validMeeting) {
    //   print("====>>>> $validMeeting");
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
