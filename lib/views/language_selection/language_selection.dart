import 'package:duseca_flutter_task/utils/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/language_selection_controller/language_selection_controller.dart';
import '../../utils/appFonts/app_fonts.dart';
import '../../utils/colors/app_colors.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageSelectionController controller = Get.put(LanguageSelectionController());
    final height = MediaQuery.of(context).size.height * .99;
    final width = MediaQuery.of(context).size.width * .99;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose the language',
                style: AppFonts.heading(color: AppColors.blackColor),
              ),
              SizedBox(height: height * .01),
              Text(
                'Please select your language, you can always change your preference in settings.',
                style: AppFonts.body(color: AppColors.blackColor.withOpacity(0.3)),
              ),
              SizedBox(height: height * .03),
              // Search Bar
              TextField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: AppColors.blackColor),
                  ),
                ),
                onChanged: (value) {
                  controller.updateSearchQuery(value); // Update search query
                },
              ),
              SizedBox(height: height * .02),
              // Language List
              SizedBox(
                height: height * 0.5, // Set a fixed height for the ListView
                child: Obx(() {
                  return ListView.builder(
                    itemCount: controller.languages.length,
                    itemBuilder: (context, index) {
                      var language = controller.languages[index];

                      if (controller.searchQuery.isEmpty ||
                          language['name']
                              .toString()
                              .toLowerCase()
                              .contains(controller.searchQuery.toLowerCase())) {
                        return ListTile(
                          leading: Text(
                            language['flag'] as String,
                            style: AppFonts.heading(color: AppColors.primaryColor),
                          ),
                          title: Text(
                            language['name'] as String,
                            style: AppFonts.body(color: AppColors.blackColor)
                                .copyWith(fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                          trailing: Obx(() => SizedBox(
                            width: 30, // Limit trailing widget width
                            child: language['selected'] as bool
                                ? const Icon(Icons.check_circle, color: AppColors.blackColor)
                                : const SizedBox.shrink(),
                          )),
                          onTap: () {
                            controller.selectLanguage(index); // Select the language
                          },
                        );
                      }
                      return Container(); // Return empty container if language doesn't match the search query
                    },
                  );
                }),
              ),
              SizedBox(height: height * .05),
              CustomButton(
                label: 'Continue',
                onPress: controller.continueAction,
                isLoading: controller.isLoading,
              )
            ],
          ),
        ),
      ),
    );
  }
}
