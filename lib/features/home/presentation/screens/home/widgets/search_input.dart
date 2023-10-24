import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/app/theme.dart';
import 'package:spavation/core/utils/app_styles.dart';
import 'package:spavation/core/utils/navigation.dart';
import 'package:spavation/core/utils/size_config.dart';
import 'package:spavation/features/salons/presentation/bloc/salon_bloc.dart';

import '../../../../../salons/presentation/screens/filter_salons_by_text_screen.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key});

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: sw! * 0.025, right: sw! * 0.025),
      child: SizedBox(
        width: sw! * 0.935,
        height: sh! * 0.05,
        child: TextField(
          onSubmitted: (e) {
            context.read<SalonBloc>().add(SearchSalonsEvent(e));
            navigateToPage(const FilterSalonsByTextScreen(), context);
          },
          textAlign: TextAlign.start,
          cursorColor: Colors.grey,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.only(left: 10, top: 0, right: 0, bottom: 0),
            fillColor: Colors.white,
            filled: true,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            hintText: 'Search',
            hintStyle:
                TextStyles.inter.copyWith(color: appLightGrey, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
