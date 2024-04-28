import 'dart:math';
import 'dart:developer' as developer;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:toolbox/classes/Models/quotes_model.dart';
import 'package:toolbox/classes/toolbox_config.dart';
import 'package:toolbox/classes/toolbox_navigator.dart';
import 'package:toolbox/enums/drawer_itens.dart';
import 'package:toolbox/firebase_service.dart';
import 'package:toolbox/pages/quotes/list_quotes.dart';
import 'package:toolbox/widgets/components/transparent_divider.dart';
import 'package:toolbox/widgets/layouts/background_view.dart';
import 'package:share_plus/share_plus.dart';

class ShowDailyQuotes extends StatefulWidget {
  const ShowDailyQuotes({super.key});

  @override
  State<ShowDailyQuotes> createState() => _ShowDailyQuotesState();
}

class _ShowDailyQuotesState extends State<ShowDailyQuotes> {
  bool liked = false;
  PhrasesModel? randomData;
  @override
  Widget build(BuildContext context) {
    return BackgroundView(
      currentPage: DrawerKeys.quotes,
      title: 'Citações',
      fabIcon: Icons.replay,
      fabTooltip: 'Carregar nova citação',
      onFABPressed: () => setState(() {
        randomData = null;
        liked = false;
      }),
      actions: [
        IconButton(
          onPressed: () {
            ToolBoxNavigator.push(context, const ListDailyQuotes());
          },
          icon: const Icon(Icons.list_alt_rounded),
        ),
      ],
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
              } else if (randomData == null &&
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data.docs.isEmpty) {
                return const Center(
                  child: Text('Nenhuma citação encontrada!'),
                );
              } else {
                // ignore: prefer_conditional_assignment
                if (randomData == null) {
                  randomData = PhrasesModel.fromJson(
                    snapshot
                        .data.docs[Random().nextInt(snapshot.data.docs.length)]
                        .data() as Map<String, dynamic>,
                  );
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    AutoSizeText(
                      '"${randomData!.description}"',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      maxLines: 5,
                      softWrap: true,
                      presetFontSizes: const [32, 28, 24, 20, 18, 16, 14, 12],
                    ),
                    const TransparentDivider(),
                    AutoSizeText(
                      randomData!.source == ''
                          ? '~ ${randomData!.author.toString()}'
                          : '~ ${randomData!.source.toString()}, ${randomData!.author.toString()}',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                      presetFontSizes: const [20, 18, 16, 14, 12, 10],
                    ),
                    const TransparentDivider(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () => _shareQuote(context, randomData!),
                          icon: const Icon(Icons.share_outlined),
                        ),
                        TextButton.icon(
                          onPressed: () => _disLikeQuote(randomData!),
                          label: Text(
                            liked
                                ? (randomData!.likes + 1).toString()
                                : randomData!.likes.toString(),
                            style: TextStyle(
                              color: liked
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.onSurface,
                              fontWeight:
                                  liked ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                          icon: Icon(
                            liked
                                ? Icons.favorite
                                : Icons.favorite_border_outlined,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ],
    );
  }

  _disLikeQuote(PhrasesModel data) {
    setState(() => liked = !liked);
    FirebaseService().likePhrase(
      author: data.author,
      description: data.description,
      source: data.source,
      createdAt: data.createdAt,
      like: !liked ? data.likes - 1 : data.likes + 1,
      id: data.id,
    );
  }

  _shareQuote(BuildContext quoteContext, PhrasesModel data) async {
    final ScaffoldMessengerState messenger = ScaffoldMessenger.of(quoteContext);
    final ColorScheme theme = Theme.of(quoteContext).colorScheme;
    String title = 'Olha esta citação que encontrei!';
    String subtitle = '"${data.description}"';
    String likes = '- Ela já teve ${data.likes} curtidas!';
    String author = '- Autor(a): ${data.author}';
    String source = data.source == '' ? '' : '- Fonte: ${data.source}';

    messenger.showSnackBar(
      ToolBoxConfig.getSnackBar(
        content: 'Compartilhando a citação...',
        backgroundColor: theme.secondary,
        duration: 2,
      ),
    );
    final result = await Share.share(
      '$title\n\n$subtitle\n\n$likes\n$author\n$source',
      subject: 'Citação do dia',
    ).catchError(
      (error) {
        developer.log(error.toString());
        return ShareResult(
          error.toString(),
          ShareResultStatus.unavailable,
        );
      },
    );

    if (result.status == ShareResultStatus.success) {
      messenger.showSnackBar(
        ToolBoxConfig.getSnackBar(
          content: 'Citação compartilhada com sucesso!',
          backgroundColor: theme.secondary,
        ),
      );
    } else {
      messenger.showSnackBar(
        ToolBoxConfig.getSnackBar(
          content: 'Erro ao compartilhar a citação!',
          backgroundColor: theme.error,
        ),
      );
    }
  }
}
