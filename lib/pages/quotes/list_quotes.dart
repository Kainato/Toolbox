import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:Toolbox/classes/toolbox_navigator.dart';
import 'package:Toolbox/classes/Models/quotes_model.dart';
import 'package:Toolbox/firebase_service.dart';
import 'package:Toolbox/pages/quotes/create_quotes.dart';
import 'package:Toolbox/widgets/components/card_list_tile.dart';
import 'package:Toolbox/widgets/components/transparent_divider.dart';
import 'package:Toolbox/widgets/layouts/background_view.dart';
import 'package:Toolbox/widgets/layouts/dialog_view.dart';

class ListDailyQuotes extends StatelessWidget {
  const ListDailyQuotes({super.key});

  @override
  Widget build(BuildContext context) {
    List<PhrasesModel> data = [];
    return BackgroundView(
      title: 'Lista de Citações',
      fabTooltip: 'Adicionar citação',
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
                  child: Text('Nenhuma citação encontrada!'),
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
                      child: CardListTile(
                        onLongPress: () => showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return DialogView(
                              title: 'Atenção!',
                              actions: [
                                ElevatedButton(
                                  child: const Text('Excluir'),
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop(true);
                                    FirebaseService()
                                        .deletePhrase(data[index].id);
                                  },
                                ),
                              ],
                              children: const [
                                Text('Deseja realmente excluir esta citação?'),
                              ],
                            );
                          },
                        ),
                        title: '"${data[index].description}"',
                        titleMaxLines: 2,
                        subtitle: data[index].source == ''
                            ? '~ ${data[index].author.toString()}'
                            : '~ ${data[index].source.toString()}, ${data[index].author.toString()}',
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
