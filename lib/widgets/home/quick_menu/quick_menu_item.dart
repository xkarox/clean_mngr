import 'package:flutter/material.dart';

class QuickMenuItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final Function onTap;
  final double opacity;

  const QuickMenuItem(
      {super.key,
      required this.icon,
      required this.label,
      required this.onTap,
      this.opacity = 1
    });

  @override
  State<QuickMenuItem> createState() => _QuickMenuItemState();
}

class _QuickMenuItemState extends State<QuickMenuItem> {
  void _onTap() {
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.opacity,
      child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Theme.of(context).colorScheme.primary.withOpacity(1),
                spreadRadius: 0.5,
                blurRadius: 3,
                offset: const Offset(0, 3),
              ),
            ],
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          height: double.infinity,
          child: Material(
            borderRadius: BorderRadius.circular(25),
            child: InkWell(
              splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
              borderRadius: BorderRadius.circular(25),
              onTap: _onTap,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    widget.icon,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                    size: 60,
                  ),
                  Text(
                    widget.label,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}
