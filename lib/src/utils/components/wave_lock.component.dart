// import 'package:flutter/material.dart';
// import 'package:wakelock/wakelock.dart' as wavelock;


// class WaveLock extends StatefulWidget {
//   const WaveLock({
//     Key? key,
//     required this.child
//   }) : super(key: key);

//   final Widget child;

//   @override
//   State<WaveLock> createState() => _WaveLockState();
// }

// class _WaveLockState extends State<WaveLock> {
  
//   @override
//   void initState() {
//     super.initState();
//     wavelock.Wakelock.enable();
//   }

//   @override
//   void dispose() {
//     wavelock.Wakelock.disable();
//     super.dispose();
//   }
  
//   @override
//   Widget build(BuildContext context) {
//     return widget.child;
//   }
// }