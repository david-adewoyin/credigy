import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/app_model.dart';
import 'package:credigy/models/inventory_model.dart';
import 'package:credigy/styles.dart';
import 'package:credigy/views/home/tabs/inventory/add_inventory_page.dart';
import 'package:credigy/views/home/tabs/inventory/modify_inventory_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class InventoryTab extends StatelessWidget {
  static const routeName = "/inventory";
  List<Widget> inventoryWidget = [];
  InventoryTab({Key? key}) : super(key: key);

  final Widget emptyInventory = Container(
    color: Colors.white,
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/images/store.png",
            width: 100,
          ),
          SizedBox(height: 20),
          Text(
            "You have no item in Inventory",
            style: TextStyles.subtitle,
            textAlign: TextAlign.center,
          )
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    AppModel app = context.watch<AppModel>();
    List<InventoryModel> inventory = app.inventory();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Inventory",
          style: TextStyles.subtitle.boldest.withSize(22),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.maybeOf(context)!
              .push(MaterialPageRoute(builder: (context) {
            return AddInventoryPage();
          }));
        },
        child: Icon(Icons.add),
      ),
      body: inventory.isEmpty
          ? emptyInventory
          : InventoryItemsContainer(inventory: inventory),
    );
  }
}

class InventoryItemsContainer extends StatefulWidget {
  final List<InventoryModel> inventory;
  const InventoryItemsContainer({
    Key? key,
    required this.inventory,
  }) : super(key: key);

  @override
  State<InventoryItemsContainer> createState() =>
      _InventoryItemsContainerState();
}

class _InventoryItemsContainerState extends State<InventoryItemsContainer> {
  List<Widget> buildInventoryItem(List<InventoryModel> products) {
    List<Widget> wids = [];
    for (var p in products) {
      wids.add(InventoryItemWidget(product: p));
    }

    return wids;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      child: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(),
            elevation: 2,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    border:
                        Border(bottom: BorderSide(color: Colors.grey.shade300)),
                  ),
                  padding: EdgeInsets.only(left: 5, top: 3, bottom: 3),
                  child: DropdownButtonFormField<String>(
                    style: TextStyles.subtitleSm.withColor(Colors.black),
                    decoration: InputDecoration(
                      constraints: BoxConstraints.loose(Size(120, 200)),
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.withOpacity(0)),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    icon: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        )),
                    value: "oldest",
                    items: [
                      DropdownMenuItem(
                          value: "oldest",
                          child: Text(
                            "Oldest",
                            style: TextStyles.subtitleSm,
                          )),
                      DropdownMenuItem(value: "newest", child: Text("Newest"))
                    ],
                    onChanged: (v) {
                      if (v == "newest") {
                        setState(() {
                          widget.inventory
                              .sort((a, b) => b.id!.compareTo(a.id!));
                        });
                      } else if (v == "oldest") {
                        setState(() {
                          widget.inventory
                              .sort((a, b) => a.id!.compareTo(b.id!));
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          ...buildInventoryItem(widget.inventory),
        ],
      ),
    );
  }
}

class InventoryItemWidget extends StatelessWidget {
  final InventoryModel product;
  InventoryItemWidget({
    required this.product,
    Key? key,
  }) : super(key: key);

  final _currency = NumberFormat.simpleCurrency(name: "NGN").currencySymbol;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 2,
        onPrimary: Colors.black,
        primary: Colors.white,
        shape: RoundedRectangleBorder(),
      ),
      onPressed: () {
        Navigator.maybeOf(context)!.push(MaterialPageRoute(builder: (context) {
          return ModifyInventoryPage(product: product);
        }));
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade200,
            ),
          ),
        ),
        padding: EdgeInsets.only(top: 12, right: 10, left: 0, bottom: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.purpleAccent.withOpacity(0.2),
                  ),
                  child: Text(
                    "${product.productName.characters.first}",
                    style: TextStyles.subtitleSm,
                  ),
                ),
                SizedBox(width: 15),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${product.productName}",
                              style: TextStyles.subtitleSm.sizePlus,
                            ),
                            SizedBox(height: 8),
                            if (product.costPrice > 0) ...[
                              Text.rich(TextSpan(
                                  text: "Cost Price: ",
                                  style: TextStyles.body
                                      .withColor(Colors.grey.shade600),
                                  children: [
                                    TextSpan(
                                        text: _currency,
                                        style: TextStyles.moneyBody),
                                    TextSpan(
                                        text: " ${product.costPrice}",
                                        style: TextStyles.body
                                            .withColor(Colors.grey.shade600))
                                  ])),
                              SizedBox(height: 5),
                            ],
                            Text.rich(
                              TextSpan(
                                text: "Selling Price: ",
                                style: TextStyles.body
                                    .withColor(Colors.grey.shade600),
                                children: [
                                  TextSpan(
                                      text: _currency,
                                      style: TextStyles.moneyBody),
                                  TextSpan(
                                      text: " ${product.sellingPrice}",
                                      style: TextStyles.body
                                          .withColor(Colors.grey.shade600))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                  ],
                ),
                SizedBox(width: 13),
                Spacer(),
                if (product.quantity != null) ...[
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                    decoration: BoxDecoration(
                        color: product.quantity! < 3
                            ? Colors.red.withOpacity(0.1)
                            : Colors.green.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(100)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (product.quantity! < 3) ...[
                          Icon(
                            Icons.notification_important,
                            size: 16,
                            color: Colors.red,
                          ),
                        ],
                        Text(
                          "${product.quantity}",
                          style: TextStyles.subtitle.withColor(
                            product.quantity! < 3
                                ? Colors.red
                                : Colors.green.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
