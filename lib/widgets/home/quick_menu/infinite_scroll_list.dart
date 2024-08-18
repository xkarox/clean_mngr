import 'package:clean_mngr/widgets/home/quick_menu/quick_menu_item.dart';
import 'package:flutter/material.dart';

class InfiniteScrollList extends StatefulWidget {
  final List<QuickMenuItem> children;
  final Axis scrollDirection;
  final double itemExtent;
  final double diameterRatio;

  const InfiniteScrollList(
      {super.key,
      required this.children,
      required this.scrollDirection,
      this.itemExtent = 110,
      this.diameterRatio = 100000});

  @override
  State<InfiniteScrollList> createState() => _InfiniteScrollListState();
}

class _InfiniteScrollListState extends State<InfiniteScrollList> {
  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: widget.scrollDirection == Axis.horizontal ? 3 : 0,
      child: Container(
        // color: Colors.transparent,
        child: ShaderMask(
          shaderCallback: (Rect rect) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).colorScheme.primary,
                Colors.transparent,
                Colors.transparent,
                Theme.of(context).colorScheme.primary
              ],
              stops: const[
                0.0,
                0.1,
                0.9,
                1.0
              ], // 10% purple, 80% transparent, 10% purple
            ).createShader(rect);
          },
          blendMode: BlendMode.dstOut,
          child: ListWheelScrollView.useDelegate(
            offAxisFraction: 0,
            clipBehavior: Clip.antiAlias,
            itemExtent: widget.itemExtent,
            diameterRatio: widget.diameterRatio,
            physics: const FixedExtentScrollPhysics(),
            onSelectedItemChanged: (index) => {},
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                return RotatedBox(
                  quarterTurns:
                      widget.scrollDirection == Axis.horizontal ? 1 : 0,
                  child: widget.children[index % widget.children.length],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
