import 'package:fit_gate/controller/map_controller.dart';
import 'package:flutter/material.dart';

import '../utils/custom_number_pagination.dart';
import '../utils/my_color.dart';

class PaginationWidget extends StatelessWidget {
  final Function(int)? onPageChanged;
  final int? pageInit;
  final int? pageTotal;
  PaginationWidget({this.onPageChanged, this.pageInit, this.pageTotal});

  @override
  Widget build(BuildContext context) {
    return NumberPagination(
      onPageChanged: onPageChanged!,
      pageTotal: pageTotal!,
      pageInit: pageInit!,
      colorPrimary: MyColors.orange,
      colorSub: MyColors.black,
      iconNext: Icon(
        Icons.arrow_forward_ios,
        size: 20,
      ),
      iconPrevious: Icon(Icons.arrow_back_ios_rounded, size: 20),
      threshold: 5,
      fontSize: 18,
    );
  }
}

class AllPaginationWidget extends StatefulWidget {
  final MapController searchGym;
  final String? s;
  const AllPaginationWidget({required this.searchGym, this.s});

  @override
  _AllPaginationWidgetState createState() => _AllPaginationWidgetState();
}

class _AllPaginationWidgetState extends State<AllPaginationWidget> {
  changePage() {
    return NumberPagination(
      onPageChanged: (val) {
        widget.searchGym.searchList.clear();
        setState(() {
          widget.searchGym.nextPage = val;
        });
        widget.searchGym.getLocation(search: widget.s);
      },
      pageTotal: widget.searchGym.paginationData.totalPages!,
      pageInit: widget.searchGym.nextPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return changePage();
  }
}
