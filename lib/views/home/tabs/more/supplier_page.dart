import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/app_model.dart';
import 'package:credigy/models/supplier_model.dart';
import 'package:credigy/styles.dart';
import 'package:credigy/views/home/tabs/inventory/add_inventory_page.dart';
import 'package:credigy/views/home/bottomsheets/add_supplier_bottomsheet.dart';
import 'package:credigy/views/home/tabs/more/modify_supplier_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuppliersPage extends StatelessWidget {
  static const routeName = "/supplier";
  List<Widget> suppliersWidget = [];
  SuppliersPage({Key? key}) : super(key: key);

  final Widget emptyList = Container(
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
            "You haven't added a supplier",
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
    List<SupplierModel> suppliers = app.suppliers();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Suppliers List",
          style: TextStyles.subtitle.boldest.withSize(22),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const AddSupplierBottomSheet();
              });
        },
        child: Icon(Icons.add),
      ),
      body: suppliers.isEmpty
          ? emptyList
          : SuppliersItemsContainer(suppliers: suppliers),
    );
  }
}

class SuppliersItemsContainer extends StatefulWidget {
  final List<SupplierModel> suppliers;
  const SuppliersItemsContainer({
    Key? key,
    required this.suppliers,
  }) : super(key: key);

  @override
  State<SuppliersItemsContainer> createState() =>
      _SuppliersItemsContainerState();
}

class _SuppliersItemsContainerState extends State<SuppliersItemsContainer> {
  List<Widget> buildSupplierItem(List<SupplierModel> suppliers) {
    List<Widget> wids = [];
    for (var s in suppliers) {
      wids.add(SupplierItemWidget(supplier: s));
    }

    return wids;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      child: ListView(
        children: [
          ...buildSupplierItem(widget.suppliers),
        ],
      ),
    );
  }
}

class SupplierItemWidget extends StatelessWidget {
  final SupplierModel supplier;
  const SupplierItemWidget({
    required this.supplier,
    Key? key,
  }) : super(key: key);

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
        /*   Navigator.maybeOf(context)!.push(MaterialPageRoute(builder: (context) {
            return ModifyInventoryPage(product: product); 
        })); */
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
            ListTile(
              iconColor: Colors.pink,
              contentPadding: EdgeInsets.symmetric(vertical: 0),
              onTap: () {
                Navigator.maybeOf(context)!
                    .push(MaterialPageRoute(builder: (context) {
                  return ModifySupplierPage(supplier: supplier);
                }));
              },
              title: Text(supplier.name, style: TextStyles.subtitleSm),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (supplier.email != null && supplier.email!.length > 3) ...[
                    SizedBox(height: 5),
                    Text(
                      "${supplier.email}",
                      style: TextStyles.body,
                    ),
                    SizedBox(height: 5),
                  ],
                  if (supplier.phone != null && supplier.phone!.length > 3)
                    Text(
                      "${supplier.phone}",
                      style: TextStyles.body,
                    ),
                ],
              ),
              trailing: Icon(Icons.chevron_right_rounded),
            )
          ],
        ),
      ),
    );
  }
}
