import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gluon/presentation/components/custom_painter/tooltip_shape_border.dart';

typedef CustomFormFieldValidator<T> = bool Function(T? value);

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final GlobalKey<TooltipState> tooltipKey;
  final CustomFormFieldValidator validator;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hint;
  final String tooltipMessage;
  final TextInputType? keyboardType;
  final bool isReadOnly;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.title,
    required this.tooltipKey,
    required this.validator,
    required this.tooltipMessage,
    this.suffixIcon,
    this.prefixIcon,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.isReadOnly = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isShowTooltip = false;
  bool isTooltipOpen = false;

  void toggleTooltip() {
    setState(() {
      isTooltipOpen = !isTooltipOpen;
      if (isTooltipOpen) widget.tooltipKey.currentState?.ensureTooltipVisible();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title),
        TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          readOnly: widget.isReadOnly,
          maxLines: widget.isReadOnly ? null : 1,
          inputFormatters: [if (widget.keyboardType == const TextInputType.numberWithOptions()) FilteringTextInputFormatter.digitsOnly],
          decoration: InputDecoration(
            hintText: widget.hint,
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
            prefixIcon: widget.prefixIcon,
            suffixIcon: Visibility(
              visible: isShowTooltip,
              child: GestureDetector(
                onTap: toggleTooltip,
                child: Tooltip(
                  key: widget.tooltipKey,
                  message: widget.tooltipMessage,
                  preferBelow: false,
                  decoration: const ShapeDecoration(
                    shape: TooltipShapeBorder(arrowPosition: 0.87),
                    color: Colors.red, // Background color of the tooltip
                  ),
                  verticalOffset: 30,
                  child: widget.suffixIcon ??
                      Icon(
                        Icons.info_rounded,
                        color: isShowTooltip ? Colors.red : Colors.grey,
                      ),
                ),
              ),
            ),
          ),
          validator: (_) {
            if (widget.validator(widget.controller.text)) {
              setState(() {
                isShowTooltip = true;
                isTooltipOpen = true;
              });
              // delayed tooltip show;
              Future.delayed(const Duration(milliseconds: 15)).then((value) => widget.tooltipKey.currentState?.ensureTooltipVisible());
              return '';
            } else {
              setState(() {
                isShowTooltip = false;
                isTooltipOpen = false;
              });
            }
            return null;
          },
        )
      ],
    );
  }
}
