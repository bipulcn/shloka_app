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
            mini: true,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            child: const Icon(Icons.book),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            heroTag: "btn2",
            mini: true,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/short');
            },
            child: const Icon(Icons.line_style),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            heroTag: "btn3",
            mini: true,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/long');
            },
            child: const Icon(Icons.donut_large),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            heroTag: "btn4",
            mini: true,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/gita');
            },
            child: const Icon(Icons.gite_sharp),
          ),
          // const SizedBox(height: 10),
          // FloatingActionButton(
          //   heroTag: "btn5",
          //   mini: true,
          //   onPressed: () {
          //     Navigator.pushReplacementNamed(context, '/ram');
          //   },
          //   child: const Icon(Icons.gpp_good_outlined),
          // ),
          const SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.blueGrey,
            foregroundColor: Colors.white,
            heroTag: "btn6",
            mini: true,
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/word');
            },
            child: const Icon(Icons.wordpress_sharp),
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
