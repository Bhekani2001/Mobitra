import 'package:flutter/material.dart';

@immutable
abstract class PermissionState {}

class PermissionInitial extends PermissionState {}

class PermissionGranted extends PermissionState {}

class PermissionDeniedForeground extends PermissionState {}

class PermissionDeniedBackground extends PermissionState {}

class PermissionPermanentlyDenied extends PermissionState {}

class PermissionError extends PermissionState {
  final String error;
  PermissionError(this.error);
}
