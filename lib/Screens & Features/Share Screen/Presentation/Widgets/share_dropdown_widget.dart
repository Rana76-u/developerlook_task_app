import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Data/selected_item_value_determainer.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Data/util.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_bloc.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_event.dart';
import 'package:developerlook_task_app/Screens%20&%20Features/Share%20Screen/Bloc/share_review_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShareDropdownWidget extends StatefulWidget {
  final String dropdownType;
  final ShareReviewState state;
  const ShareDropdownWidget({super.key, required this.dropdownType, required this.state});

  @override
  ShareDropdownWidgetState createState() => ShareDropdownWidgetState();
}

class ShareDropdownWidgetState extends State<ShareDropdownWidget> {
  final LayerLink _layerLink = LayerLink();
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _loadData().then((_) => _showOverlay());
      } else {
        _removeOverlay();
      }
    });
  }

  Future<void> _loadData() async {
    final bloc = context.read<ShareReviewBloc>();
    QuerySnapshot snapshot;
    String input = _controller.text.trim();
    String upperInput = input.toUpperCase();
    String lowerInput = input.toLowerCase();
    List<Map<String, dynamic>> items = [];

    if (widget.dropdownType == 'departure' || widget.dropdownType == 'arrival') {
      snapshot = await FirebaseFirestore.instance.collection('airports').where(
        Filter.or(
          Filter('code', isGreaterThanOrEqualTo: upperInput),
          Filter('code', isLessThan: '$lowerInput\uf8ff'),
          Filter('airport', isGreaterThanOrEqualTo: upperInput),
          Filter('airport', isLessThan: '$lowerInput\uf8ff'),
          Filter('city', isGreaterThanOrEqualTo: upperInput),
          Filter('city', isLessThan: '$lowerInput\uf8ff'),
        ),
      ).get();

      items = snapshot.docs.map((doc) => {
        'city': doc['city'],
        'airport': doc['airport'],
        'code': doc['code'],
      }).toList();

    } else if (widget.dropdownType == 'airline') {
      snapshot = await FirebaseFirestore.instance.collection('airlines').where(
        Filter.or(
          Filter('name', isGreaterThanOrEqualTo: upperInput),
          Filter('name', isLessThan: '$lowerInput\uf8ff'),
          Filter('country', isGreaterThanOrEqualTo: upperInput),
          Filter('country', isLessThan: '$lowerInput\uf8ff'),
          Filter('code', isGreaterThanOrEqualTo: upperInput),
          Filter('code', isLessThan: '$lowerInput\uf8ff'),
        ),
      ).get();

      items = snapshot.docs.map((doc) => {
        'name': doc['name'],
        'country': doc['country'],
        'code': doc['code'],
      }).toList();

    } else if (widget.dropdownType == 'class') {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('class').doc('set1').get();
      final List<dynamic> classList = doc['classes'];
      items = classList.map((c) => {'name': c.toString()}).toList();
    }

    bloc.add(UpdateDropdownItemsList(dropdownType: widget.dropdownType, items: items));
  }

  List<Map<String, dynamic>> get filteredItems => widget.state.dropdownItems[widget.dropdownType]?.where((item) {
    return item.values.any((val) => val.toLowerCase().contains(widget.state.searchQueries[widget.dropdownType]?.toLowerCase() ?? ''));
  }).toList() ?? [];

  void _showOverlay() {
    _removeOverlay();
    final overlay = Overlay.of(context);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: MediaQuery.of(context).size.width - 40,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: const Offset(0, 60),
          child: Material(
            elevation: 2,
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 200),
              child: FutureBuilder(
                future: _loadData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: \${snapshot.error}'));
                  } else if (filteredItems.isEmpty) {
                    return const Center(child: Text('No results found'));
                  }

                  return ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: filteredItems.map((item) {
                      return ListTile(
                        dense: true,
                        visualDensity: const VisualDensity(vertical: -4),
                        title: Text(
                          SelectedItemValueDeterminer().getTitle(widget.dropdownType, item),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: ShareScreenUtil().isListTileView(widget.dropdownType)
                            ? Text(SelectedItemValueDeterminer().getSubtitle(widget.dropdownType, item))
                            : null,
                        trailing: ShareScreenUtil().isListTileView(widget.dropdownType)
                            ? Text(SelectedItemValueDeterminer().getTrailing(widget.dropdownType, item))
                            : null,
                        onTap: () {
                          context.read<ShareReviewBloc>().add(UpdateDropdownSelectedItem(dropdownType: widget.dropdownType, selectedItem: item));
                          _removeOverlay();
                          _focusNode.unfocus();
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedItem = widget.state.selectedItems[widget.dropdownType];
    return selectedItem != null && selectedItem.isNotEmpty
        ? _buildSelectedItem(selectedItem)
        : _buildSearchField();
  }

  Widget _buildSearchField() {
    return CompositedTransformTarget(
      link: _layerLink,
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        onChanged: (value) {
          context.read<ShareReviewBloc>().add(UpdateDropdownSearchQuery(dropdownType: widget.dropdownType, query: value));
          _loadData().then((_) => _showOverlay());
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          hintText: ShareScreenUtil().getHintText(widget.dropdownType),
          hintStyle: const TextStyle(color: Color(0xFFB0B0B0), fontSize: 14),
          suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE8E8EA), width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectedItem(Map<String, dynamic> selectedItem) {
    bool isListTileView = ShareScreenUtil().isListTileView(widget.dropdownType);
    return GestureDetector(
      onTap: () {
        context.read<ShareReviewBloc>().add(
            UpdateDropdownSelectedItem(
                dropdownType: widget.dropdownType, selectedItem: {}
            )
        );
        _controller.clear();
        _focusNode.requestFocus();
        _loadData().then((_) => _showOverlay());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0xFFE8E8EA), width: 1.17),
          color: Colors.white,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    SelectedItemValueDeterminer().getTitle(widget.dropdownType, selectedItem),
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black),
                  ),
                  Visibility(
                    visible: isListTileView,
                    child: Text(
                      isListTileView ? SelectedItemValueDeterminer().getSubtitle(widget.dropdownType, selectedItem) : '',
                      style: const TextStyle(fontSize: 11, color: Colors.black87),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: isListTileView,
              child: Text(
                isListTileView ? SelectedItemValueDeterminer().getTrailing(widget.dropdownType, selectedItem) : '',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black),
              ),
            ),
            const SizedBox(width: 12),
            GestureDetector(
              onTap: () {
                context.read<ShareReviewBloc>().add(UpdateDropdownSelectedItem(dropdownType: widget.dropdownType, selectedItem: {}));
                _controller.clear();
                _focusNode.requestFocus();
              },
              child: const Icon(Icons.close_rounded, color: Colors.grey, size: 18),
            ),
            const SizedBox(width: 8),
            const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey, size: 24),
          ],
        ),
      ),
    );
  }
}
