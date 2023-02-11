import 'package:flutter/cupertino.dart';

class PageViewCard extends StatelessWidget {
  const PageViewCard({required this.page, super.key});

  final String page;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      height: 35,
      child: Center(child: Text(page)),
    );
  }
}
