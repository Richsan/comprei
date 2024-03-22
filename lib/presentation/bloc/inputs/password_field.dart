import 'package:equatable/equatable.dart';

class PasswordFieldParams extends Equatable {
  const PasswordFieldParams({
    this.obscureText = true,
    this.value = '',
  });

  final bool obscureText;
  final String value;

  PasswordFieldParams copyWith({
    bool? obscureText,
    String? value,
  }) =>
      PasswordFieldParams(
        obscureText: obscureText ?? this.obscureText,
        value: value ?? this.value,
      );

  @override
  List<Object> get props => [
        obscureText,
        value,
      ];
}
