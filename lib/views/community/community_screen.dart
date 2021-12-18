import 'package:fake_news/resources/utils/icon.dart';
import 'package:fake_news/resources/utils/style.dart';
import 'package:fake_news/resources/widgets/card_community.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);

  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Kiểm tra tính xác thực",
                style: StylesText.content18BoldBlack,
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.history))
            ],
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                style: BorderStyle.solid,
                width: 1.0,
              ),
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10.0),
            ),
            height: 45,
            width: Get.size.width * 0.9,
            child: Center(
                child: Text(
              "Gửi thông tin chi tiết về tin tức cần xác thực ...",
              style: StylesText.content12LightBlack,
            )),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.backup_outlined,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Thêm tệp đính kèm",
                    style: StylesText.content12MediumBlack,
                  )
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.info,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Xem hướng dẫn",
                    style: StylesText.content12MediumBlack,
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      IconsApp.follow,
                      width: 25,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Tin đóng góp nổi bật",
                      style: StylesText.content16BoldBlack,
                    ),
                  ],
                ),
                Container(
                  height: 170,
                  child: Center(
                    child: ListView.builder(
                      padding: EdgeInsets.all(10),
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: CardCommunity(
                            title:
                                "Tin: Loan tin giả về việc tiêm Vaccine Trung Quốc, người dân bỏ về hết",
                            content: '',
                            crowdId: '',
                            nameCrowd: "Huynh Huu Khanh",
                            numberCrowd: 20,
                            onpress: () {},
                            times: '',
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: Get.size.width,
            padding: EdgeInsets.all(10),
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Tin đóng góp mới nhất",
                  style: StylesText.content16BoldBlack,
                ),
                CardCommunity(
                    title:
                        "Tin: Loan tin giả về việc tiêm Vaccine Trung Quốc, người dân bỏ về hết",
                    content: '',
                    crowdId: '',
                    nameCrowd: "Huynh Huu Khanh",
                    numberCrowd: 20,
                    onpress: () {},
                    times: '1 giờ trước',
                    width: Get.size.width),
                CardCommunity(
                    title:
                        "Tin: Loan tin giả về việc tiêm Vaccine Trung Quốc, người dân bỏ về hết",
                    content: '',
                    crowdId: '',
                    nameCrowd: "Huynh Huu Khanh",
                    numberCrowd: 20,
                    onpress: () {},
                    times: '1 giờ trước',
                    width: Get.size.width),
              ],
            ),
          )
        ]),
      )),
    );
  }
}
