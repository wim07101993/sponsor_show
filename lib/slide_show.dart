import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

class SlideShow extends StatefulWidget {
  const SlideShow({
    super.key,
    required this.slideBuilder,
    required this.slideScreenTime,
  });

  final Widget Function(BuildContext context, int index) slideBuilder;
  final Duration Function(int index) slideScreenTime;

  @override
  State<SlideShow> createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  final index = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => loop());
  }

  Future loop() async {
    while (mounted) {
      await Future.delayed(widget.slideScreenTime(index.value));
      if (!mounted) {
        return;
      }
      index.value++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: index,
      builder: (context, value, _) => widget.slideBuilder(context, value),
    );
  }
}
