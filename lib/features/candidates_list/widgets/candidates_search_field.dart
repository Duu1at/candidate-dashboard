import 'package:flutter/material.dart';
import 'package:candidate_dashboard/core/core.dart';

class CandidatesSearchField extends StatefulWidget {
  const CandidatesSearchField({
    required this.controller,
    required this.onChanged,
    required this.onClear,
    super.key,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  @override
  State<CandidatesSearchField> createState() => _CandidatesSearchFieldState();
}

class _CandidatesSearchFieldState extends State<CandidatesSearchField> {
  late final FocusNode _focusNode;
  late final ValueNotifier<bool> _hasFocus;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _hasFocus = ValueNotifier(_focusNode.hasFocus);
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    _hasFocus.value = _focusNode.hasFocus;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _hasFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _hasFocus,
      builder: (context, hasFocus, _) {
        return TextField(
          controller: widget.controller,
          focusNode: _focusNode,
          onChanged: widget.onChanged,
          style: context.textTheme.bodyMedium,
          decoration: InputDecoration(
            hintText: 'Поиск по ФИО',
            filled: true,
            fillColor: hasFocus
                ? context.colors.surface
                : context.colors.surfaceContainerHighest,
            prefixIcon: Icon(
              Icons.search_rounded,
              color: context.colors.onSurfaceVariant,
              size: 20,
            ),
            border: const OutlineInputBorder(
              borderRadius: AppRadius.inputBorderRadius,
              borderSide: BorderSide.none,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: AppRadius.inputBorderRadius,
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: AppRadius.inputBorderRadius,
              borderSide: BorderSide(color: context.colors.primary, width: 1.5),
            ),
            suffixIcon: ValueListenableBuilder<TextEditingValue>(
              valueListenable: widget.controller,
              builder: (_, value, _) {
                return value.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear_rounded, size: 18),
                        color: context.colors.onSurfaceVariant,
                        onPressed: widget.onClear,
                      )
                    : const SizedBox.shrink();
              },
            ),
          ),
        );
      },
    );
  }
}
