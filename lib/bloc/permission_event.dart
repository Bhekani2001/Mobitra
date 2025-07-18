import 'package:flutter/material.dart';

@immutable
abstract class PermissionEvent {}

class CheckPermissionEvent extends PermissionEvent {}

class RequestPermissionEvent extends PermissionEvent {
  final String permissionType;
  RequestPermissionEvent(this.permissionType);
}

class PermissionGrantedEvent extends PermissionEvent {
  final String permissionType;
  PermissionGrantedEvent(this.permissionType);
}

class PermissionDeniedEvent extends PermissionEvent {
  final String permissionType;
  PermissionDeniedEvent(this.permissionType);
}

class PermissionDeniedScreenEvent extends PermissionEvent {
  final String message;
  PermissionDeniedScreenEvent(this.message);
}

class PermissionErrorEvent extends PermissionEvent {
  final String error;
  PermissionErrorEvent(this.error);
}
