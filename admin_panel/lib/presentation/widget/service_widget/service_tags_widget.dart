import 'package:floating_tabbar/lib.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/themes/colors.dart';
import '../../provider/cubit/serviceTages/service_tags_cubit_cubit.dart';

class ServiceTagsWidget extends StatelessWidget { 
  final String text;
  final VoidCallback  edit;
  final VoidCallback delete;
  const ServiceTagsWidget({super.key, required this.text, required this.edit, required this.delete});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ServiceTagsCubitCubit(),
      child: BlocBuilder<ServiceTagsCubitCubit, ServiceTagsCubitState>(
        builder: (context, state) {
          final cubit = context.read<ServiceTagsCubitCubit>();
          bool showActions = state is ServiceTagsShowActions;

          return InkWell(
            onTap: () {
              cubit.toggleActions(showActions); 
            },
            child: Container(
              decoration: BoxDecoration(
                color: showActions ? AppPalette.buttonClr : AppPalette.whiteClr,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: showActions ? AppPalette.whiteClr : AppPalette.buttonClr,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(text, style: TextStyle(fontSize: 18, color: showActions ? AppPalette.whiteClr : AppPalette.blackClr)),
                  if (showActions) ...[
                    IconButton(
                      onPressed: edit,
                      icon: const Icon(
                        CupertinoIcons.pencil_outline,
                        color: AppPalette.whiteClr,
                      ),
                    ),
                    IconButton(
                      onPressed:delete,
                      icon: const Icon(
                        CupertinoIcons.clear,
                           color: AppPalette.whiteClr,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}