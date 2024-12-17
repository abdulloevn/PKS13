import 'package:flutter/material.dart';
import 'package:pks_sem5_p8/main.dart';
import 'package:pks_sem5_p8/models/search_result.dart';

class SearchPreview extends StatelessWidget {
  const SearchPreview({super.key, required this.searchResult});
  final SearchResult searchResult;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                  appData.shopItems[searchResult.itemIndex].ImageHref,
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width / 2,
                  fit: BoxFit.cover)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${appData.shopItems[searchResult.itemIndex].PriceRubles.toString()} руб.",
                    style: const TextStyle(color: Colors.green, fontWeight: FontWeight.w600),),
                    RichText(
                      text: TextSpan(children: searchResult.searchPreview),
                      
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
