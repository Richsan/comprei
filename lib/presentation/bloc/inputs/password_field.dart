import 'package:bloc/bloc.dart';
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
  List<Object> get props =>
      [
        obscureText,
        value,
      ];
}

class PasswordFieldCubit extends Cubit<PasswordFieldParams> {
  PasswordFieldCubit() : super(const PasswordFieldParams());

  void toggleVisibility() =>
      emit(state.copyWith(
        obscureText: !state.obscureText,
      ));

  void valueChanged(String newValue) =>
      emit(state.copyWith(value: newValue,
      ));
}
