import 'package:flutter/material.dart';

class MyRoundedButton extends StatelessWidget {
  final Function onTap;
  final String text;
  final Color color;
  final Color textColor;

  const MyRoundedButton({
    Key key,
    @required this.onTap,
    @required this.text,
    @required this.color,
    @required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _borderRadius = BorderRadius.circular(16);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        borderRadius: _borderRadius,
        color: color,
        child: InkWell(
          borderRadius: _borderRadius,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 8),
            child: Center(
              child: Text(
                text,
                style: Theme.of(context).textTheme.body1.copyWith(
                      color: textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
