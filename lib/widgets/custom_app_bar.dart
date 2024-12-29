import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/utils/constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key,required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        children: [
          GestureDetector(
            onTap: ()=>debugPrint('Backkkk...'),
            child: Container(
              alignment: Alignment.center,
              height: 40.0,width: 40.0,decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: whiteColor,
            ),
              child: const Icon(Icons.arrow_back,color: blackColor,size: 18.0),
            ),
          ),
          const SizedBox(width: 20.0),
          Text(title,style: GoogleFonts.roboto(fontWeight: FontWeight.w700,color: blackColor,fontSize: 20.0,),),
        ],
      ),
      automaticallyImplyLeading: false,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65.0);
}
