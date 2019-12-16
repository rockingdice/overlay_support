import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:overlay_support/overlay_support.dart';

/// a notification show in front of screen and shown at the top
class TopSlideNotification extends StatelessWidget {
  ///build notification content
  final WidgetBuilder builder;

  final double progress;

  const TopSlideNotification({Key key, @required this.builder, this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: Offset.lerp(const Offset(0, -1), const Offset(0, 0), progress),
      child: builder(context),
    );
  }
}

///can be dismiss by left or right slide
class SlideDismissible extends StatelessWidget {
  final Widget child;
  final DismissDirection dismissDirection;
  final bool enable;

  const SlideDismissible({
    @required Key key,
    @required this.child,
    @required this.enable,
    this.dismissDirection = DismissDirection.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!enable) return child;
    return Dismissible(
      child: child,
      key: key,
      direction: dismissDirection,
      onDismissed: (direction) {
        OverlaySupportEntry.of(context, requireForDebug: this).dismiss(animate: false);
      },
    );
  }
}
