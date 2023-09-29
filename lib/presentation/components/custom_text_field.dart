import 'package:flutter/material.dart';
import 'package:gluon/presentation/components/custom_painter/tooltip_shape_border.dart';

typedef CustomFormFieldValidator<T> = bool Function(T? value);

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final GlobalKey<TooltipState> tooltipKey;
  final CustomFormFieldValidator validator;

  const CustomTextField({super.key, required this.controller, required this.title, required this.tooltipKey, required this.validator});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hasError = false;
  bool isTooltipOpen = false;

  void toggleTooltip() {
    setState(() {
      isTooltipOpen = !isTooltipOpen;
      if (isTooltipOpen) widget.tooltipKey.currentState?.ensureTooltipVisible();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        errorStyle: const TextStyle(height: 0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        prefixIcon: const Icon(Icons.person, color: Colors.grey),
        suffixIcon: Visibility(
          visible: hasError,
          child: GestureDetector(
            onTap: toggleTooltip,
            child: Tooltip(
              key: widget.tooltipKey,
              message: 'username cannot be empty',
              preferBelow: false,
              decoration: const ShapeDecoration(
                shape: TooltipShapeBorder(arrowPosition: 0.87),
                color: Colors.red, // Background color of the tooltip
              ),
              verticalOffset: 30,
              child: Icon(
                Icons.info_rounded,
                color: hasError ? Colors.red : Colors.grey,
              ),
            ),
          ),
        ),
      ),
      validator: (value) {
        if (widget.validator(value)) {
          setState(() {
            hasError = true;
            isTooltipOpen = true;
          });
          Future.delayed(const Duration(milliseconds: 15)).then((value) => widget.tooltipKey.currentState!.ensureTooltipVisible());
          return '';
        } else {
          setState(() {
            hasError = false;
            isTooltipOpen = false;
          });
        }
        return null;
      },
    );
  }
}
