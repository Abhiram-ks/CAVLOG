import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_panel/core/themes/colors.dart';
import 'package:user_panel/core/utils/debouncer/debouncer.dart';
import 'package:user_panel/core/validation/input_validation.dart';
import '../../../../../core/common/custom_formfield_widget.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../../../../core/utils/image/app_images.dart';
import '../../../provider/bloc/fetch_allbarber_bloc/fetch_allbarber_bloc.dart';
import '../../../widget/search_widget/search_screen_widget/barbers_records_widget.dart';


class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with FormFieldMixin {
  final TextEditingController searchController = TextEditingController();
  final Debouncer debouncer = Debouncer(milliseconds: 100);
  String searchTerm = '';

    void _onSearchChanged(String searchTerm) {
    debouncer.run(() {
      context.read<FetchAllbarberBloc>().add(SearchBarbersRequested(searchTerm));
    });
  }
   
@override
Widget build(BuildContext context) {

  final screenHeight = MediaQuery.of(context).size.height;
  final screenWidth = MediaQuery.of(context).size.width;

  return AnnotatedRegion<SystemUiOverlayStyle>(
     value: SystemUiOverlayStyle.light,
    child: ColoredBox(
      color:AppPalette.blackClr,
      child: SafeArea(
        child: Scaffold(
          body: GestureDetector(
            onTap:() =>  FocusScope.of(context).unfocus(),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  backgroundColor:  AppPalette.blackClr,
                  expandedHeight: screenHeight * 0.14,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    titlePadding: EdgeInsets.only(left: screenWidth * 0.04),
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        Positioned.fill(
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              AppPalette.greyClr.withAlpha((0.19 * 230).toInt()),
                              BlendMode.modulate,
                            ),
                            child: Image.asset(
                              AppImages.loginImageBelow,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.04,
                            ),
                            child: buildTextFormField(
                              label: '',
                              hintText: 'Search shop...',
                              prefixIcon: Icons.search,
                              context: context,
                              controller: searchController,
                              validate: ValidatorHelper.serching,
                              borderClr: AppPalette.lightgreyclr,
                              fillClr: AppPalette.whiteClr,
                              isfilterFiled: true,
                              fillterAction: () {},
                               onChanged: _onSearchChanged,
                              
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
                  sliver: SliverToBoxAdapter(
                    child: ConstantWidgets.hight20(context),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03,
                  ),
                  sliver: BarberListBuilder(screenHeight: screenHeight, screenWidth: screenWidth),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
}
