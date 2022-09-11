import 'dart:io';

import 'package:comprei/adapters/input_masks.dart';
import 'package:comprei/widgets/styles.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';

class _PasswordFieldCubit extends Cubit<bool> {
  _PasswordFieldCubit({bool obscureText = true}) : super(obscureText);

  void toggleVisibility() => emit(!state);
}

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
    return BlocProvider(
      create: (context) => _PasswordFieldCubit(),
      child: BlocBuilder<_PasswordFieldCubit, bool>(
        builder: (context, obscureText) => TextField(
          obscureText: obscureText,
          onChanged: onChanged,
          style: style,
          decoration: InputDecoration(
            contentPadding: padding,
            hintText: AppLocalizations.of(context)!.password,
            errorText: errorText,
            border: border,
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility : Icons.visibility_off,
                color: Theme.of(context).primaryColorDark,
              ),
              onPressed: () => BlocProvider.of<_PasswordFieldCubit>(context)
                  .toggleVisibility(),
            ),
          ),
        ),
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  const TextInputField({
    Key? key,
    this.hintText,
    this.enabled = true,
    this.errorText,
    this.initialValue,
    this.noBorder = false,
    this.mask,
    this.labelText,
    required this.onChanged,
  }) : super(key: key);

  final Function(String) onChanged;

  final String? hintText;
  final bool enabled;
  final String? errorText;
  final String? labelText;
  final String? initialValue;
  final bool noBorder;
  final Mask? mask;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: mask?.keyboardType,
      obscureText: false,
      inputFormatters: mask != null ? [mask!.formatter] : [],
      enabled: enabled,
      onChanged: enabled ? onChanged : null,
      style: style,
      decoration: InputDecoration(
        contentPadding: padding,
        hintText: hintText,
        labelText: labelText,
        errorText: errorText,
        border: noBorder ? null : border,
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
                String dir = Platform.isAndroid
                    ? '/storage/emulated/0/'
                    : (await getApplicationDocumentsDirectory()).path;

                String? pathChosen = await FilesystemPicker.open(
                  title: 'Save to folder',
                  context: context,
                  rootDirectory: Directory(dir),
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

class IconicButton extends StatelessWidget {
  const IconicButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.label,
    this.tooltip,
  }) : super(key: key);

  final IconData icon;
  final String? label;
  final String? tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textWidget = label != null ? [Text(label!)] : [];

    return Column(
      children: [
        IconButton(
          icon: Icon(icon),
          tooltip: tooltip,
          onPressed: onPressed,
        ),
        ...textWidget
      ],
    );
  }
}
