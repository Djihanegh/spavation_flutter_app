import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spavation/core/utils/constant.dart';
import 'package:spavation/core/widgets/loading_widget.dart';
import 'package:spavation/features/categories/presentation/bloc/category_bloc.dart';
import 'package:spavation/features/categories/presentation/screens/widgets/category_item.dart';

import '../../../../app/theme.dart';
import '../../../../core/utils/size_config.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.lat, required this.long});

  final double lat;
  final double long;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late CategoryBloc _categoryBloc;

  @override
  void initState() {
    _categoryBloc = BlocProvider.of(context)..add(const GetCategoriesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {},
        //  listenWhen: (prev, curr) => prev.status != curr.status,
        //  buildWhen: (prev, curr) => prev.status != curr.status,
        builder: (context, state) {
          return Positioned(
              top: sh! * 0.37,
              left: sw! * 0.03,
              right: sw! * 0.03,
              child: Container(
                width: sw! * 0.935,
                height: sh! * 0.12,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: boxShadow),
                child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: _buildItem(state)),
              ));
        });
  }

  Widget _buildItem(CategoryState state) {
    Widget child = emptyWidget();
    if (state is CategoryLoadDataSuccessState) {
      child = ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 10, right: 10),
          itemCount: state.categories.length ,
          itemBuilder: (context, index) => CategoryItem(
              nameAr: state.categories[index].nameAr ,
              lat: widget.lat,
              long: widget.long,
              categoryId: "${state.categories[index].id}",
              image: state.categories[index].image ,
              title: state.categories[index].name ,
              color: Colors.transparent));
    }
    if (state is CategoryLoadDataFailureState) {
      child =
         const Center(child: Icon(Icons.error));
    }
    if (state is CategoryInProgressState) child = const LoadingWidget(color: appPrimaryColor,);
    return child;
  }
}
