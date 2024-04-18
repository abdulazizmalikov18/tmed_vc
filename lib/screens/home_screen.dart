import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:tmed_vc/constants/app_route_path.dart';
import 'package:tmed_vc/constants/colors.dart';

import 'package:tmed_vc/screens/speaker_join_screen.dart';
import 'package:tmed_vc/utils/spacer.dart';
import 'package:uni_links/uni_links.dart';

bool initialUriIsHandled = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    _handleIncomingLinks();
    _handleInitialUri();
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  void _handleIncomingLinks() {
    if (!kIsWeb) {
      _sub = uriLinkStream.listen((Uri? uri) {
        if (!mounted) return;
        print('got uri: $uri');
        setState(() {});
      }, onError: (Object err) {
        if (!mounted) return;
        print('got err: $err');
        setState(() {
          if (err is FormatException) {
          } else {}
        });
      });
    }
  }

  Future<void> _handleInitialUri() async {
    if (!initialUriIsHandled) {
      initialUriIsHandled = true;
      try {
        final uri = await getInitialUri();
        if (uri == null) {
          print('no initial uri');
        } else {
          print('got initial uri: $uri');
        }
        if (!mounted) return;
      } on PlatformException {
        print('falied to get initial uri');
      } on FormatException {
        if (!mounted) return;
        print('malformed initial uri');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Spacer(),
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
                    },
                  ),
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
                    child: const Text(
                        "Jonli Konfrensiyaga qoshilish qo'shilish ",
                        style: TextStyle(fontSize: 16)),
                    onPressed: () => {
                      context.goNamed(
                        AppRoutePath.viewerJoinScreen,
                        queryParameters: {"fid": ""},
                      ),
                    },
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<String>? getCmds() {
  late final String cmd;
  var cmdSuffix = '';

  const plainPath = 'path/subpath';
  const args = 'path/portion/?uid=123&token=abc';
  const emojiArgs =
      '?arr%5b%5d=123&arr%5b%5d=abc&addr=1%20Nowhere%20Rd&addr=Rand%20City%F0%9F%98%82';

  if (kIsWeb) {
    return [
      plainPath,
      args,
      emojiArgs,
      // Cannot create malformed url, since the browser will ensure it is valid
    ];
  }

  if (Platform.isIOS) {
    cmd = '/usr/bin/xcrun simctl openurl booted';
  } else if (Platform.isAndroid) {
    cmd = '\$ANDROID_HOME/platform-tools/adb shell \'am start'
        ' -a android.intent.action.VIEW'
        ' -c android.intent.category.BROWSABLE -d';
    cmdSuffix = "'";
  } else {
    return null;
  }

  // https://orchid-forgery.glitch.me/mobile/redirect/
  return [
    '$cmd "unilinks://host/$plainPath"$cmdSuffix',
    '$cmd "unilinks://example.com/$args"$cmdSuffix',
    '$cmd "unilinks://example.com/$emojiArgs"$cmdSuffix',
    '$cmd "unilinks://@@malformed.invalid.url/path?"$cmdSuffix',
  ];
}

List<Widget> intersperse(Iterable<Widget> list, Widget item) {
  final initialValue = <Widget>[];
  return list.fold(initialValue, (all, el) {
    if (all.isNotEmpty) all.add(item);
    all.add(el);
    return all;
  });
}
