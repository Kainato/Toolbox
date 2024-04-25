import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toolbox/classes/toolbox_navigator.dart';
import 'package:toolbox/enums/drawer_itens.dart';
import 'package:toolbox/classes/Models/quotes_model.dart';
import 'package:toolbox/firebase_service.dart';
import 'package:toolbox/pages/quotes/create_daily_quotes.dart';
import 'package:toolbox/widgets/components/transparent_divider.dart';
import 'package:toolbox/widgets/layouts/background_view.dart';

class ListDailyQuotes extends StatelessWidget {
  const ListDailyQuotes({super.key});

  @override
  Widget build(BuildContext context) {
    List<PhrasesModel> data = [];
    return BackgroundView(
      currentPage: DrawerKeys.quotes,
      title: 'Frases do dia',
      fabTooltip: 'Adicionar frase',
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      onFABPressed: () => ToolBoxNavigator.push(
        context,
        const CreateDailyQuotes(),
      ),
      children: [
        Flexible(
          child: StreamBuilder<QuerySnapshot<Object?>>(
            stream: FirebaseService().getPhrases(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Text(
                      'Tivemos um problema, tente novamente mais tarde!',
                      textAlign: TextAlign.center,
                    ),
                    const TransparentDivider(),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data.docs.isEmpty) {
                return const Center(
                  child: Text('Nenhuma frase encontrada!'),
                );
              } else {
                data = snapshot.data.docs
                    .map<PhrasesModel>(
                        (doc) => PhrasesModel.fromJson(doc.data()))
                    .toList();
                return ListView.builder(
                  itemCount: data.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Dismissible(
                        key: Key(data[index].id),
                        direction: DismissDirection.startToEnd,
                        confirmDismiss: (direction) async {
                          final messenger = ScaffoldMessenger.of(context);
                          await showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AlertDialog(
                                title: const Text('Atenção!'),
                                content: const Text(
                                  'Deseja realmente excluir esta frase?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(dialogContext).pop(),
                                    child: const Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop(true);
                                    },
                                    child: const Text('Excluir'),
                                  ),
                                ],
                              );
                            },
                          ).whenComplete(
                            () => messenger.showSnackBar(
                              SnackBar(
                                content: const Text('Frase excluída!'),
                                backgroundColor:
                                    Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          );
                          return true;
                        },
                        onDismissed: (direction) =>
                            FirebaseService().deletePhrase(data[index].id),
                        background: Container(
                          color: Theme.of(context).colorScheme.error,
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(left: 16.0),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: AutoSizeText(
                            '"${data[index].description}"',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                          ),
                          subtitle: Text(
                            data[index].source == ''
                                ? '~ ${data[index].author.toString()}'
                                : '~ ${data[index].source.toString()}, ${data[index].author.toString()}',
                            textAlign: TextAlign.end,
                          ),
                          leading: CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            child: Text(
                              (index + 1).toString(),
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
            },
          ),
        )
      ],
    );
  }
}
