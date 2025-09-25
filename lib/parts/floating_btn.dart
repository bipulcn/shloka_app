import 'package:flutter/material.dart';

class FloatingBtn extends StatefulWidget {
  const FloatingBtn({super.key});

  @override
  State<FloatingBtn> createState() => _FloatingBtnState();
}

class _FloatingBtnState extends State<FloatingBtn> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isOpen) ...[
          FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            heroTag: "btn1",
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            child: const Icon(Icons.home),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            heroTag: "btn2",
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/short');
            },
            child: Icon(Icons.short_text),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            heroTag: "btn3",
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/long');
            },
            child: Icon(Icons.subject),
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            heroTag: "btn4",
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/gita');
            },
            icon: null,
            label: Text("Gita"),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            heroTag: "btn6",
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/word');
            },
            child: const Icon(Icons.translate),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            heroTag: "font",
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/font');
            },
            child: Text("अ"),
          ),
          const SizedBox(height: 10),
        ],
        FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          foregroundColor: Colors.white,
          heroTag: "main",
          onPressed: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: Icon(isOpen ? Icons.close : Icons.menu),
        ),
      ],
    );
  }
}
