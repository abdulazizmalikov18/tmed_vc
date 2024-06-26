import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:videosdk/videosdk.dart';
import 'package:tmed_vc/constants/colors.dart';
import 'package:tmed_vc/utils/toast.dart';

class ChatWidget extends StatelessWidget {
  final bool isLocalParticipant;
  final PubSubMessage message;
  final Orientation orientation;

  const ChatWidget({super.key, required this.isLocalParticipant, required this.message, required this.orientation});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isLocalParticipant ? Alignment.centerRight : Alignment.centerLeft,
      child: GestureDetector(
        onLongPress: () {
          Clipboard.setData(ClipboardData(text: message.message));
          showSnackBarMessage(message: "Habar Bufferga nusxalandi", context: context);
        },
        child: Container(
          margin: const EdgeInsets.all(4),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: black600,
          ),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isLocalParticipant ? "Siz" : message.senderName,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: black400,
                    fontWeight: FontWeight.w500,
                    fontSize: orientation == Orientation.portrait ? 12 : 10,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  message.message,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: orientation == Orientation.portrait ? 16 : 14,
                    fontWeight: orientation == Orientation.portrait ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${message.timestamp.toLocal().hour}:${message.timestamp.toLocal().minute}",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: black400,
                      fontSize: orientation == Orientation.portrait ? 10 : 9,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
