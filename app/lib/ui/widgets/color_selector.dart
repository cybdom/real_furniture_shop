import 'package:flutter/material.dart';

class ColorSelector extends StatefulWidget {
  final List<dynamic> colors;
  final int active;
  final Function(int value) onTap;

  const ColorSelector({Key key, this.colors, this.active, this.onTap})
      : super(key: key);

  @override
  _ColorSelectorState createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 7,
      spacing: 7,
      children: List.generate(
        widget.colors.length,
        (f) => GestureDetector(
          onTap: () => widget.onTap(f),
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: Color(
                  int.parse(widget.colors[f].substring(1, 7), radix: 16) +
                      0xFF000000),
              shape: BoxShape.circle,
              border: widget.active == f
                  ? Border.all(color: Colors.white, width: 5)
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
