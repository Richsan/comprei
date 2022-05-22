import 'package:comprei/widgets/inputs.dart';
import 'package:comprei/widgets/styles.dart';
import 'package:flutter/material.dart';

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

class FullScreenCard extends StatelessWidget {
  const FullScreenCard({
    Key? key,
    required this.children,
    required this.title,
    required this.buttonName,
    required this.buttonOnPressed,
    this.onClose,
  }) : super(key: key);

  final List<Widget> children;
  final String title;
  final String buttonName;
  final VoidCallback buttonOnPressed;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 5,
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: onClose ?? () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  title,
                  style: TextStyle(fontSize: 25),
                ),
              ),
              const SizedBox(height: 45.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    // <-- alignments
                    children: children
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: e,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ActionButton(
                  text: buttonName,
                  onPressed: buttonOnPressed,
                ),
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}

class TextKeyValue extends StatelessWidget {
  const TextKeyValue({
    Key? key,
    required this.keyName,
    required this.value,
  }) : super(key: key);

  final String keyName;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
              text: '$keyName: ',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

class BoldText extends StatelessWidget {
  const BoldText({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16.0,
          color: Colors.black,
        ),
        children: <TextSpan>[
          TextSpan(
              text: text, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
