import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicare/helpers/theme/app_style.dart';
import 'package:medicare/helpers/widgets/my_spacing.dart';
import 'package:medicare/helpers/widgets/my_text_style.dart';

class CustomSearchField extends StatefulWidget {
  final List<String> suggestions;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onItemSelected;
  final VoidCallback? onTap;
  final bool numbered;
  final int? maxLength;
  final String? hintText;
  final Widget? prefixIcon;
  final TextStyle? textStyle;
  final double? width;
  final InputDecoration? decoration;
  dynamic validation;

  CustomSearchField({
    Key? key,
    required this.suggestions,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onItemSelected,
    this.onTap,
    this.numbered = false,
    this.maxLength,
    this.hintText,
    this.prefixIcon,
    this.textStyle,
    this.width,
    this.decoration,
    this.validation,
  }) : super(key: key);

  @override
  _CustomSearchFieldState createState() => _CustomSearchFieldState();
}

class _CustomSearchFieldState extends State<CustomSearchField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;
  List<String> _filteredSuggestions = [];
  double _textFieldWidth = 300; // Default width

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _updateOverlay();
      } else {
        _removeOverlay();
      }
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  void _updateOverlay() {
    _removeOverlay();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_filteredSuggestions.isNotEmpty) {
        _overlayEntry = _createOverlay();
        Overlay.of(context).insert(_overlayEntry!);
      }
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlay() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    _textFieldWidth = widget.width ?? renderBox.size.width;
    return OverlayEntry(
      builder: (context) {
        return Positioned(
          width: _textFieldWidth, // Dynamically set width
          child: CompositedTransformFollower(
            link: _layerLink,
            offset: Offset(0, renderBox.size.height + 5), // Adjusted for better alignment
            child: Material(
              elevation: 4.0,
              borderRadius: BorderRadius.circular(12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 200, // Adjust the height dynamically if needed
                    minWidth: _textFieldWidth,
                    maxWidth: _textFieldWidth,
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: _filteredSuggestions.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: AppColors.white
                        ),
                        child: ListTile(
                          dense: true,
                          title: Text(_filteredSuggestions[index],style: widget.textStyle,),
                          onTap: () {
                            _controller.text = _filteredSuggestions[index];
                            _removeOverlay();
                            widget.onItemSelected?.call(_filteredSuggestions[index]);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTextChanged(String value) {
    setState(() {
      _filteredSuggestions = widget.suggestions
          .where((s) => s.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
    _updateOverlay();
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _textFieldWidth = constraints.maxWidth; // Get dynamic width
        return CompositedTransformTarget(
          link: _layerLink,
          child: TextFormField(
            onTap: widget.onTap ?? () {},
            controller: _controller,
            focusNode: _focusNode,
            keyboardType: widget.numbered ? TextInputType.phone : null,
            maxLength: widget.maxLength,
            inputFormatters: widget.numbered
                ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))]
                : null,
            onChanged: _onTextChanged,
            style: widget.textStyle,
            validator: widget.validation,
            decoration: widget.decoration ??
                InputDecoration(
                  errorStyle: MyTextStyle.bodyErrorFiled(fontWeight: 400, muted: true,color: Colors.red,fontSize: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: widget.hintText,
                  counterText: "",
                  isCollapsed: true,
                  hintStyle: MyTextStyle.bodySmall(fontWeight: 600, muted: true),
                  isDense: true,
                  prefixIcon: widget.prefixIcon,
                  contentPadding: MySpacing.all(16),
                ),
          ),
        );
      },
    );
  }
}