import 'package:credigy/components/textfield.dart';
import 'package:credigy/models/app_model.dart';
import 'package:credigy/models/customer_model.dart';
import 'package:credigy/styles.dart';
import 'package:credigy/views/home/bottomsheets/add_customer_bottomsheet.dart';
import 'package:credigy/views/home/tabs/more/modify_customer_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomersPage extends StatelessWidget {
  static const routeName = "/Customer";
  List<Widget> customersWidget = [];
  CustomersPage({Key? key}) : super(key: key);

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
            "You haven't added a Customer",
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
    List<CustomerModel> customers = app.customers();

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        foregroundColor: Colors.black,
        elevation: 1,
        backgroundColor: Colors.white,
        title: Text(
          "Customers List",
          style: TextStyles.subtitle.boldest.withSize(22),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return const AddCustomerBottomSheet();
              });
        },
        child: Icon(Icons.add),
      ),
      body: customers.isEmpty
          ? emptyList
          : CustomersItemsContainer(customers: customers),
    );
  }
}

class CustomersItemsContainer extends StatefulWidget {
  final List<CustomerModel> customers;
  const CustomersItemsContainer({
    Key? key,
    required this.customers,
  }) : super(key: key);

  @override
  State<CustomersItemsContainer> createState() =>
      _CustomersItemsContainerState();
}

class _CustomersItemsContainerState extends State<CustomersItemsContainer> {
  List<Widget> buildCustomerItem(List<CustomerModel> customers) {
    List<Widget> wids = [];
    for (var c in customers) {
      wids.add(CustomerItemWidget(customer: c));
    }

    return wids;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 1, vertical: 5),
      child: ListView(
        children: [
          ...buildCustomerItem(widget.customers),
        ],
      ),
    );
  }
}

class CustomerItemWidget extends StatelessWidget {
  final CustomerModel customer;
  const CustomerItemWidget({
    required this.customer,
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
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: Colors.purpleAccent.withOpacity(0.2),
                  ),
                  child: Text(
                    "${customer.name.characters.first}",
                    style: TextStyles.subtitleSm,
                  ),
                ),
                SizedBox(width: 10),
                Flexible(
                  child: ListTile(
                    iconColor: Colors.pink,
                    contentPadding: EdgeInsets.symmetric(vertical: 0),
                    onTap: () {
                      Navigator.maybeOf(context)!
                          .push(MaterialPageRoute(builder: (context) {
                        return ModifyCustomerPage(Customer: customer);
                      }));
                    },
                    title: Text(customer.name, style: TextStyles.subtitleSm),
                    subtitle: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (customer.email != null &&
                            customer.email!.length > 3) ...[
                          SizedBox(height: 5),
                          Text(
                            "${customer.email}",
                            style: TextStyles.body,
                          ),
                          SizedBox(height: 5),
                        ],
                        if (customer.phone != null &&
                            customer.phone!.length > 3)
                          Text(
                            "${customer.phone}",
                            style: TextStyles.body,
                          ),
                      ],
                    ),
                    trailing: Icon(Icons.chevron_right_rounded),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
