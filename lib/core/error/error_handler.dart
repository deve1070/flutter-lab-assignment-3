import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';

class AppError implements Exception {
  final String message;
  final ErrorType type;
  final dynamic originalError;

  AppError({
    required this.message,
    required this.type,
    this.originalError,
  });

  @override
  String toString() => message;
}

enum ErrorType {
  network,
  server,
  cache,
  validation,
  unknown,
}

class ErrorHandler {
  static String handleError(dynamic error) {
    if (error is SocketException) {
      return 'No internet connection. Please check your network settings.';
    } else if (error is HttpException) {
      return 'Failed to connect to the server. Please try again later.';
    } else if (error is FormatException) {
      return 'Invalid data received from server. Please try again later.';
    } else if (error is TimeoutException) {
      return 'Request timed out. Please check your internet connection and try again.';
    } else {
      return 'An unexpected error occurred. Please try again later.';
    }
  }

  static bool isNetworkError(dynamic error) {
    return error is SocketException ||
        error is HttpException ||
        error is TimeoutException;
  }

  static String getErrorMessage(AppError error) {
    switch (error.type) {
      case ErrorType.network:
        return 'Network Error: ${error.message}';
      case ErrorType.server:
        return 'Server Error: ${error.message}';
      case ErrorType.cache:
        return 'Cache Error: ${error.message}';
      case ErrorType.validation:
        return 'Validation Error: ${error.message}';
      case ErrorType.unknown:
        return 'Unknown Error: ${error.message}';
    }
  }

  static IconData getErrorIcon(AppError error) {
    switch (error.type) {
      case ErrorType.network:
        return Icons.wifi_off;
      case ErrorType.server:
        return Icons.error_outline;
      case ErrorType.cache:
        return Icons.storage;
      case ErrorType.validation:
        return Icons.warning;
      case ErrorType.unknown:
        return Icons.error;
    }
  }
} 