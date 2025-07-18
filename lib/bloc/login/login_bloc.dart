import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<LoginPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<LoginSubmitted>((event, emit) async {
      emit(state.copyWith(status: LoginStatus.submitting));

      try {
        // Simulate authentication delay
        await Future.delayed(const Duration(seconds: 2));

        // Add your authentication logic here:
        // For demo, accept email: test@test.com and password: password123
        if (state.email == 'test@test.com' && state.password == 'password123') {
          emit(state.copyWith(status: LoginStatus.success));
        } else {
          emit(
            state.copyWith(
              status: LoginStatus.failure,
              errorMessage: 'Invalid email or password',
            ),
          );
        }
      } catch (e) {
        emit(
          state.copyWith(
            status: LoginStatus.failure,
            errorMessage: 'An error occurred. Please try again.',
          ),
        );
      }
    });
  }
}
