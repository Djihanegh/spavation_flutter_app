import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/core/utils/size_config.dart';
import 'package:spavation/features/salons/presentation/bloc/salon_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/utils/typedef.dart';
import '../../../../../salons/presentation/screens/filter_salons_by_text_screen.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  TextEditingController controller = TextEditingController();

  // for search debounce
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(left: sw! * 0.025, right: sw! * 0.025),
      child: SizedBox(
        width: sw! * 0.935,
        height: sh! * 0.05,
        child: TextField(
          controller: controller,
          onChanged: (e) => _searchSalons(e),
          textAlign: TextAlign.start,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                /*   context
                    .read<SalonBloc>()
                    .add(SearchSalonsEvent(controller.text));
                navigateToPage(
                    FilterSalonsByTextScreen(text: controller.text), context);*/
              },
            ),
            contentPadding:
                const EdgeInsets.only(left: 10, top: 0, right: 0, bottom: 0),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            hintText: l10n.search,
            hintStyle:
                TextStyles.inter.copyWith(color: appLightGrey, fontSize: 16),
          ),
        ),
      ),
    );
  }

  void _searchSalons(String e) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (controller.text.isEmpty) {
        DataMap query = context.read<SalonBloc>().state.filterOptions ?? {};
        context.read<SalonBloc>().add(GetSalonsEvent(query));
      } else {
        context.read<SalonBloc>().add(SearchSalonsEvent(e));
      }
    });
  }
}
