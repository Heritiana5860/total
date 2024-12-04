import 'package:flutter/material.dart';
import 'package:total_app/components/my_text.dart';
import 'package:total_app/components/my_text_field.dart';
import 'package:total_app/models/total_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final itemController = TextEditingController();
  final priceController = TextEditingController();

  List<TotalModel> data = [];
  List<TotalModel> allData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const MyText(text: "Total App"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextField(
              hintText: "Item",
              label: const MyText(text: "Item"),
              controller: itemController,
              vertical: 10.0,
              horizontal: 24.0,
              icon: Icons.close,
              onPressed: () => itemController.clear(),
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
                Padding(
                  padding: const EdgeInsets.only(right: 24.0),
                  child: IconButton(
                    onPressed: () {
                      allData.add(
                        TotalModel(
                          item: itemController.text,
                          price: double.parse(priceController.text),
                        ),
                      );

                      setState(() {
                        itemController.clear();
                        priceController.clear();
                      });

                      final dt = allData.map((e) => e.toMap());
                      debugPrint("$dt");
                    },
                    icon: const Icon(
                      Icons.keyboard_return_rounded,
                      size: 32.0,
                    ),
                  ),
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
              columns: const [
                DataColumn(
                  label: MyText(text: "Item"),
                ),
                DataColumn(
                  label: MyText(text: "Price"),
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
                        text: element.price.toString(),
                      ),
                    ),
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
                        text: "${allData.fold(0.0, (prev, element) => prev + element.price).toString()} Ar"
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
}
