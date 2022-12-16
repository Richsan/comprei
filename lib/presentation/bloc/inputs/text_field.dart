import 'package:bloc/bloc.dart';

mixin ITextFieldCubit on Cubit<String> {
  void valueChanged(String newValue) => emit(newValue);
}

class TextFieldCubit extends Cubit<String> with ITextFieldCubit {
  TextFieldCubit({String initialValue = ''}) : super(initialValue);
}
