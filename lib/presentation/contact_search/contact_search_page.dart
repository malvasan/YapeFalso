import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ContactSearchPage extends StatelessWidget {
  const ContactSearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
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
  @override
  Widget build(BuildContext context) {
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
              child: TextField(
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Ingresa el celular o busca contacto',
                    border: InputBorder.none),
                onChanged: (value) {},
              ),
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) {
            return const ContactCard();
          },
          childCount: 10,
        ))
      ],
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({super.key});
  //TODO: use the data retrieved and use it
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text('Full name'),
          subtitle: const Text('Full date'),
          onTap: () {},
        ),
        const Divider(
          indent: 10,
          endIndent: 10,
        ),
      ],
    );
  }
}
