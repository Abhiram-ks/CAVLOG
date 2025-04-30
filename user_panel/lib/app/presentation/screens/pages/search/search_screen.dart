import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:user_panel/app/data/repositories/fetch_services_admin_repo.dart';
import 'package:user_panel/app/domain/usecases/voice_search_usecase.dart';
import 'package:user_panel/app/presentation/provider/bloc/fetching_bloc/fetch_admin_service_bloc/adimin_service_bloc.dart';
import 'package:user_panel/app/presentation/provider/cubit/select_service_cubit/select_service_cubit.dart';
import 'package:user_panel/core/themes/colors.dart';
import 'package:user_panel/core/utils/debouncer/debouncer.dart';
import 'package:user_panel/core/validation/input_validation.dart';
import '../../../../../core/common/custom_formfield_widget.dart';
import '../../../../../core/utils/constant/constant.dart';
import '../../../../../core/utils/image/app_images.dart';
import '../../../provider/bloc/fetching_bloc/fetch_allbarber_bloc/fetch_allbarber_bloc.dart';
import '../../../provider/cubit/filter_rating_cubit/filter_rating_cubit.dart';
import '../../../provider/cubit/gender_cubit/gender_option_cubit.dart';
import '../../../provider/cubit/voice_search_cubit/voice_search_cubit.dart';
import '../../../provider/cubit/voice_search_cubit/voice_search_state.dart';
import '../../../widget/search_widget/search_screen_widget/barbers_records_widget.dart';
import '../../../widget/search_widget/search_screen_widget/search_filter_drawer.dart';

class GlobalSearchController {
  static final TextEditingController searchController = TextEditingController();
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with FormFieldMixin, AutomaticKeepAliveClientMixin {
  final Debouncer debouncer = Debouncer(milliseconds: 100);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late VoiceSearchUseCase _voiceSearchUseCase;

  @override
  void initState() {
    super.initState();
    _voiceSearchUseCase = VoiceSearchUseCase(stt.SpeechToText());
    GlobalSearchController.searchController.addListener(_handleControllerChange);
  }

  @override
  bool get wantKeepAlive => true;

  void _handleControllerChange() {
    if (context.read<VoiceSearchCubit>().state.isListening) {
      _onSearchChanged(GlobalSearchController.searchController.text);
    }
  }

  void _startVoiceSearch() =>
      context.read<VoiceSearchCubit>().startVoiceSearch(_voiceSearchUseCase);

  void _stopVoiceSearch() => context.read<VoiceSearchCubit>().stopVoiceSearch();

  Future<void> _handleRefresh() async {
    context.read<FetchAllbarberBloc>().add(FetchAllBarbersRequested());
    await Future.delayed(const Duration(milliseconds: 600));
  }

  void _onSearchChanged(String searchText) {
    debouncer.run(() {
      context.read<FetchAllbarberBloc>().add(SearchBarbersRequested(searchText));
    });
  }

  @override
  void dispose() {
    GlobalSearchController.searchController.removeListener(_handleControllerChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GenderOptionCubit()),
        BlocProvider(create: (context) => SelectServiceCubit()),
        BlocProvider(create: (context) => RatingCubit()),
        BlocProvider(create: (context) => VoiceSearchCubit()),
        BlocProvider( create: (context) => AdiminServiceBloc(ServiceRepositoryImpl())..add(FetchServiceRequst())),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: ColoredBox(
          color: AppPalette.blackClr,
          child: SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              drawer: AppDrawer(),
              body: GestureDetector(
                onTap: () => FocusScope.of(context).unfocus(),
                child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  color: AppPalette.buttonClr,
                  backgroundColor: AppPalette.whiteClr,
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: AppPalette.blackClr,
                        expandedHeight: screenHeight * 0.14,
                        pinned: true,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          titlePadding:
                              EdgeInsets.only(left: screenWidth * 0.04),
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
                                      horizontal: screenWidth * 0.04),
                                  child: BlocBuilder<VoiceSearchCubit,
                                      VoiceSearchState>(
                                    builder: (context, voiceState) {
                                      final isListening = voiceState.isListening;

                                      return buildTextFormField(
                                        label: '',
                                        hintText: 'Search shop...',
                                        prefixIcon: Icons.search,
                                        context: context,
                                        controller: GlobalSearchController.searchController,
                                        validate: ValidatorHelper.serching,
                                        borderClr: AppPalette.lightgreyclr,
                                        fillClr: AppPalette.whiteClr,
                                        isfilterFiled: true,
                                        fillterAction: () {_scaffoldKey.currentState ?.openDrawer();
                                        },
                                        onChanged: _onSearchChanged,
                                        suffixIconData: isListening
                                            ? Icons.mic_none_outlined
                                            : CupertinoIcons.mic_fill,
                                        suffixIconColor: isListening
                                            ? AppPalette.greyClr
                                            : Colors.grey,
                                        suffixIconAction: () {
                                          if (!isListening) {
                                            _startVoiceSearch();
                                          } else {
                                            _stopVoiceSearch();
                                          }
                                        },
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03),
                        sliver: SliverToBoxAdapter(
                          child: ConstantWidgets.hight20(context),
                        ),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03),
                        sliver: BarberListBuilder(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
