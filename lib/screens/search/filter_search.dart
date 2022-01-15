import 'package:codephile/resources/colors.dart';
import 'package:codephile/services/institute_list.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class FilterSearch extends StatefulWidget {
  const FilterSearch({
    required this.selectedInstitute,
    Key? key,
  }) : super(key: key);

  final String selectedInstitute;
  @override
  _FilterSearchState createState() => _FilterSearchState();
}

class _FilterSearchState extends State<FilterSearch> {
  final List<String> _instituteList = [];
  bool isLoading = true;
  String? updatedFilter;

  @override
  void initState() {
    _instituteList.add('All');
    getInstituteList().then((instituteList) {
      setState(() {
        if (instituteList.isNotEmpty) {
          _instituteList.addAll(instituteList);
        } else {
          _instituteList.addAll([
            'Indian Institute of Technology Roorkee',
            'Indian Institute of Technology Delhi',
            'Indian Institute of Technology Mandi',
            'Indian Institute of Technology Indore',
            'Indian Institute of Technology Bombay'
          ]);
        }
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        height: 230,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              color: const Color(0xFFF3F4F7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      "Filters",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, updatedFilter);
                    },
                    child: const Text(
                      "Apply",
                      style: TextStyle(color: codephileMain),
                    ),
                  )
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(25, 25, 0, 25),
              child: Text(
                "Institutes",
                style: TextStyle(
                  color: Color(0xFF979797),
                  fontSize: 18.0,
                ),
              ),
            ),
            Visibility(
              visible: !isLoading,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  ),
                  child: DropdownSearch<String>(
                    showSearchBox: true,
                    selectedItem: widget.selectedInstitute,
                    items: _instituteList,
                    onChanged: (String? institute) {
                      setState(() {
                        updatedFilter = institute;
                      });
                    },
                    dropdownSearchDecoration: const InputDecoration(
                      hintText: 'Select Institute',
                      contentPadding: EdgeInsets.all(8.0),
                    ),
                  ),
                ),
              ),
              replacement: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
