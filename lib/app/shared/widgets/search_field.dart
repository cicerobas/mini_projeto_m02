import 'package:flutter/material.dart';

class SearchField extends StatefulWidget {
  const new({required this.onChanged, super.key});
  final ValueChanged<String> onChanged;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: 16),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          isDense: true,
          hintText: "Buscar...",
          prefixIcon: Icon(Icons.search),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, value, _) {
              if (value.text.isEmpty) {
                return const SizedBox.shrink();
              }
              return IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _controller.clear();
                  widget.onChanged('');
                },
              );
            },
          ),
          border: OutlineInputBorder(borderRadius: .circular(30)),
        ),
        onChanged: widget.onChanged,
        onTapOutside: (event) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
