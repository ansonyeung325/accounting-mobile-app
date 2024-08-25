import 'package:bloc_project/model/keepbook.dart';
import 'package:bloc_project/providers/app_store.dart';
import 'package:bloc_project/utiles/logger.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class Layout extends StatefulWidget {
  final Widget child;

  const Layout({super.key, required this.child});

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStore>(builder: (context, appStore, child) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              DropdownButtonHideUnderline(
                child: DropdownButton2<KeepBook>(
                    onChanged: (keepBook) {
                      if (keepBook == null) {
                        logger('Layout', 'DropDownButtonOnChanged', 'Add new keepBook');
                        return;
                      }

                    },
                    dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    )),
                    buttonStyleData: ButtonStyleData(
                        decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    )),
                    value: appStore.currentKeepBook,
                    items: [
                      ...appStore.keepBooks.map(
                        (keepBook) => DropdownMenuItem(
                          value: keepBook,
                          onTap: () {},
                          child: Text(keepBook.name),
                        ),
                      ),
                      DropdownMenuItem(
                        value: null,
                        onTap: () {},
                        child: const Text('Add New'),
                      ),
                    ]),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: 'keepbook'),
            BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'calendar'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'setting'),
          ],
          currentIndex: tabIndex,
          onTap: (index) {
            setState(() {
              tabIndex = index;
            });
            switch (index) {
              case (0):
                context.go('/');
                break;
              case (1):
                context.go('/calendar');
                break;
              case (2):
                context.go('/setting');
                break;
            }
          },
        ),
        body: widget.child,
        // floatingActionButton: Container(
        //   decoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle, boxShadow: [
        //     BoxShadow(blurRadius: 4, spreadRadius: 1, blurStyle: BlurStyle.solid, color: Colors.grey)
        //   ]),
        //   child: IconButton(
        //     onPressed: () {},
        //     icon: Icon(Icons.add),
        //   ),
        // ),
      );
    });
  }
}
