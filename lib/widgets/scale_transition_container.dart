import 'package:flutter/material.dart';

class ScaleTransitionContainer extends StatefulWidget {
  const ScaleTransitionContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  State<ScaleTransitionContainer> createState() =>
      _ScaleTransitionContainerState();
}

class _ScaleTransitionContainerState extends State<ScaleTransitionContainer>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 1000),
    vsync: this,
  )..forward();
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
