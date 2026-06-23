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
  final _focusNode = FocusNode();
  var _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() => setState(() => _hasFocus = _focusNode.hasFocus);

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      onChanged: widget.onChanged,
      style: context.textTheme.bodyMedium,
      decoration: InputDecoration(
        hintText: 'Поиск по ФИО',
        filled: true,
        fillColor: _hasFocus
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
  }
}
