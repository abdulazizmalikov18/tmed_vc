import 'package:flutter/widgets.dart';
import 'package:tmed_vc/constants/colors.dart';

class HLSIndicator extends StatefulWidget {
  final String hlsState;
  final bool isButton;
  const HLSIndicator({super.key, required this.hlsState, required this.isButton});

  @override
  State<HLSIndicator> createState() => _HLSIndicatorState();
}

class _HLSIndicatorState extends State<HLSIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        value: widget.hlsState == "HLS_STARTED" ||
                widget.hlsState == "HLS_PLAYABLE"
            ? 1
            : 0,
        duration: const Duration(seconds: 1));
    if (widget.hlsState == "HLS_STARTING" ||
        widget.hlsState == "HLS_STOPPING") {
      _animationController.repeat(reverse: true);
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HLSIndicator oldWidget) {
    if (widget.hlsState == "HLS_STARTED" ||
        widget.hlsState == "HLS_PLAYABLE" ||
        widget.hlsState == "HLS_STOPPED") {
      _animationController.stop();
      _animationController.forward();
    } else {
      _animationController.repeat(reverse: true);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
        opacity: _animationController,
        child: widget.isButton
            ? Container(
                decoration: BoxDecoration(
                    border: widget.hlsState == "HLS_STOPPED"
                        ? Border.all(color: secondaryColor)
                        : null,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    color: widget.hlsState == "HLS_STOPPED" ? null : red),
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.hlsState == "HLS_STOPPED"
                      ? "Jonli efir"
                      : widget.hlsState == "HLS_STARTING"
                          ? "Jonli efir boshlanmoqda..."
                          : widget.hlsState == "HLS_STARTED" ||
                                  widget.hlsState == "HLS_PLAYABLE"
                              ? "Jonli efirni to'xtatish"
                              : "Jonli efir to'xtatilmoqda...",
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              )
            : Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    color: red),
                padding: const EdgeInsets.all(8),
                child: const Text("Jonli Efir")));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
