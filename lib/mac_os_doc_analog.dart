import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_fit/doc_item.dart';

class MacOsDocAnalog extends StatefulWidget {
  static const items = [
    Icons.person,
    Icons.message,
    Icons.call,
    Icons.camera,
    Icons.photo,
  ];
  const MacOsDocAnalog({super.key});

  @override
  State<MacOsDocAnalog> createState() => _MacOsDocAnalogState();
}

class _MacOsDocAnalogState extends State<MacOsDocAnalog> {
  List<IconData> items = List.from(MacOsDocAnalog.items);
  late int? hoveredIdx;
  int? draggingIdx;
  late double baseItemHeight;
  late double baseTranslationY;
  late double verticalItemsPadding;

  double getScaleSize(int idx) {
    return getPropertyValue(
      idx: idx,
      baseVal: baseItemHeight,
      maxVal: 70,
      nonHoveredMaxVal: 50,
    );
  }

  double getTranslationY(int idx) {
    return getPropertyValue(
      idx: idx,
      baseVal: baseTranslationY,
      maxVal: -22,
      nonHoveredMaxVal: -14,
    );
  }

  double getPropertyValue({
    required int idx,
    required double baseVal,
    required double maxVal,
    required double nonHoveredMaxVal,
  }) {
    late final double propertyVal;
    if (hoveredIdx == null) {
      return baseVal;
    } else {
      final diff = (hoveredIdx! - idx).abs();
      final itemAffected = MacOsDocAnalog.items.length;
      if (diff == 0) {
        propertyVal = maxVal;
      } else if (diff <= itemAffected) {
        final ratio = (itemAffected - diff) / itemAffected;
        propertyVal = lerpDouble(baseVal, nonHoveredMaxVal, ratio)!;
      } else {
        propertyVal = baseVal;
      }
      return propertyVal;
    }
  }

  void onDragStart(int idx) {
    setState(() {
      draggingIdx = idx;
    });
  }

  // void onDragUpdate(int idx, DragUpdateDetails details) {
  //   // if (draggingIdx == null || draggingIdx == idx) return;
  //   // setState(() {
  //   //   final draggedItem = items.removeAt(draggingIdx!);
  //   //   items.insert(idx, draggedItem);
  //   //   draggingIdx = idx;
  //   // });
  //   final double widthPerItem =
  //       MediaQuery.of(context).size.width / items.length;

  //   final newIndex = (details.localPosition.dx / widthPerItem).floor();

  //   if (newIndex != draggingIdx && newIndex >= 0 && newIndex < items.length) {
  //     setState(() {
  //       final temp = items[draggingIdx!.toInt()];
  //       items[draggingIdx!.toInt()] = items[newIndex];
  //       items[newIndex] = temp;
  //       draggingIdx = newIndex;
  //     });
  //   }
  // }

  void onDragEnd() {
    setState(() {
      draggingIdx = null;
    });
  }

  @override
  void initState() {
    super.initState();
    hoveredIdx = null;
    baseItemHeight = 40;
    baseTranslationY = 0;
    verticalItemsPadding = 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              height: baseItemHeight,
              left: 0,
              right: 0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: const LinearGradient(
                    colors: [
                      Colors.blueAccent,
                      Colors.greenAccent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(verticalItemsPadding),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  items.length,
                  (idx) {
                    return GestureDetector(
                      onTapDown: (_) => setState(() => hoveredIdx = idx),
                      onTapCancel: () => setState(() => hoveredIdx = null),
                      onTapUp: (_) => setState(() => hoveredIdx = null),
                      onHorizontalDragStart: (_) => onDragStart(idx),
                      // onHorizontalDragUpdate: (details) {
                      //   // final newIdx = (details.delta.dx > 0 ? 1 : -1);
                      //   onDragUpdate(idx, details);
                      // },
                      onHorizontalDragEnd: (_) => onDragEnd(),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.bounceInOut,
                        transform: Matrix4.identity()
                          ..translate(
                            0.0,
                            getTranslationY(idx),
                            0.0,
                          ),
                        height: getScaleSize(idx),
                        width: getScaleSize(idx),
                        alignment: AlignmentDirectional.bottomCenter,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: DocItem(icon: items[idx]),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
