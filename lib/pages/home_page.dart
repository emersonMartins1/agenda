import 'package:agenda/pages/contact_page.dart';
import 'package:flutter/material.dart';
import 'package:agenda/models/contact.dart';
import 'package:agenda/components/contact_card.dart';
import 'package:agenda/providers/database_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseProvider database = DatabaseProvider();
  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();

    _getAllContacts();
  }

  void _getAllContacts() {
    database.getAllContacts().then((list) {
      setState(() {
        contacts = list;
      });
    });
  }

  void _showContactPage({Contact? contact}) async {
    final recContact = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ContactPage(contact: contact)),
    );

    if (recContact != null) {
      if (contact != null) {
        await database.updateContact(recContact);
      } else {
        await database.saveContact(recContact);
      }

      _getAllContacts();
    }
  }

  void _deleteContact(Contact contact) {
    database.deleteContact(contact.id!);
    setState(() {
      contacts.removeAt(contacts.indexOf(contact));
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contatos'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContactPage();
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactCard(
            contacts[index],
            showPageFunction: _showContactPage,
            deleteFunction: _deleteContact,
          );
        },
      ),
    );
  }
}
