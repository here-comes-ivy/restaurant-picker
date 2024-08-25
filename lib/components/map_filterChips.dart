import 'package:flutter/material.dart';

class FilterChip extends StatelessWidget {
  FilterChip({required this.label, this.avatar});
  String label;
  Widget? avatar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right:6.0),
      child: Chip(
        avatar: avatar,
        label: Text(label),
        backgroundColor: Colors.grey[50],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }

}


class SearchFilterChips extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          FilterChip(label: 'RestayrantType'),
          FilterChip(label: 'Distance'),
          FilterChip(label: 'OpeningHour'),
          FilterChip(label: 'Price Range'),
        ],
      ),
    );

  }
}
