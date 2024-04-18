// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tmed_vc/constants/colors.dart';
import 'package:tmed_vc/utils/spacer.dart';
import 'package:touch_ripple_effect/touch_ripple_effect.dart';
import 'package:video_player/video_player.dart';

class LivestreamPlayerWeb extends StatefulWidget {
  final String playbackHlsUrl;
  final Orientation orientation;
  final bool showChat;
  final bool showOverlay;
  final Function onChatButtonClicked;
  final Function onRaiseHandButtonClicked;
  final Function onPlaybackEnded;
  const LivestreamPlayerWeb({
    super.key,
    required this.playbackHlsUrl,
    required this.orientation,
    required this.showChat,
    required this.showOverlay,
    required this.onChatButtonClicked,
    required this.onRaiseHandButtonClicked,
    required this.onPlaybackEnded,
  });

  @override
  LivestreamPlayerWebState createState() => LivestreamPlayerWebState();
}

class LivestreamPlayerWebState extends State<LivestreamPlayerWeb> {
  late VideoPlayerController _controller;
  double sliderValue = 0.0;
  String position = '';
  String duration = '';
  bool validPosition = false;

  bool isHandRaised = false;

  @override
  void initState() {
    super.initState();
    try {
      print(widget.playbackHlsUrl);
      _controller = VideoPlayerController.network(widget.playbackHlsUrl)
        ..initialize().then((_) {
          setState(() {
            _controller.play();
          });
        });
      _controller.setVolume(0.5);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: Center(
    //     child: _controller.value.isInitialized
    //         ? AspectRatio(
    //             aspectRatio: _controller.value.aspectRatio,
    //             child: VideoPlayer(_controller),
    //           )
    //         : Container(),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     onPressed: () {
    //       setState(() {
    //         _controller.value.isPlaying
    //             ? _controller.pause()
    //             : _controller.play();
    //       });
    //     },
    //     child: Icon(
    //       _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //     ),
    //   ),
    // );
    return Column(
      children: [
        Flexible(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Center(
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
              if (widget.orientation == Orientation.landscape &&
                  widget.showOverlay)
                Positioned(
                    top: 4,
                    right: 6,
                    child: Row(
                      children: [
                        TouchRippleEffect(
                          borderRadius: BorderRadius.circular(10),
                          rippleColor: primaryColor,
                          onTap: () {
                            if (!isHandRaised) {
                              widget.onRaiseHandButtonClicked();
                              setState(() {
                                isHandRaised = true;
                              });

                              Timer(const Duration(seconds: 5), () {
                                setState(() {
                                  isHandRaised = false;
                                });
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: isHandRaised
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : const Color.fromRGBO(0, 0, 0, 0.3),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              "assets/ic_hand.svg",
                              color: isHandRaised ? Colors.black : Colors.white,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                        const HorizontalSpacer(8),
                        TouchRippleEffect(
                          borderRadius: BorderRadius.circular(10),
                          rippleColor: primaryColor,
                          onTap: () {
                            widget.onChatButtonClicked();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: widget.showChat
                                  ? const Color.fromRGBO(255, 255, 255, 1)
                                  : const Color.fromRGBO(0, 0, 0, 0.3),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: SvgPicture.asset(
                              "assets/ic_chat.svg",
                              color:
                                  widget.showChat ? Colors.black : Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )),
            ],
          ),
        ),
      ],
    );
  }
}
