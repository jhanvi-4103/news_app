import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const SearchBox({super.key, required this.onChanged});

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
  }

  void _toggleSearch() {
    setState(() {
      _isExpanded = !_isExpanded;
    });

    if (_isExpanded) {
      _focusNode.requestFocus();
    } else {
      _controller.clear();
      widget.onChanged('');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 56,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.indigo),
          const SizedBox(width: 8),
          Expanded(
            child: _isExpanded
                ? TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      hintText: 'Search news...',
                      border: InputBorder.none,
                    ),
                    onChanged: widget.onChanged,
                  )
                : const Text('Search', style: TextStyle(color: Colors.grey)),
          ),
          IconButton(
            icon: Icon(
              _isExpanded ? Icons.close : Icons.search,
              color: Colors.indigo,
            ),
            onPressed: _toggleSearch,
          ),
        ],
      ),
    );
  }
}
