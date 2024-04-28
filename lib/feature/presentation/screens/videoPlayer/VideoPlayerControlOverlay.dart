import 'package:flutter/material.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
import 'package:flutter_svg/svg.dart';
import 'package:video_player/video_player.dart';

class ControlsOverlay extends StatefulWidget {
  const ControlsOverlay({required this.controller});

  static const List<Duration> _exampleCaptionOffsets = <Duration>[
    Duration(seconds: -10),
    Duration(seconds: -3),
    Duration(seconds: -1, milliseconds: -500),
    Duration(milliseconds: -250),
    Duration.zero,
    Duration(milliseconds: 250),
    Duration(seconds: 1, milliseconds: 500),
    Duration(seconds: 3),
    Duration(seconds: 10),
  ];
  static const List<double> _examplePlaybackRates = <double>[
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  State<ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<ControlsOverlay> {

  double brightness= 0.0;
  @override
  void initState() {
    super.initState();
    initializeBrightness();
  }

  void initializeBrightness() async{
    brightness = await FlutterScreenWake.brightness;

    FlutterScreenWake.setBrightness(0.5);

    bool isKeptOn = await FlutterScreenWake.isKeptOn;
    FlutterScreenWake.keepOn(true);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: widget.controller.value.isPlaying
              ?  SizedBox.shrink()
              : ColoredBox(
                  color: Colors.black26,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                       /* Slider(
                          value: brightness,
                          onChanged: (value) {

                            setState(() {
                              brightness = value;
                            });
                            FlutterScreenWake.setBrightness(brightness);

                          },
                        ),*/
                       /* SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 10,
                            thumbColor: Colors.blue,
                            activeTrackColor: Colors.blue,
                            inactiveTrackColor: Colors.grey,
                          ),
                          child: Transform.rotate(
                            angle: -90 * 3.14 / 180,
                            child: Slider(
                              value: brightness,
                              onChanged: (value) {

                                setState(() {
                                  brightness = value;
                                });
                                FlutterScreenWake.setBrightness(brightness);

                              },
                            ),
                          ),
                        ),*/
                        InkWell(
                            onTap: () {
                              widget.controller.seekTo(widget.controller.value.position + Duration(milliseconds: -100) );
                            },
                            child: SvgPicture.asset('assets/reverse.svg')),
                        InkWell(
                            onTap: () {
                              widget.controller.value.isPlaying ? widget.controller.pause() : widget.controller.play();
                            },
                            child: SvgPicture.asset('assets/pause.svg')),
                        InkWell(
                            onTap: () {
                              widget.controller.seekTo(widget.controller.value.position + Duration(milliseconds: 100) );
                            },
                            child: SvgPicture.asset('assets/forward.svg')),
                      ],
                    ),
                  ),
                ),
        ),
       if(widget.controller.value.isPlaying)
         GestureDetector(
           onTap: () {
                widget.controller.value.isPlaying ? widget.controller.pause() : widget.controller.play();
           },
         ),
       /* GestureDetector(
          onTap: () {
        //    controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),*/
        Align(
          alignment: Alignment.topLeft,
          child: PopupMenuButton<Duration>(
            initialValue: widget.controller.value.captionOffset,
            tooltip: 'Caption Offset',
            onSelected: (Duration delay) {
              widget.controller.setCaptionOffset(delay);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<Duration>>[
                for (final Duration offsetDuration in ControlsOverlay._exampleCaptionOffsets)
                  PopupMenuItem<Duration>(
                    value: offsetDuration,
                    child: Text('${offsetDuration.inMilliseconds}ms'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${widget.controller.value.captionOffset.inMilliseconds}ms'),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: widget.controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (double speed) {
              widget.controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (BuildContext context) {
              return <PopupMenuItem<double>>[
                for (final double speed in ControlsOverlay._examplePlaybackRates)
                  PopupMenuItem<double>(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${widget.controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
