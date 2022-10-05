import 'package:cashmify_admin/pages/settings/controller/settings_controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsScreen extends StatelessWidget {
  SettingsController controller = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              "Settings",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: context.percentWidth * 22,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Giveaway Winner Percentage",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: context.percentWidth * 5,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Earning Percentage",
                                border: InputBorder.none,
                              ),
                              controller: controller.top_10_percentController,
                            ),
                          ),
                          SizedBox(
                            width: context.percentWidth * 5,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Charity Percentage",
                                border: InputBorder.none,
                              ),
                              controller: controller.top_3_percentController,
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => TextButton(
                          onPressed: () => controller.updateWinnerPercentage(),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          child: controller.loading.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: context.percentWidth * 22,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Ban Hour Duration",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Duarion (Number of Hours)",
                          border: InputBorder.none,
                        ),
                        controller: controller.ban_duationController,
                      ),
                      Obx(
                        () => TextButton(
                          onPressed: () => controller.updateBanDuration(),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          child: controller.loading1.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: context.percentWidth * 22,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Withdrawal Cashout fee %",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Percentage",
                          border: InputBorder.none,
                        ),
                        controller: controller.withdrawalFeeController,
                      ),
                      Obx(
                        () => TextButton(
                          onPressed: () => controller.updateCashoutFee(),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          child: controller.loading2.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.percentWidth * 22,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sign up Bonus",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: context.percentWidth * 6,
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Bonus Amount",
                                border: InputBorder.none,
                              ),
                              controller: controller.bonusController,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Select Country'),
                              Obx(
                                () => TextButton(
                                  onPressed: () {
                                    showCountryPicker(
                                      context: context,
                                      onSelect: (Country country) {
                                        controller.country.value = country.name;
                                        controller.countryCode.value =
                                            country.countryCode;
                                      },
                                    );
                                  },
                                  child: Text(controller.country.value),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => controller.saveBonusAmt(),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                              ),
                              child: controller.loading4.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "Save",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                            TextButton(
                              onPressed: () => controller.addNewCountry(),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                              ),
                              child: controller.loading3.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "Add",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => GridView.count(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(0),
                          crossAxisCount: 2,
                          childAspectRatio: 3.5,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: [
                            for (var item in controller.countries)
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(item['country']),
                                    MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: GestureDetector(
                                        onTap: () =>
                                            controller.removeCountry(item),
                                        child: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: context.percentWidth * 22,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Download User Email",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => controller.downloadAllEmail(),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                              ),
                              child: controller.loading5.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "Download All",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                            TextButton(
                              onPressed: () => controller.download2WeekEmail(),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                              ),
                              child: controller.loading6.value
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "Download 2weeks ago",
                                      style: TextStyle(color: Colors.white),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: context.percentWidth * 22,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "NGN Converstion Rate",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: context.percentWidth * 6,
                          child: TextFormField(
                            decoration: const InputDecoration(
                              labelText: "Rate",
                              border: InputBorder.none,
                            ),
                            controller: controller.rateController,
                          ),
                        ),
                        TextButton(
                          onPressed: () => controller.updateConverstionRate(),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          child: controller.loading7.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: context.percentWidth * 22,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Send Custom Notification",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Title",
                          hintText: "Type title here",
                          border: InputBorder.none,
                        ),
                        controller: controller.titleController,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Message",
                          hintText: "Type your message here",
                          border: InputBorder.none,
                        ),
                        controller: controller.bodyController,
                      ),
                      Obx(
                        () => TextButton(
                          onPressed: controller.loading8.value
                              ? () {}
                              : () => controller.sendAllUserNotification(),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          child: controller.loading8.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Send",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: context.percentWidth * 22,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Join Hour Duration",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Duarion (Number of Hours)",
                          border: InputBorder.none,
                        ),
                        controller: controller.joinDuraionController,
                      ),
                      Obx(
                        () => TextButton(
                          onPressed: () => controller.updateJoinDuration(),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          child: controller.loading9.value
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  "Save",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: context.percentWidth * 22),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
