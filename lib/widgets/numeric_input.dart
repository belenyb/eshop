import 'package:flutter/material.dart';

class NumericInput extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;
  final int? initialValue;

  const NumericInput(
      {Key? key,
      this.minValue = 1,
      this.maxValue = 10,
      required this.onChanged,
      this.initialValue})
      : super(key: key);

  @override
  State<NumericInput> createState() {
    return _NumericInputState();
  }
}

class _NumericInputState extends State<NumericInput> {
  late int counter = 1;

  @override
  void initState() {
    super.initState();
    counter = widget.initialValue ?? widget.minValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_up,
          ),
          padding:
              const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
          iconSize: 32.0,
          color: Theme.of(context).primaryColor,
          onPressed: () {
            setState(() {
              if (counter < widget.maxValue) {
                counter++;
              }
              widget.onChanged(counter);
            });
          },
        ),
        Text(
          '$counter',
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black87,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.keyboard_arrow_down,
          ),
          padding:
              const EdgeInsets.symmetric(vertical: 4.0, horizontal: 18.0),
          iconSize: 32.0,
          color: Theme.of(context).primaryColor,
          onPressed: () {
            setState(() {
              if (counter > widget.minValue) {
                counter--;
              }
              widget.onChanged(counter);
            });
          },
        ),
      ],
    );
  }
}
