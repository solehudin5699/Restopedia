import 'package:flutter/material.dart';

class SlideTransitionContainer extends StatefulWidget {
  const SlideTransitionContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;
  @override
  State<SlideTransitionContainer> createState() =>
      _SlideTransitionContainerState();
}

class _SlideTransitionContainerState extends State<SlideTransitionContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  )..forward();

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.3, 0.0),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  ));

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
    return SlideTransition(
      position: _offsetAnimation,
      child: widget.child,
    );
  }
}
