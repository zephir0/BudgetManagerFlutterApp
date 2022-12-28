// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

class SlideBudget extends StatefulWidget {
  final Widget child;
  final VoidCallback callback;
  const SlideBudget({
    Key? key,
    required this.child,
    required this.callback,
  }) : super(key: key);
  @override
  State<SlideBudget> createState() => SlideBudgetState();
}

class SlideBudgetState extends State<SlideBudget>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  double _dragExtent = 0;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragStart: onDragStart,
        onHorizontalDragUpdate: onDragUpdate,
        onHorizontalDragEnd: onDragEnd,
        child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) => SlideTransition(
                  position: AlwaysStoppedAnimation(
                      Offset(-animationController.value, 0)),
                  child: widget.child,
                )));
  }

  void onDragStart(DragStartDetails details) {
    setState(() {
      _dragExtent = 0;
      animationController.reset();
    });
  }

  void onDragUpdate(DragUpdateDetails details) {
    _dragExtent += details.primaryDelta!;

    setState(() {
      animationController.value = _dragExtent.abs() / context.size!.width;
    });
  }

  void onDragEnd(DragEndDetails details) {
    animationController.fling();
    widget.callback();
  }
}
