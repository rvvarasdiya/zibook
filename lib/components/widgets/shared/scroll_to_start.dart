import 'package:zaviato/components/widgets/shared/scroll_direction_listener.dart';
import 'package:flutter/material.dart';
import 'package:zaviato/app/localization/app_locales.dart';

import '../../../app/app.export.dart';
import 'buttons.dart';
import 'implicit_animations.dart';

/// A button at the bottom of the screen that listens to the
/// [ScrollDirection] and position to animate in or out of the screen.
///
/// Scrolls to the start of the list on tap.
///
/// The button is visible if the current scroll position is greater than the
/// screen size and the current scroll direction is [ScrollDirection.up].
class ScrollToStart extends StatefulWidget {
  const ScrollToStart({
    @required this.child,
  });

  final Widget child;

  @override
  _ScrollToStartState createState() => _ScrollToStartState();
}

class _ScrollToStartState extends State<ScrollToStart> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _scrollController ??= PrimaryScrollController.of(context)
      ..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.removeListener(_scrollListener);
  }

  void _scrollListener() {
    final mediaQuery = MediaQuery.of(context);

    // rebuild the button when scroll position is lower than the screen size
    // to hide the button when scrolling all the way up
    if (_scrollController.position.pixels < mediaQuery.size.height && mounted) {
      setState(() {});
    }
  }

  /// Determines if the button should show.
  bool get _show {
    final scrollDirection = ScrollDirection.of(context);
    final mediaQuery = MediaQuery.of(context);

    if (!_scrollController.hasClients) {
      return false;
    }

    return _scrollController.position.pixels > mediaQuery.size.height &&
        scrollDirection.up;
  }

  void _scrollToStart() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final appTheme = Theme.of(context);

    return Stack(
      children: <Widget>[
        widget.child,
        Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedOpacity(
            opacity: _show ? 1 : 0,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 300),
            child: AnimatedShiftedPosition(
              shift: _show ? Offset.zero : const Offset(0, 1),
              child: Padding(
                padding: EdgeInsets.all(16),
                child: AppButton.raised(
                  text: R.string().commonString.jumpToTop,
                  icon: Icons.arrow_upward,
                  backgroundColor: appTheme.backgroundColor,
                  dense: true,
                  onTap: _scrollToStart,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
