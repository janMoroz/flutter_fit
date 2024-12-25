// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Center(
//           child: Dock(
//             items: const [
              // Icons.person,
              // Icons.message,
              // Icons.call,
              // Icons.camera,
              // Icons.photo,
//             ],
//             builder: (icon, scale) {
//               return Transform.scale(
//                 scale: scale,
//                 child: Container(
//                   constraints: const BoxConstraints(minWidth: 48),
//                   height: 48,
//                   margin: const EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: Colors
//                         .primaries[icon.hashCode % Colors.primaries.length],
//                   ),
//                   child: Center(
//                     child: Icon(icon, color: Colors.white),
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

// class Dock extends StatefulWidget {
//   final List<IconData> items;
//   final Widget Function(IconData, double) builder;

//   const Dock({
//     super.key,
//     required this.items,
//     required this.builder,
//   });

//   @override
//   DockState createState() => DockState();
// }

// class DockState extends State<Dock> {
//   late List<IconData> dockItems;
//   IconData? draggedIcon;
//   int? draggedIndex;

//   @override
//   void initState() {
//     super.initState();
//     dockItems = List.from(widget.items);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(child: Container()),
//         Container(
//           padding: const EdgeInsets.all(4),
//           decoration: BoxDecoration(
//             color: Colors.black12,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: List.generate(
//               dockItems.length,
//               (index) {
//                 final scale = _calculateScale(index);
//                 return Draggable<IconData>(
//                   data: dockItems[index],
//                   feedback: widget.builder(dockItems[index], 1.3),
//                   childWhenDragging: Opacity(
//                     opacity: 0.5,
//                     child: widget.builder(dockItems[index], 1.0),
//                   ),
//                   onDragStarted: () {
//                     setState(() {
//                       draggedIcon = dockItems[index];
//                       draggedIndex = index;
//                     });
//                   },
//                   onDragEnd: (_) {
//                     setState(() {
//                       draggedIndex = null;
//                     });
//                   },
//                   onDragUpdate: (details) {
                    // final double widthPerItem =
                    //     MediaQuery.of(context).size.width / dockItems.length;

                    // final newIndex =
                    //     (details.localPosition.dx / widthPerItem).floor();

                    // if (newIndex != draggedIndex &&
                    //     newIndex >= 0 &&
                    //     newIndex < dockItems.length) {
                    //   setState(() {
                    //     final temp = dockItems[draggedIndex!.toInt()];
                    //     dockItems[draggedIndex!.toInt()] = dockItems[newIndex];
                    //     dockItems[newIndex] = temp;
                    //     draggedIndex = newIndex;
                    //   });
                    // }
//                   },
//                   child: widget.builder(dockItems[index], scale),
//                 );
//               },
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   double _calculateScale(int idx) {
//     if (draggedIndex == null) return 1.0;
//     final distance = (idx - draggedIndex!).abs();
//     switch (distance) {
//       case 0:
//         return 1.3;
//       case 1:
//         return 1.2;
//       case 2:
//         return 1.1;
//       default:
//         return 1.0;
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_fit/mac_os_doc_analog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MacOsDocAnalog(),
    );
  }
}