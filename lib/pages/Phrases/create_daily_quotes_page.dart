import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:toolbox/firebase_service.dart';
import 'package:toolbox/widgets/components/TransparentDivider.dart';
import 'package:toolbox/widgets/layouts/BackgroundPage.dart';

class CreateDailyPhrasesPage extends StatefulWidget {
  const CreateDailyPhrasesPage({super.key});

  @override
  State<CreateDailyPhrasesPage> createState() => _CreateDailyPhrasesPageState();
}

class _CreateDailyPhrasesPageState extends State<CreateDailyPhrasesPage> {
  TextEditingController authorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  final GlobalKey formKey = GlobalKey<FormState>();
  bool desconhecidoOrigem = false;
  bool desconhecidoAuthor = false;

  @override
  Widget build(BuildContext context) {
    return BackgroundPage(
      title: 'Criar citação',
      fabIcon: Icons.save,
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 150,
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Criar citação',
                  hintText: 'Digite a citação',
                ),
                validator: (value) {
                  if (value == null || value == '') {
                    return 'Por favor, insira a citação';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              ),
              const TransparentDivider(),
              TextFormField(
                maxLength: 50,
                enabled: !desconhecidoOrigem,
                controller: sourceController,
                decoration: const InputDecoration(
                  labelText: 'Inserir origem',
                  hintText: 'Digite a origem da citação',
                ),
              ),
              CheckboxListTile(
                dense: true,
                title: const Text('Origem desconhecida?'),
                value: desconhecidoOrigem,
                activeColor: Theme.of(context).colorScheme.secondary,
                onChanged: (newValue) {
                  desconhecidoOrigem = !desconhecidoOrigem;
                  log(desconhecidoOrigem.toString());
                  setState(() {});
                },
              ),
              const TransparentDivider(),
              TextFormField(
                maxLength: 30,
                enabled: !desconhecidoAuthor,
                controller: authorController,
                decoration: const InputDecoration(
                  labelText: 'Inserir autor',
                  hintText: 'Digite o autor da citação',
                ),
                validator: (value) {
                  if (!desconhecidoAuthor && (value == null || value == '')) {
                    return 'Por favor, insira o autor da citação';
                  }
                  return null;
                },
              ),
              const TransparentDivider(),
              CheckboxListTile(
                dense: true,
                title: const Text('Autor desconhecido?'),
                value: desconhecidoAuthor,
                activeColor: Theme.of(context).colorScheme.secondary,
                onChanged: (newValue) {
                  desconhecidoAuthor = !desconhecidoAuthor;
                  log(desconhecidoAuthor.toString());
                  setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
      onFABPressed: () {
        if ((formKey.currentState as FormState).validate()) {
          try {
            FirebaseService()
                .addPhrase(
              author:
                  desconhecidoAuthor ? 'Desconhecido' : authorController.text,
              description: descriptionController.text,
              source: desconhecidoOrigem ? '' : sourceController.text,
              id: '${DateTime.now().millisecondsSinceEpoch.toString()}+${desconhecidoAuthor ? 'Desconhecido' : authorController.text}',
            )
                .whenComplete(
              () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Citação criada com sucesso'),
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                );
              },
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Erro ao criar citação'),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Por favor, preencha todos os campos'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
    );
  }
}
