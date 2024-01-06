import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:spavation/features/settings/presentation/screens/update_user/widgets/custom_text_field.dart';

import '../../../../../../localization.dart';

showRatingDialog(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        final l10n = AppLocalizations.of(context)!;

        return Directionality(
            textDirection:
                l10n.localeName == 'en' ? TextDirection.ltr : TextDirection.rtl,
            child: AlertDialog(
              content: Container(
                height: 300,
                width: 400,
                //  color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l10n.rate_text),
                    const SizedBox(
                      height: 10,
                    ),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextFormField(
                      maxlines: 5,
                      onSaved: () {},
                      onChanged: (e) {},
                    )
                  ],
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.cancel)),
                ElevatedButton(onPressed: () {}, child: Text(l10n.continueX)),
              ],
              actionsAlignment: l10n.localeName == 'en'
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
            ));
      });
}
