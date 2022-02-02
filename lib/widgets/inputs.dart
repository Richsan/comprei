import 'dart:io';

import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:comprei/widgets/styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    Key? key,
    this.errorText,
    required this.onChanged,
  }) : super(key: key);

  final Function(String) onChanged;
  final String? errorText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: true,
      onChanged: onChanged,
      style: style,
      decoration: InputDecoration(
        contentPadding: padding,
        hintText: AppLocalizations.of(context)!.password,
        errorText: errorText,
        border: border,
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    this.hintText = 'text',
    this.enabled = true,
    this.errorText,
    required this.onChanged,
  }) : super(key: key);

  final Function(String) onChanged;

  final String hintText;
  final bool enabled;
  final String? errorText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: false,
      enabled: enabled,
      onChanged: enabled ? onChanged : null,
      style: style,
      decoration: InputDecoration(
        contentPadding: padding,
        hintText: hintText,
        errorText: errorText,
        border: border,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.enabled = true,
    this.isLoading = false,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final bool enabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: const Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: padding,
        onPressed: enabled ? onPressed : null,
        child: isLoading
            ? const SizedBox(
                height: 25,
                width: 25,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            : Text(text,
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class LinkButton extends StatelessWidget {
  const LinkButton({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        child: Text(
          text,
          style: style.copyWith(
            color: Colors.blue,
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}

class DirectoryPickerButton extends StatelessWidget {
  DirectoryPickerButton({
    required this.onPressed,
    required this.label,
    this.path = '',
  });

  final String path;
  final String label;
  final Function(String?) onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          OutlinedButton.icon(
              icon: const Icon(Icons.folder),
              onPressed: () async {
                String? pathChosen = await FilesystemPicker.open(
                  title: 'Save to folder',
                  context: context,
                  rootDirectory: Directory('/storage/emulated/0/'),
                  fsType: FilesystemType.folder,
                  pickText: 'Save file to this folder',
                  folderIconColor: Colors.teal,
                );
                onPressed(pathChosen);
              },
              label: Text(label),
              style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0)))),
          Text(path),
        ],
      ),
    );
  }
}
