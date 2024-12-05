import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:total_app/components/my_text.dart';
import 'package:total_app/components/my_text_field.dart';
import 'package:total_app/models/total_model.dart';
import 'package:total_app/services/helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final itemController = TextEditingController();
  final priceController = TextEditingController();
  final searchController = TextEditingController();

  List<TotalModel> allData = [];
  late StreamSubscription<List<TotalModel>> _streamSubscription;

  bool isSearched = false;
  bool isEdited = false;

  int? selectedId;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  @override
  void dispose() {
    super.dispose();
    _streamSubscription.cancel();
  }

  StreamSubscription<List<TotalModel>> _refresh() {
    _streamSubscription = Helper.getAllData().listen((data) {
      setState(() {
        allData = data;
      });
    });
    return _streamSubscription;
  }

  //Update function in class Helper called here
  Future<bool> callUdateDataFunction() async {
    try {
      if (selectedId == null) {
        debugPrint("Error: No ID selected for update.");
        return false;
      }

      final data = await Helper.updateData(TotalModel(
          id: selectedId,
          item: itemController.text,
          price: double.parse(priceController.text)));
      if (data) {
        debugPrint("Data updated successfully!");
        setState(() {
          isEdited = false;
        });
        return true;
      } else {
        debugPrint("Failed to update data.");
        return false;
      }
    } catch (e) {
      debugPrint("Error updating data: $e");
      return false;
    }
  }

  Future<bool> callDeleteFunctionData(int id) async {
    try {
      final data = await Helper.deleteData(id);
      if (!data) {
        debugPrint("Failed to delete data.");
        return false;
      }

      debugPrint("Data deleted successfully!");
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: isSearched
            ? Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: MyTextField(
                  hintText: "Search bar",
                  icon: Icons.close,
                  label: const MyText(text: "Search"),
                  controller: searchController,
                  onPressed: () => searchController.clear(),
                  onChanged: (p0) {},
                ),
              )
            : const MyText(
                text: "Total App",
                color: Colors.white,
              ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearched = !isSearched;
              });
            },
            icon: isSearched
                ? const Icon(
                    Icons.close_outlined,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              child: MyTextField(
                hintText: "Item",
                label: const MyText(text: "Item"),
                controller: itemController,
                vertical: 10.0,
                horizontal: 24.0,
                icon: Icons.close,
                onPressed: () => itemController.clear(),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: MyTextField(
                    keyboardType: TextInputType.number,
                    hintText: "Price",
                    label: const MyText(text: "Price"),
                    controller: priceController,
                    vertical: 10.0,
                    horizontal: 24.0,
                    icon: Icons.close,
                    onPressed: () => priceController.clear(),
                  ),
                ),

                ///Save button
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: saveButton(isEdited),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Divider(
                color: Colors.grey[200],
              ),
            ),
            DataTable(
              columnSpacing: 20,
              headingRowColor:
                  WidgetStateProperty.resolveWith((states) => Colors.grey[200]),
              columns: const [
                DataColumn(
                  label: MyText(text: "Item"),
                ),
                DataColumn(
                  label: MyText(text: "Price"),
                  numeric: true,
                ),
                DataColumn(
                  label: MyText(text: "Action"),
                ),
              ],
              rows: [
                ...allData.map(
                  (element) => DataRow(cells: [
                    DataCell(
                      MyText(
                        text: element.item,
                      ),
                    ),
                    DataCell(
                      MyText(
                        text:
                            NumberFormat.currency(locale: 'fr_MG', symbol: 'Ar')
                                .format(element.price),
                      ),
                    ),

                    ///Action buttons
                    DataCell(Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///Edit button
                        Tooltip(
                          message: 'Update',
                          child: IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ),
                            onPressed: () {
                              setState(() {
                                isEdited = true;
                                selectedId = element.id;
                                itemController.text = element.item;
                                priceController.text = "${element.price}";
                              });
                            },
                          ),
                        ),

                        ///Delete button
                        Tooltip(
                          message: 'Delete',
                          child: IconButton(
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const MyText(text: "Delete data"),
                                    content: const MyText(
                                        text:
                                            'Do you really want to delete data?'),
                                    actions: [
                                      TextButton(
                                        child: const MyText(text: 'Cancel'),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                      TextButton(
                                        child: const MyText(text: "Yes"),
                                        onPressed: () {
                                          callDeleteFunctionData(element.id!);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    )),
                  ]),
                ),
                DataRow(
                  cells: [
                    const DataCell(
                      MyText(
                        text: "Total amount:",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    DataCell(
                      MyText(
                        text: NumberFormat.currency(
                                locale: 'fr_MG', symbol: 'Ar')
                            .format(allData.fold(
                                0.0, (prev, element) => prev + element.price)),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const DataCell(
                      MyText(
                        text: "",
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconButton saveButton(bool isEdited) {
    return IconButton(
      onPressed: () async {
        if (isEdited) {
          await callUdateDataFunction();
        } else {
          await Helper.saveData(
            itemController.text,
            double.parse(priceController.text),
          );
        }

        setState(() {
          itemController.clear();
          priceController.clear();
        });
      },
      icon: isEdited
          ? const Icon(Icons.update)
          : const Icon(
              Icons.keyboard_return_rounded,
              size: 32.0,
            ),
    );
  }
}
