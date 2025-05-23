import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/components/view_image.dart';
import '../controller/cubit.dart';
import 'widgets/view_note_info.dart';

import '../../../../core/constant/app_string.dart';
import '../../../../core/components/image_view.dart';
import 'widgets/app_bar_view_note.dart';

class ViewNoteScreen extends StatelessWidget {
  final Map note;
  const ViewNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewNoteCubit()..convertImages(note['imgs'] ?? ""),
      child: BlocBuilder<ViewNoteCubit, ViewNoteState>(
        builder: (context, state) {
          final controller = ViewNoteCubit.get(context);
          return Scaffold(
            appBar: appBar(
                isArabic: context.locale.toString() == AppString.arabic,
                context: context,
                onTapEdit: () {
                  controller.updateNote(
                      context: context,
                      note: note,
                      imgList: controller.imgsBase64);
                }),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ViewNoteInfo(
                              head: AppString.note.tr(),
                              content: note['note'].toString(),
                              headAlignRnght: note["titleType"] == "ar"),
                        ],
                      )),
                ),
                controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : controller.imgsBase64.isEmpty
                        ? const SizedBox()
                        : SingleChildScrollView(
                            padding: const EdgeInsets.only(right: 10),
                            scrollDirection: Axis.horizontal,
                            physics: const BouncingScrollPhysics(),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(
                                  controller.imgs['all'].length,
                                  (index) => InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewImageScreen(
                                                          tag: index,
                                                          img: controller
                                                                  .imgs['all']
                                                              [index]['img'])));
                                        },
                                        borderRadius: BorderRadius.circular(13),
                                        child: Hero(
                                          tag: index,
                                          child: ImageViewShape(
                                              img: controller.imgs['all'][index]
                                                  ['img'],
                                              isWithDelete: false),
                                        ),
                                      )),
                            ),
                          )
              ],
            ),
          );
        },
      ),
    );
  }
}
