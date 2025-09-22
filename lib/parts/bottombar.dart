import 'package:flutter/material.dart';

class BBar {
  static Widget buildSlider({
    required double currentSliderValue,
    required ValueChanged<double> onChanged,
    int maxLim = 10,
  }) {
    return BottomAppBar(
      height: 50,
      color: Colors.transparent,
      child: BottomAppBar(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        child: Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: 2, // Thinner track
                  thumbColor: Colors.green,
                  thumbShape: RoundSliderThumbShape(
                    enabledThumbRadius: 8,
                  ), // Smaller thumb
                  overlayColor: Colors.green.withAlpha(100),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 12),
                ),
                child: Slider(
                  value: currentSliderValue,
                  min: 0,
                  max: maxLim.toDouble(),
                  divisions: maxLim,
                  label: currentSliderValue.round().toString(),
                  onChanged: onChanged,
                ),
              ),
            ),
            // IconButton(
            //   color: Colors.amber,
            //   icon: Icon(Icons.translate_outlined),
            //   onPressed: () {},
            // ),
          ],
        ),
      ),
    );
  }
}
