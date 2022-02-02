import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comprei/widgets/styles.dart';

class TextAlert extends StatelessWidget {
  const TextAlert({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        message,
        style: style.copyWith(
          color: Colors.red,
        ),
      ),
    );
  }
}

class CardInfo extends StatelessWidget {
  CardInfo({
    Key? key,
    required this.heading,
    required this.onTap,
    this.subHeading,
    this.cardImage,
    this.supportingText,
  }) : super(key: key);

  final String heading;
  final VoidCallback onTap;
  final String? subHeading;
  final NetworkImage? cardImage;
  final String? supportingText;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          elevation: 4.0,
          child: Column(
            children: [
              ListTile(
                title: Text(heading),
                subtitle: subHeading != null ? Text(subHeading!) : null,
                //trailing: Icon(Icons.favorite_outline),
              ),
              if (cardImage != null)
                Container(
                  height: 200.0,
                  child: Ink.image(
                    image: cardImage!,
                    fit: BoxFit.cover,
                  ),
                ),
              if (supportingText != null)
                Container(
                  padding: EdgeInsets.all(16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(supportingText!),
                ),
            ],
          )),
    );
  }
}
