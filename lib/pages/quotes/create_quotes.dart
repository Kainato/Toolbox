import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:toolbox/classes/toolbox_config.dart';
import 'package:toolbox/firebase_service.dart';
import 'package:toolbox/widgets/components/transparent_divider.dart';
import 'package:toolbox/widgets/layouts/background_view.dart';

class CreateDailyQuotes extends StatefulWidget {
  const CreateDailyQuotes({super.key});

  @override
  State<CreateDailyQuotes> createState() => _CreateDailyQuotesState();
}

class _CreateDailyQuotesState extends State<CreateDailyQuotes> {
  TextEditingController authorController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController sourceController = TextEditingController();
  final GlobalKey formKey = GlobalKey<FormState>();
  bool desconhecidoFonte = false;
  bool desconhecidoAuthor = false;

  @override
  Widget build(BuildContext context) {
    return BackgroundView(
      title: 'Criar citação',
      fabIcon: Icons.save,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: ToolBoxConfig.getScreenHeightPadding(context),
          child: Form(
            key: formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
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
                  enabled: !desconhecidoFonte,
                  controller: sourceController,
                  decoration: const InputDecoration(
                    labelText: 'Inserir fonte',
                    hintText: 'Digite a fonte da citação',
                  ),
                ),
                const TransparentDivider(),
                CheckboxListTile(
                  dense: true,
                  title: const Text('Fonte desconhecida?'),
                  value: desconhecidoFonte,
                  activeColor: Theme.of(context).colorScheme.secondary,
                  onChanged: (newValue) {
                    desconhecidoFonte = !desconhecidoFonte;
                    log(desconhecidoFonte.toString());
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
              source: desconhecidoFonte ? '' : sourceController.text,
              id: '${DateTime.now().millisecondsSinceEpoch.toString()}+${desconhecidoAuthor ? 'Desconhecido' : authorController.text}',
            )
                .whenComplete(
              () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  ToolBoxConfig.getSnackBar(
                    content: 'Citação criada com sucesso!',
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                  ),
                );
              },
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              ToolBoxConfig.getSnackBar(
                content: 'Erro ao criar citação',
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            ToolBoxConfig.getSnackBar(
              content: 'Por favor, preencha todos os campos!',
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      },
    );
  }
}
