import 'package:flutter/material.dart';
import 'package:flutter_lab_assignment_3/core/error/error_handler.dart';
import 'package:flutter_lab_assignment_3/presentation/widgets/error_view.dart';

class ErrorBoundary extends StatefulWidget {
  final Widget child;
  final Widget Function(AppError error)? errorBuilder;

  const ErrorBoundary({
    super.key,
    required this.child,
    this.errorBuilder,
  });

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  AppError? _error;

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      if (widget.errorBuilder != null) {
        return widget.errorBuilder!(_error!);
      }
      return ErrorView(
        message: ErrorHandler.getErrorMessage(_error!),
        onRetry: () {
          setState(() {
            _error = null;
          });
        },
        icon: ErrorHandler.getErrorIcon(_error!),
      );
    }

    ErrorWidget.builder = (FlutterErrorDetails details) {
      setState(() {
        _error = AppError(
          message: details.exception.toString(),
          type: ErrorType.unknown,
          originalError: details.exception,
        );
      });
      return const SizedBox.shrink();
    };

    return widget.child;
  }
} 