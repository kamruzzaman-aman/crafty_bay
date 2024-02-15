import 'package:flutter/material.dart';
class ColorSelector extends StatefulWidget {
  const ColorSelector({super.key, required this.colors, required this.onTap});
  final List<Color> colors ;
  final Function(Color) onTap;

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late Color isSelectedColor;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSelectedColor=widget.colors.first;
    widget.onTap(isSelectedColor);
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.colors.map((color) => InkWell(
        splashColor: Colors.transparent,
        onTap: (){
          widget.onTap(color);
          setState(() {
            isSelectedColor=color;
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 5),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black38),
            ),
            child: CircleAvatar(
              backgroundColor: color,
              radius: 12,
              child: isSelectedColor==color?Icon(Icons.check, color: Colors.black):null,
            ),
          ),
        ),
      )).toList(),

    );
  }
}