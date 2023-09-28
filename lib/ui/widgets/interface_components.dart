import 'package:flutter/material.dart';
import 'package:madenati/models/boardingmodel.dart';
import 'package:shimmer/shimmer.dart';
import '../../constants/colors.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:madenati/controllers/complains_controller.dart';
import 'package:madenati/controllers/recycling_controller.dart';
import 'package:madenati/controllers/register_controller.dart';
import 'package:madenati/controllers/volunteering_controller.dart';

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  required String title,
  bool isHome = false,
}) {
  return AppBar(
    backgroundColor: mainColor,
    title: isHome
        ? Center(
            child: Text(
              title,
              style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Cairo',
                  fontWeight: FontWeight.bold),
            ),
          )
        : Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold),
          ),
    leading: !isHome
        ? IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Get.back();
            },
          )
        : null,
  );
}

Widget button({required void Function()? onPressed, required Widget? child}) =>
    SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: mainColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: onPressed,
        child: child,
      ),
    );
Widget buttonDismiss(
        {required void Function()? onPressed, required Widget? child}) =>
    SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: alertColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: onPressed,
        child: child,
      ),
    );

Widget loading() => Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10)),
        child: const Padding(
          padding: EdgeInsets.all(18.0),
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 102, 187, 106),
          ),
        ),
      ),
    );

Widget dropDown(
        {required String selected,
        required List<String> list,
        required int flag}) =>
    Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 15),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: DropdownButton(
              padding: const EdgeInsets.all(5),
              dropdownColor: const Color.fromARGB(255, 247, 247, 247),
              icon: const Icon(Icons.arrow_drop_down),
              isExpanded: true,
              iconSize: 22,
              style: const TextStyle(color: Colors.black, fontSize: 15),
              value: selected,
              underline: const SizedBox(),
              items: list.map((valueItem) {
                return DropdownMenuItem(
                    value: valueItem,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          valueItem,
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                          ),
                        ),
                      ),
                    ));
              }).toList(),
              onChanged: (newValue) {
                try {
                  switch (flag) {
                    case 1:
                      RegisterController registerController = Get.find();

                      registerController.changeProvince(newValue);
                      break;

                    case 2:
                      ComplainsController complainsController = Get.find();

                      complainsController.switchSelectedComplain(newValue);
                      break;

                    case 3:
                      ComplainsController complainsController = Get.find();

                      complainsController
                          .switchSelectedComplainStatus(newValue);
                      break;
                    case 4:
                      RecyclingController recyclingController = Get.find();

                      recyclingController.switchSelectedRecyclingItem(newValue);
                      break;
                    case 5:
                      VolunteeringController volunteeringController =
                          Get.find();

                      volunteeringController
                          .switchSelectedVolunteringType(newValue);
                      break;
                    case 6:
                      VolunteeringController volunteeringController =
                          Get.find();

                      volunteeringController
                          .switchSelectedVolunteringGroup(newValue);
                      break;
                  }
                } catch (exception) {
                  log('$exception');
                }

                selected = newValue!;
              }),
        ));

Widget formField(
        {required TextEditingController control,
        required bool isScure,
        required String label,
        required Icon prefIcon,
        ValueChanged<String>? onSubmit,
        required FormFieldValidator<String> validator,
        bool readOnly = false,
        Null Function()? ontap,
        IconButton? suffButton,
        bool isNumber = false}) =>
    TextFormField(
      readOnly: readOnly,
      textDirection: TextDirection.rtl,
      validator: validator,
      controller: control,
      keyboardType:
          isNumber ? TextInputType.number : TextInputType.visiblePassword,
      obscureText: isScure,
      obscuringCharacter: '*',
      onFieldSubmitted: onSubmit,
      onTap: ontap,
      decoration: InputDecoration(
          isDense: true,
          prefixIcon: prefIcon,
          suffixIcon: suffButton,
          hintText: label,
          hintStyle: const TextStyle(
            fontFamily: 'Cairo',
          ),
          hintTextDirection: TextDirection.rtl,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

Widget descFormField(
        {required String hint,
        required TextEditingController textController}) =>
    Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: TextField(
        controller: textController,
        textDirection: TextDirection.rtl,
        maxLines: 5, autofocus: false,
        // Set the number of lines you want to display
        decoration: InputDecoration(
            hintText: hint,
            hintTextDirection: TextDirection.rtl,
            hintStyle: const TextStyle(
              fontFamily: 'Cairo',
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            )
            // Add border styling
            ),
      ),
    );
Widget genderButton(
        {required String title, required void Function()? onPressed}) =>
    Expanded(
        child: ElevatedButton(
            onPressed: onPressed,
            child: Text(title,
                style: const TextStyle(
                    color: Colors.white, fontFamily: 'Cairo'))));

Widget boardingItemBuilder(BoardingModel model, size) => Stack(
      children: [
        Positioned(
          child: SizedBox(
              height: size.height,
              child: Image(
                image: AssetImage('${model.image}'),
                fit: BoxFit.cover,
              )),
        ),
        const SizedBox(
          height: 25,
        ),
        Positioned(
          child: Container(
              height: size.height,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.3),
                    spreadRadius: 6,
                    blurRadius: 6,
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 80, horizontal: 10),
                  child: Text(
                    '${model.title}',
                    style: const TextStyle(
                      fontSize: 35,
                      fontFamily: 'Cairo',
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
Widget separator() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: (Container(
        height: 1,
        color: const Color.fromARGB(255, 226, 226, 226),
      )),
    );

Widget shimmerWidget({required Size size}) => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView.separated(
              itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Container(
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
              separatorBuilder: (context, index) => separator(),
              itemCount: 5)),
    );

Widget homeShimmerWidget({required Size size}) => Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: size.height * 0.25, // Adjust this value as needed
                width: double
                    .infinity, // Use double.infinity to fill the available width
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              const SizedBox(height: 7.5),
              separator(),
              const SizedBox(height: 7.5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: size.height * 0.25, // Adjust this value as needed
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      height: size.height * 0.25, // Adjust this value as needed
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: size.height * 0.25, // Adjust this value as needed
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      height: size.height * 0.25, // Adjust this value as needed
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
