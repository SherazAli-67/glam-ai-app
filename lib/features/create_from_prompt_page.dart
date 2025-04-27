import 'package:flutter/material.dart';
import 'package:glam_ai/data/app_data.dart';
import 'package:glam_ai/res/app_colors.dart';
import 'package:glam_ai/res/app_textstyles.dart';
import 'package:glam_ai/service/api_service.dart';

class CreateFromPromptPage extends StatefulWidget {
  const CreateFromPromptPage({super.key});

  @override
  State<CreateFromPromptPage> createState() => _CreateFromPromptPageState();
}

class _CreateFromPromptPageState extends State<CreateFromPromptPage> {
  int _selectedStyleIndex = 0;
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 15.0),
          child: Column(
              spacing: 10,
              children: [
                Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Enter a prompt", style: AppTextStyles.mediumTextStyle,),
                Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.grey)
                  ),
                  child: Row(
                    spacing: 5,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.light_mode, color: Colors.grey,),
                      Text("Inspired")
                    ],
                  ),
                )
              ],
            ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300]
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          hintText: "What do you want to see ? Tip: Start your prompt with subject",
                          hintStyle: AppTextStyles.regularTextStyle.copyWith(color: Colors.black),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                        maxLines: 4,
                        maxLength: 500,
                        style: AppTextStyles.regularTextStyle,
                        controller: _controller,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                  child: Row(
                    spacing: 20,
                    children: [
                      Text("Style", style: AppTextStyles.mediumTextStyle.copyWith(fontWeight: FontWeight.w600),),
                      Expanded(child: ListView.builder(
                          itemCount: AppData.styles.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx,index){
                            bool isSelected = _selectedStyleIndex == index;
                            return GestureDetector(
                              onTap: ()=> setState(()=> _selectedStyleIndex = index),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(99),
                                  color: isSelected ? AppColors.primaryColor : null
                                ),
                                child: Text(AppData.styles[index], style: isSelected ? AppTextStyles.regularTextStyle.copyWith(color: Colors.white) : AppTextStyles.regularTextStyle,),
                              ),
                            );
                      }))
                    ],
                  ),
                ),
                
                const Spacer(),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor
                        ),
                        onPressed: (){
                          String prompt = _controller.text;
                          String imageStyle = AppData.styles[_selectedStyleIndex];
                          ApiService.createImageDescription(prompt: prompt, imageStyle: imageStyle);
                        }, child: Text("Create", style: AppTextStyles.titleTextStyle.copyWith(color: Colors.white),)))
          ]),
        ),
      ),
    );
  }
}
