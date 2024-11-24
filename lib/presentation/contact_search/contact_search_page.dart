import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:yapefalso/autoroute/autoroute.gr.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

@RoutePage()
class ContactSearchPage extends StatelessWidget {
  const ContactSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () => context.router.maybePop(),
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
          title: const Text('Yapear'),
          bottom: const TabBar(tabs: [
            Tab(
              text: 'Contactos',
            ),
            Tab(
              text: 'Yapeos Pendientes',
            ),
          ]),
        ),
        body: const TabBarView(children: [
          ContactsList(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.markunread_mailbox_outlined),
              Text('No hay Yapeos pendientes')
            ],
          ),
        ]),
      ),
    );
  }
}

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final controller = TextEditingController();
  List<Contact>? _contacts;
  List<Contact> _contactsFiltered = [];
  bool _permissionDenied = false;
  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission(readonly: true)) {
      setState(() => _permissionDenied = true);
    } else {
      final contacts = await FlutterContacts.getContacts(withProperties: true);
      setState(() => _contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_permissionDenied) {
      return const Center(child: Text('Permission denied'));
    }
    if (_contacts == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(
          child: Gap(10),
        ),
        SliverPinnedHeader(
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Card(
              elevation: 6,
              color: Theme.of(context).scaffoldBackgroundColor,
              child: ListTile(
                leading: const Icon(Icons.search),
                title: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Ingresa el celular o busca contacto',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    filter();
                  },
                ),
                trailing: IconButton(
                    onPressed: () {
                      controller.clear();
                      filter();
                    },
                    icon: const Icon(Icons.cancel)),
              ),
            ),
          ),
        ),
        if (controller.text.isEmpty && _contacts != null)
          SliverList.builder(
            itemCount: _contacts!.length,
            itemBuilder: (context, index) {
              return ContactCard(
                name: _contacts![index].displayName,
                phone: _contacts![index].phones.isNotEmpty
                    ? _contacts![index].phones.first.number
                    : '',
              );
            },
          )
        else
          SliverList.builder(
            itemCount: _contactsFiltered.length,
            itemBuilder: (context, index) {
              return ContactCard(
                name: _contactsFiltered[index].displayName,
                phone: _contactsFiltered[index].phones.isNotEmpty
                    ? _contactsFiltered[index].phones.first.number
                    : '',
              );
            },
          )
      ],
    );
  }

  void filter() {
    if (_contacts == null) {
      return;
    }
    _contactsFiltered.clear();
    if (controller.text.isEmpty) {
      setState(() {});
      return;
    }
    _contacts?.forEach(
      (element) {
        if (element.displayName
                .toLowerCase()
                .contains(controller.text.toLowerCase()) ||
            (element.phones.isNotEmpty &&
                element.phones.first.number
                    .replaceAll(' ', '')
                    .contains(controller.text.replaceAll(' ', '')))) {
          _contactsFiltered.add(element);
        }
      },
    );
    if (_contactsFiltered.isEmpty &&
        controller.text.replaceAll(' ', '').length == 9) {
      final newContact = Contact()
        ..displayName = 'A nuevo celular'
        ..phones = [Phone(controller.text)];
      _contactsFiltered.add(newContact);
    }
    setState(() {});
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({super.key, required this.name, required this.phone});
  final String name;
  final String phone;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            phone,
            style: TextStyle(
              color: Theme.of(context).disabledColor,
            ),
          ),
          trailing: name.contains('A nuevo celular')
              ? Icon(
                  Icons.ac_unit_sharp,
                  color: Theme.of(context).primaryColor,
                )
              : null,
          onTap: () => context.router
              .push(PaymentRoute(phone: int.parse(phone.replaceAll(' ', '')))),
        ),
        const Divider(
          indent: 16,
        ),
      ],
    );
  }
}
