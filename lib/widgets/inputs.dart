import 'dart:io';

import 'package:comprei/adapters/input_masks.dart';
import 'package:comprei/presentation/bloc/inputs/password_field.dart';
import 'package:comprei/widgets/styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:path_provider/path_provider.dart';

class _PasswordFieldCubit extends Cubit<PasswordFieldParams> {
  _PasswordFieldCubit({
    String initialValue = "",
    bool obscureText = true,
  }) : super(PasswordFieldParams(
          value: initialValue,
          obscureText: obscureText,
        ));

  void toggleVisibility() => emit(state.copyWith(
        obscureText: !state.obscureText,
      ));

  void valueChanged(String newValue) => emit(state.copyWith(
        value: newValue,
      ));
}

class _TextFieldCubit extends Cubit<String> {
  _TextFieldCubit({String initialValue = ''}) : super(initialValue);

  void valueChanged(String newValue) => emit(newValue);
}

class _ContentPickerCubit extends _TextFieldCubit {
  _ContentPickerCubit({String initialValue = ''})
      : super(initialValue: initialValue);
}

class PasswordField extends StatelessWidget {
  PasswordField({
    Key? key,
    this.initValue = "",
    this.obscureText = true,
    this.errorText,
  })  : _passwordCubit = _PasswordFieldCubit(
          initialValue: initValue,
          obscureText: obscureText,
        ),
        super(key: key);

  final String? errorText;
  final String initValue;
  final bool obscureText;
  final _PasswordFieldCubit _passwordCubit;

  String get currentValue => _passwordCubit.state.value;

  void reset() => _passwordCubit.emit(const PasswordFieldParams());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_PasswordFieldCubit, PasswordFieldParams>(
      bloc: _passwordCubit,
      builder: (newContext, state) => TextField(
        obscureText: state.obscureText,
        onChanged: _passwordCubit.valueChanged,
        style: style,
        decoration: InputDecoration(
          contentPadding: padding,
          hintText: AppLocalizations.of(newContext)!.password,
          errorText: errorText,
          border: border,
          suffixIcon: IconButton(
            icon: Icon(
              state.obscureText ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: _passwordCubit.toggleVisibility,
          ),
        ),
      ),
    );
  }
}

class TextInputField extends StatelessWidget {
  TextInputField({
    Key? key,
    this.hintText,
    this.enabled = true,
    this.errorText,
    this.noBorder = false,
    this.mask,
    this.labelText,
    this.suffixIcon,
    this.onPressedSuffixIcon,
  })  : _cubit = _TextFieldCubit(),
        super(key: key);

  final String? hintText;
  final bool enabled;
  final String? errorText;
  final String? labelText;
  final bool noBorder;
  final Mask? mask;
  final _TextFieldCubit _cubit;
  final IconData? suffixIcon;
  final VoidCallback? onPressedSuffixIcon;

  String get currentValue => _cubit.state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_TextFieldCubit, String>(
      bloc: _cubit,
      builder: (newContext, state) => TextFormField(
        initialValue: state,
        keyboardType: mask?.keyboardType,
        obscureText: false,
        inputFormatters: mask != null ? [mask!.formatter] : [],
        enabled: enabled,
        onChanged: enabled ? _cubit.valueChanged : null,
        style: style,
        decoration: InputDecoration(
          contentPadding: padding,
          hintText: hintText,
          labelText: labelText,
          errorText: errorText,
          border: noBorder ? null : border,
          suffixIcon: suffixIcon != null
              ? IconButton(
                  onPressed: onPressedSuffixIcon ?? () {},
                  icon: Icon(suffixIcon),
                )
              : null,
        ),
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
    Key? key,
    required this.label,
  })  : _cubit = _ContentPickerCubit(),
        super(key: key);

  final String label;

  final _ContentPickerCubit _cubit;

  String get currentValue => _cubit.state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ContentPickerCubit, String>(
      bloc: _cubit,
      builder: (newContext, state) => Padding(
        padding: padding,
        child: Column(
          children: [
            OutlinedButton.icon(
                icon: const Icon(Icons.folder),
                onPressed: () async {
                  String dir = Platform.isAndroid
                      ? '/storage/emulated/0'
                      : (await getApplicationDocumentsDirectory()).path;

                  String pathChosen = await FilesystemPicker.open(
                        title: 'Save to folder',
                        context: context,
                        rootDirectory: Directory(dir),
                        fsType: FilesystemType.folder,
                        pickText: 'Save file to this folder',
                        folderIconColor: Colors.teal,
                      ) ??
                      '';

                  _cubit.valueChanged(pathChosen);
                },
                label: Text(label),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)))),
            Text(state),
          ],
        ),
      ),
    );
  }
}

class FilePickerButton extends StatelessWidget {
  FilePickerButton({
    Key? key,
    required this.label,
  })  : _cubit = _ContentPickerCubit(),
        super(key: key);

  final String label;
  final _ContentPickerCubit _cubit;

  String get currentValue => _cubit.state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ContentPickerCubit, String>(
      bloc: _cubit,
      builder: (newContext, state) => Padding(
        padding: padding,
        child: Column(
          children: [
            OutlinedButton.icon(
                icon: const Icon(Icons.folder),
                onPressed: () async {
                  String dir = Platform.isAndroid
                      ? '/storage/emulated/0'
                      : (await getApplicationDocumentsDirectory()).path;

                  final filePicker = await FilePicker.platform.pickFiles();

                  String pathChosen = filePicker?.files.single.path ?? '';

                  _cubit.valueChanged(pathChosen);
                },
                label: Text(label),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)))),
            Text(state),
          ],
        ),
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
