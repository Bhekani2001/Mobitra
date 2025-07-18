import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'permission_event.dart';
import 'permission_state.dart';

class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc() : super(PermissionInitial()) {
    on<CheckPermissionEvent>(_onCheckPermission);
    on<RequestPermissionEvent>(_onRequestPermission);
    on<PermissionGrantedEvent>((event, emit) => emit(PermissionGranted()));
    on<PermissionDeniedEvent>(
      (event, emit) => emit(PermissionDeniedForeground()),
    );
    on<PermissionDeniedScreenEvent>(
      (event, emit) => emit(PermissionPermanentlyDenied()),
    );
    on<PermissionErrorEvent>(
      (event, emit) => emit(PermissionError(event.error)),
    );
  }

  Future<void> _onCheckPermission(
    CheckPermissionEvent event,
    Emitter<PermissionState> emit,
  ) async {
    final status = await Permission.location.status;
    if (status.isGranted || status.isLimited) {
      emit(PermissionGranted());
    } else if (status.isPermanentlyDenied) {
      emit(PermissionPermanentlyDenied());
    } else {
      emit(PermissionDeniedForeground());
    }
  }

  Future<void> _onRequestPermission(
    RequestPermissionEvent event,
    Emitter<PermissionState> emit,
  ) async {
    try {
      if (event.permissionType == "location") {
        final status = await Permission.location.request();

        if (status.isGranted || status.isLimited) {
          add(PermissionGrantedEvent("location"));
        } else if (status.isPermanentlyDenied) {
          add(PermissionDeniedScreenEvent("Location permanently denied"));
        } else {
          add(PermissionDeniedEvent("location"));
        }
      }
    } catch (e) {
      add(PermissionErrorEvent(e.toString()));
    }
  }
}
