import 'package:flutter/material.dart';
import 'package:agenda/models/contact.dart';
import 'package:agenda/components/option_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;
  final void Function({Contact? contact}) showPageFunction;
  final void Function(Contact contact) deleteFunction;

  const ContactCard(this.contact,
      {required this.showPageFunction, required this.deleteFunction, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _showOptions() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return BottomSheet(
                onClosing: () {},
                builder: (context) {
                  return SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          OptionButton(
                            title: "Ligar",
                            pressedFunction: () {
                              launch('tel:${contact.phone ?? ''}');
                              Navigator.pop(context);
                            },
                          ),
                          OptionButton(
                            title: "Editar",
                            pressedFunction: () {
                              Navigator.pop(context);
                              showPageFunction(contact: contact);
                            },
                          ),
                          OptionButton(
                            title: "Excluir",
                            pressedFunction: () {
                              deleteFunction(contact);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                });
          });
    }

    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/person.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name ?? '',
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        contact.email ?? '',
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        contact.phone ?? '',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptions();
      },
    );
  }
}
