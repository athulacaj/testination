import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final Function onClick;
  final String title;
  final selectedFilter;
  FilterButton({this.onClick, this.title, this.selectedFilter});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 6),
      child: FlatButton(
        color: selectedFilter == title
            ? Colors.green
            : Colors.grey.withOpacity(0.13),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          height: 45,
          child: Text('$title'),
        ),
        onPressed: () {
          onClick();
        },
      ),
    );
  }
}
