import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Blackout extends StatelessWidget {
  const Blackout({
    super.key,
    required this.isEnabled,
    required this.child,
  });

  final ValueListenable<bool> isEnabled;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isEnabled,
      builder: (context, isEnabled, widget) {
        if (isEnabled) {
          return const SizedBox();
        }
        return child;
      },
    );
  }
}
