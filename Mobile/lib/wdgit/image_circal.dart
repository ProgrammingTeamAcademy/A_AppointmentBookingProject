import 'package:flutter/material.dart';

class AnimatedImageDoctor extends StatefulWidget {
  const AnimatedImageDoctor({super.key});

  @override
  _AnimatedImageDoctorState createState() => _AnimatedImageDoctorState();
}

class _AnimatedImageDoctorState extends State<AnimatedImageDoctor>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, -2.0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
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
      child: Padding(
        padding: EdgeInsetsDirectional.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.3),
        child: CircleAvatar(
          radius: MediaQuery.of(context).size.height * 0.1,
          backgroundColor: Colors.blue,
          // backgroundImage: const AssetImage("assets/images/doctor_1.jpg"),
        ),
      ),
    );
  }
}
