import 'package:doctor_on_call/widget/primary_botton.dart';
import 'package:flutter/material.dart';
import 'package:r_dotted_line_border/r_dotted_line_border.dart';
import '../../../utils/app_sizes.dart';
import '../../../utils/app_text.dart';
import '../../../utils/app_text_style.dart';
import '../../../utils/screen_utils.dart';
import '../../../widget/custom_sized_box.dart';
import '../../../widget/primary_appbar.dart';
import '../../../widget/primary_textfield.dart';
import '../../../widget/scrollview.dart';

class PathologyAndChemistFormScreen extends StatefulWidget {
  const PathologyAndChemistFormScreen({Key? key}) : super(key: key);

  @override
  State<PathologyAndChemistFormScreen> createState() =>
      _PathologyAndChemistFormScreenState();
}

class _PathologyAndChemistFormScreenState
    extends State<PathologyAndChemistFormScreen> {
  final TextEditingController _referredBy = TextEditingController();
  final TextEditingController _description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SecondaryAppBar(
          title: "Fill Form",
          isLeading: true,
        ),
        body: CustomScroll(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            appText("Referred By", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _referredBy,
              hintText: "Referred By",
              // validator: mobileNumberValidator,
              prefix: const Icon(Icons.phone),
              keyboardInputType: TextInputType.phone,
            ),
            SizedBoxH10(),
            appText("Description", style: AppTextStyle.lable),
            SizedBoxH8(),
            PrimaryTextField(
              controller: _description,
              hintText: "Description",

              // validator: patientNameValidation,
              prefix: const Icon(Icons.person),
            ),
            appText("Upload Prescription", style: AppTextStyle.lable),
            SizedBoxH8(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Sizes.s12),
                color: Theme.of(context).cardColor,
                border: RDottedLineBorder.all(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              width: double.infinity,
              height: Sizes.s160.h,
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.upload_file), Text("Upload File")],
                ),
              ),
            ),
            SizedBoxH34(),
            SizedBoxH34(),
            PrimaryButton(lable: "Done", onPressed: () {})
          ],
        ));
  }
}
