import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glam_ai/data/app_data.dart';
import 'package:glam_ai/res/app_colors.dart';
import 'package:glam_ai/res/app_constants.dart';
import 'package:glam_ai/res/app_icons.dart';
import 'package:glam_ai/res/app_textstyles.dart';

class HomePage extends StatelessWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: CircleAvatar(
          backgroundImage: CachedNetworkImageProvider(profileUrl),
          backgroundColor: Colors.white10,
        ),
        leadingWidth: 70,
        title: Text("Glams AI", style: AppTextStyles.headingTextStyle,),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 20)
                ),
                onPressed: (){}, child: Text("Get Pro", style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),)),
          )
        ],
      ),
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 15,
          children: [
            Text("New Creation From...", style: AppTextStyles.titleTextStyle,),
            Row(
              spacing: 45,
              children: [
                _buildCreationTool(icon: AppIcons.icTextGeneration, title: "Text"),
                _buildCreationTool(icon: AppIcons.icImageFilter, title: "Image"),
                _buildCreationTool(icon: AppIcons.icVirtualTryOn, title: "Try-on"),
              ],
            ),
            Text("Your recents", style: AppTextStyles.titleTextStyle,),
            Expanded(child: MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: AppData.aiImages.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(imageUrl: AppData.aiImages[index], fit: BoxFit.cover,),
                );
              },
            )

            /*GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: AppData.aiImages.length,

                itemBuilder: (ctx, index){
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(imageUrl: AppData.aiImages[index], fit: BoxFit.cover,),
                  );
            }),*/

            )
          ],
        ),
      )),
    );
  }

  Widget _buildCreationTool({required String icon, required String title, }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.primaryColor.withOpacity(0.5),
      ),
      child: Column(
        spacing: 5,
        children: [
          SvgPicture.asset(icon,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),),
          Text(title,
            style: AppTextStyles.mediumTextStyle.copyWith(color: Colors.white),)
        ],
      ),
    );
  }

}