import 'package:beehive/constants/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/home_provider.dart';
import 'my_colors.dart';
import 'my_functions.dart';

void alertTerm(context){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          scrollable: true,
          backgroundColor: myWhite,
          title: Consumer<HomeProvider>(
              builder: (context,value,child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(),
                        Text('Privacy Policy', style: gradient1PoppinsBoldM22),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text("Thank you for visiting the website / mobile app of Indian Union Muslim League (Site) The Privacy Policy is applicable to the websites of Indian Union Muslim League. This privacy statement also does not apply to the websites of our partners, affiliates, agents or to any other third parties, even if their websites are linked to Site. We recommend you review the privacy statements of the other parties with whom you interact.For the purposes of this privacy policy, \"affiliates\" means any entity or project or venture that is wholly or partially owned or controlled by Indian Union Muslim League.\"agents\" means any subcontractor, vendor or other entity with whom we have an ongoing business relationship to provide products, services, or information. The following terms governs the collection, use and protection of your personalInformation by the Site. This Privacy Policy shall be applicable to users who visit theSite. By visiting and/ or using the Site you have agreed to the following Privacy Policy.", style: whitePoppinsBoldB1),
                    const SizedBox(height: 10,),
                    const Text("Introduction",style:TextStyle(color: myBlack,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 18) ,),
                    const SizedBox(height: 10,),

                    Text("As a registered member of the Site and/or as a visitor (if applicable and as the case may be), you will get an insight on the updates and information of the happenings and developments within and by the organisation. In addition, look forward to receiving monthly news letters and updates from the Indian Union Muslim League.That's why we've provided this Privacy Policy, which sets forth our policies regarding the collection, use and protection of the Personal Information of those using or visiting the Site. ",style: whitePoppinsBoldB1),
                    const SizedBox(height: 10,),

                    const Text("Personal Information Collection",style:TextStyle(color: myBlack,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 18) ,),
                    const SizedBox(height: 10,),

                    Text("The website may collect and use the following kinds of personal information:",style: whitePoppinsBoldB1,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),
                        const SizedBox(width: 3,),
                        Flexible(child: Text("Information about your use of this website (including browsing patterns and behaviour)",style: whitePoppinsBoldB1))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),const SizedBox(width: 3,),
                        Flexible(child: Text("Information that you provide using for the purpose of registering with the website (including contact details)",style: whitePoppinsBoldB1))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),const SizedBox(width: 3,), Flexible(child: Text("Information about transaction carried out over this website ",style: whitePoppinsBoldB1))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),const SizedBox(width: 3,), Flexible(child: Text("Information that you provide for the purpose of subscribing to the website services (including SMS and email alerts) and any other information that you send to fellow users and webmaster.",style: whitePoppinsBoldB1))
                      ],
                    ),
                    const SizedBox(height: 10,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(width: 16,),Flexible(child: Text("Using Personal Information",style:TextStyle(color: myBlack,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 18) ,)),
                      ],
                    ),
                    const SizedBox(height: 10,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        const SizedBox(width: 16,),Flexible(child: Text("The website may use your personal information to: ",style: whitePoppinsBoldB1,)),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),const SizedBox(width: 3,), Flexible(child: Text("administer this website;",style: whitePoppinsBoldB1))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const  SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),const SizedBox(width: 3,), Flexible(child: Text("personalize the website for you;",style: whitePoppinsBoldB1))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const  SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),const SizedBox(width: 3,), Flexible(child: Text("enable your access to and use of the website services;",style: whitePoppinsBoldB1))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const  SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),const SizedBox(width: 3,), Flexible(child: Text("publish information about you on the website;",style: whitePoppinsBoldB1))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite ),),
                        ),const SizedBox(width: 3,), Text("send you communications.",style: whitePoppinsBoldB1)
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:16),
                      child: Text("Where the website discloses your personal information to its agents or subcontractors for these purposes, the agent or sub-contractor in question will be obligated to use that personal information in accordance with the terms of this privacy statement ",style: whitePoppinsBoldB1,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:16),
                      child: Text("In addition to the disclosures reasonably necessary for the purposes identified elsewhere above, the website may disclose your personal information to the extent that it is required to do so by law, in connection with any legal proceedings or prospective legal proceedings, and in order to establish, exercise or defend its legal rights. ",style: whitePoppinsBoldB1,),
                    ),
                    const  SizedBox(height: 10,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const[
                        SizedBox(width: 16,),Text("Securing your Data",style:TextStyle(color: myBlack,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 18) ,),
                      ],
                    ),
                    const  SizedBox(height: 10,),

                    Padding(
                      padding:  const EdgeInsets.only(left:16),
                      child: Text("The website will take reasonable technical and organisational precautions to prevent the loss, misuse or alteration of your personal information. The website will store all the personal information you provide on its secure servers.",style: whitePoppinsBoldB1,),
                    ),
                    const SizedBox(height: 10,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const[
                        SizedBox(width: 16,),Flexible(child: Text("Updating this Statement ",style:TextStyle(color: myBlack,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 18) ,)),
                      ],
                    ),
                    const SizedBox(height: 10,),

                    Padding(
                      padding:  const EdgeInsets.only(left:16),
                      child: Text("The website may update this privacy policy by posting a new version on this website. You should check this page occasionally to ensure you are familiar with any changes.",style: whitePoppinsBoldB1,),
                    ),
                    const SizedBox(height: 10,),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:const [
                        SizedBox(width: 16,), Text("Other Websites",style:TextStyle(color: myBlack,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 18) ,),
                      ],
                    ),
                    const SizedBox(height: 5,),

                    Padding(
                      padding:  const EdgeInsets.only(left:16),
                      child: Text("This website may contain links to other Websites.The website is not responsible for the privacy policies or practices of any third party.",style: whitePoppinsBoldB1,),
                    ),
                  ],
                );
              }
          ),
          actions: [
            Center(
              child: InkWell(
                onTap:(){
                  finish(context);
                },
                child: Container(
                  width: 120,
                  height: 35,
                  decoration:  BoxDecoration(
                    boxShadow:  [
                      const BoxShadow(
                        color:cl323A71,
                      ),
                      BoxShadow(
                        color: cl000000.withOpacity(0.25),
                        spreadRadius: -5.0,
                        // blurStyle: BlurStyle.inner,
                        blurRadius: 20.0,
                      ),

                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(35)),
                    gradient: const LinearGradient(
                      begin: Alignment(-1.00, -0.00),
                      end: Alignment(1, 0),
                      colors: [Color(0xFF3E4FA3), Color(0xFF253068)],
                    ),

                  ),
                  alignment: Alignment.center,
                  child:Text(
                    'Ok',
                    style: whitePoppinsBoldM15,
                  ),
                ),
              ),
            ),
          ],


        );
      });
}

void alertTermsAndConditions(context){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          scrollable: true,
          backgroundColor: myWhite,

          title:  Consumer<HomeProvider>(
              builder: (context,value,child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Column(
                      children: [
                        Row(),
                        Text('Terms And Conditions', style: gradient1PoppinsBoldM22),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text("This website and mobile app is developed, managed and operated by the Indian Union Muslim League (“IUML”). These Site Terms apply solely to your access to, and use of, the Web site (the \"Site\") operated by the IUML which link to these Site Terms. However, Site Terms in no manner shall alter any of the express terms agreed between you and IUML (including its affiliates, agents and permitted assignees) for any products or services as the case may be. Reserve the right to change, modify, alter, expand any of the terms and conditions contained in the Site Terms or any policy, guideline, specifications of the Site, at any time and in its sole discretion without any prior notice. Any such changes, modification, alteration, addition or expansion so made to the Site Terms shall be effective immediately upon posting of the revisions on the Sites, and by accessing the Site you waive any right you may have to receive specific notice of such changes or modifications. Your continued use of the Site following the posting of changes, alterations, modifications, addition and expansion will confirm your acceptance of such changes or modifications. Therefore, it is deemed that you frequently review, understand and accept the Site Terms and applicable policies from time-to-time. If you do not agree to the amended terms, you must stop using the Site. If you have any question regarding the use of the Site, please place your queries and c questions or comments clarifications about the Site or site content to Terms of Privacy Refer to the Privacy Policy for an understanding of how we collect, use and disclose the identifiable information from our users. Intellectual Property Rights Unless stated/indicated otherwise on the Site, the Site including all content and materials on the Site, including, without limitation, IUML party symbol, designs ,texts ,graphics ,pictures, information , data, audiovisual files, sound files, tools, widgets, software and any files in whatsoever format whether used collectively or individually (“Site Property”) are the proprietary property of the IUML or its licensors or users and are protected by Indian and international copyright laws. You as a user of the Site are granted a limited, non-sub licensable, non-transferable license to access and use the Site and the Site Property for your informational, non-commercial and personal use only. The license so granted is subject to these Site Terms. You as a user may use this material only as expressly authorized by IUML and shall not copy, transmit or create derivative works of such material without express authorization. You acknowledge and agree that he/she shall not upload post, reproduce, or distribute any content on or through the services that is protected by copyright or other proprietary right of a third party, without obtaining the written permission of the owner of such right. Any copyrighted or other proprietary content distributed with the consent of the owner must contain the appropriate copyright or other proprietary rights notice. The unauthorized submission or distribution of copyrighted or other proprietary content is illegal and could subject the user to personal liability or criminal prosecution, Copyright Complaints. You are prohibited from using any Meta tags or any other \"hidden text\" utilizing \"IUML\" or any other name, Site Property or product or service name of the IUML without IUML’s prior written permission. In addition, the look and feel of the Site, including but not limited to all page headers, custom graphics, button icons and scripts, is the proprietary property of IUML and must not be copied, imitated or used, in whole or in part, without our prior written permission. All other trademarks, registered trademarks, product names and company names or logos mentioned in the Sites are the property of their respective owners. Reference to any products, services, processes or other information, by trade name, trademark, manufacturer, and supplier or otherwise does not constitute or imply endorsement, sponsorship or recommendation thereof by us. Except as otherwise provided, you retain ownership of all User Submissions you post on the Site. However, if you post User Submissions to the Site, unless IUML indicate otherwise, you grant IUML and its affiliates a non-exclusive, royalty-free, perpetual, irrevocable and fully sub licensable right to use, reproduce, modify, adapt, publish, translate, create derivative works from, distribute, perform and display such User Submissions throughout the world in any manner, media or language including without limitation in advertising, campaigning and other communications in support of IUML, without any right of compensation or attribution . You grant the IUML and its affiliates and sub licenses the right to use the name that you submit in connection with such content, as and if they choose. You represent and warrant that (i) you own and control all of the rights to the User Submissions that you post or you otherwise have the right to post such User Submissions to the Site; (ii) the User Submission is accurate and not misleading; and (iii) use and posting of the User Submission you supply does not violate these Site Terms and will not violate any rights of or cause injury to any person or entity. Third party and hyper links The IUML makes no claim or representation regarding, and accepts no responsibility for, the quality, content, nature or reliability of third-party Web sites accessible by hyperlink from the Site, or web site linking to the Site. Such sites are not under the control of the IUML and the IUML is not responsible for the contents of any linked site or any link contained in a linked site, or any review, changes or updates to such sites. The IUML provides these links to you only as a convenience, and the inclusion of any link does not imply affiliation, endorsement or adoption by the IUML of any site or any information contained therein. When you leave the Site, you are deemed to be aware of going out of the purview of the Site Terms You should review the applicable terms and policies, including privacy and data gathering practices, of any site to which you navigate from the Site. You acknowledge and agree that any feedback, questions, comments, suggestions, ideas, or other information or materials regarding the Site or the IUML that are provided by you in the form of email or other submissions to the IUML, or any postings on the Site, are non-confidential and shall become the sole property of the IUML. The IUML shall own exclusive rights, including all intellectual property rights, and shall be entitled to the unrestricted use and dissemination of these materials for any purpose without acknowledgment or compensation to you. ", style: whitePoppinsBoldB1),
                    const SizedBox(height: 10,),
                    const  Text("INDEMNIFICATION AND LIABILITY",style:
                    TextStyle(color: myBlack,fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,fontSize: 17) ,),
                    const  SizedBox(height: 10,),
                    Text("You as user shall be liable towards, and compensate, indemnify and hold IUML , its affiliates or any person working under it harmless from and against any direct or indirect damages, , liabilities, obligations, costs, claims of any kind, interest, penalties, legal proceedings and expenses (including, without limitation, reasonable attorneys’ fees and expenses) actually paid, suffered or incurred by IUML due to the breach of the Site Terms , any act or omission, misuse, abuse of the Site access, fraudulent acts, willful misconduct of the user or Any person acting under such user. User shall be liable for any claims arising due to fraudulent transaction, abuse or misuse of the Site and agrees to indemnify and hold harmless IUML against such claims, loss or damage. GOVERNING LAWS AND DISPUTE RESOLUTION: These Site Terms including any dispute of whatsoever nature arising out of the use, access, operation, interpretation, or any effect related directly or indirectly arising out of the Site and the Site Property shall be exclusively governed by the laws of INDIA and user expressly agrees to the exclusive jurisdiction of courts of Kerala. GENERAL No course of dealing, failure by either party to require the strict performance of any obligation assumed by the other hereunder, or failure by either party to exercise any right or remedy to which it is entitled, shall constitute a waiver or cause a diminution of the rights or obligations provided under Site Terms. No provision of site Terms shall be deemed to have been waived by any act or knowledge of either party, but only by a written instrument signed by a duly authorized representative of the party to be bound thereby. Waiver by either party of any default shall not constitute a waiver of any other or subsequent default. Notwithstanding anything as mentioned or specified in the Site Terms, IUML reserve the right to terminate or withdraw your license to use the Site at any time without prior notice of the same. If any one or more provisions contained in this agreement or any document executed in connection herewith shall be invalid, illegal, or unenforceable, the remaining provisions contained herein shall not in any way be affected or impaired. User acknowledges that the remedy at law for any breach or violation of any provision of Site Terms may not be sufficient and a breach may cause continuing and irreparable loss, harm or damage to good will, name, reputation and credibility of IUML. User therefore agree that IUML shall be entitled to obtain injunctive relief, or any other restraining or any other appropriate order against the user in the event of any threat or disclosure of confidential Information. Nothing in Site Terms shall be construed as to create the relationship of employer-employee, partners, collaborators, joint-venture or principal-agent between user and IUML hereto. The parties shall be independent entities and neither party shall bind the other by its acts, deeds or omissions. User agrees that all notices under these Site Terms from the user shall be in writing, sent by facsimile or first-class registered or recorded delivery post to the IUML at its registered office or at such other address of which IUML shall have given notice as aforesaid, and marked for the attention of that IUML designated agent as mentioned above in the Site Terms. The date of service shall be deemed to be the day following the day on which the notice was transmitted or posted as the case may be. In addition to the Site Terms, user agrees that the products and services of IUML are subject to the privacy policy at Site with url: http://www.iumlkerala.org. ",style: whitePoppinsBoldB1,),
                    const  SizedBox(height: 10,),
                    const  Text("Donation Refund Policy",style:TextStyle(color: myBlack,
                        fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 18) ,),
                    const  SizedBox(height: 10,),
                    Text("Indian Union Muslim League (IUML) will examine each request for refund of donation and endeavour to make the refund. IUML political party may also seek further information / documents and donor must co-operate in this regard. However, IUML political party is not obliged to make refunds and may, in its discretion, decline any requests for refund of donations. If you would like your donation to IUML to be refunded, you must request IUML in writing or by email for a refund and Your request must reach IUML registered office within 7 (Seven) days from the date on which you made the donation i.e. the date on which you: ",style: whitePoppinsBoldB1,),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width:8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container( width: 5, height: 5,
                            decoration: const BoxDecoration(shape: BoxShape.circle,

                                color: myWhite),),
                        ),
                        const SizedBox(width: 3,),
                        Flexible(child: Text("Made the donation online, electronically or through other means",style: whitePoppinsBoldB1)),
                      ],
                    ),
                    Text("The written request stating reason for requesting a refund must be sent to the address stated below and must contain all the following details pertaining to the donation: ",style: whitePoppinsBoldB1,),
                    Row(
                      children: [
                        const SizedBox(width: 8,),
                        Container( width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: myWhite),),
                        const SizedBox(width: 3,),
                        Text("Date of Donation",style: whitePoppinsBoldB1),
                      ],
                    ),
                    Row(
                      children: [
                        const   SizedBox(width: 8,),
                        Container( width: 5,
                          height: 5,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: myWhite),),
                        const SizedBox(width: 3,),
                        Text("Donation Amount",style: whitePoppinsBoldB1),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),
                        const SizedBox(width: 3,),
                        Flexible(child: Text("If Donation was made online, please provide Transaction Details ",style: whitePoppinsBoldB1)),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8,),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: myWhite),),
                        ),
                        const SizedBox(width: 3,),
                        Flexible(
                            child: Text("If donation was made through debit/credit card, please provide Debit/Credit Card no. (last 4 digits only) ",style: whitePoppinsBoldB1)),
                      ],
                    ),

                  ],
                );
              }
          ),
          actions: [
            Center(
              child: InkWell(
                onTap:(){
                  finish(context);
                },
                child: Container(
                  width: 120,
                  height: 35,
                  decoration:  BoxDecoration(
                    boxShadow:  [
                      const BoxShadow(
                        color:cl323A71,
                      ),
                      BoxShadow(
                        color: cl000000.withOpacity(0.25),
                        spreadRadius: -5.0,
                        // blurStyle: BlurStyle.inner,
                        blurRadius: 20.0,
                      ),

                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(35)),
                    gradient: const LinearGradient(
                      begin: Alignment(-1.00, -0.00),
                      end: Alignment(1, 0),
                      colors: [Color(0xFF3E4FA3), Color(0xFF253068)],
                    ),

                  ),
                  alignment: Alignment.center,
                  child:Text(
                    'Ok',
                    style: whitePoppinsBoldM15,
                  ),
                ),
              ),
            )
          ],
        );
      });


}

void alertAbout(context){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          title:  Consumer<HomeProvider>(
              builder: (context,value,child) {
                return Column(
                  children: [
                    const  Text('About Us', style: TextStyle(color: Colors.black)),const SizedBox(height: 10,),
                    Text(value.aboutUs.toString(), style: const TextStyle(color: Colors.black,fontSize: 13)),
                  ],
                );
              }
          ),
          actions: [Center(
            child: ElevatedButton(onPressed:(){finish(context);}, child: Container(
              width: 100,
              alignment: Alignment.center,
              child:Text(
                'Ok',
                style: white16,
              ),
            ),),
          )],


        );
      });


}

void alertContact(context){
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          contentPadding: const EdgeInsets.only(
            top: 10.0,
          ),
          title:  Consumer<HomeProvider>(
              builder: (context,value,child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Row(),
                        const  Text('Contact Us', style: TextStyle(color: Colors.black)),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    // const Text("Address:",style:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,decoration: TextDecoration.underline,fontSize: 14) ,),
                    const Text("League House\nR.C. Road, Kozhikkode,\n Kerala,",style: TextStyle(color: Colors.black,fontSize: 13),),
                    Text(value.contactUs,style: const TextStyle(color: Colors.black,fontSize: 13),),
                    const SizedBox(height:10 ,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Developed by ',style: TextStyle(color: Colors.black,fontSize: 13),),
                        Image.asset('assets/spine.png',scale:4,),
                      ],
                    ),
                    InkWell(
                        onTap: (){
                          _launchURL('https://www.spinecodes.com/');
                          finish(context);
                        },
                        child: const Text('https://www.spinecodes.com/',style: TextStyle(color: Colors.blueAccent,fontSize: 13))),
                    const SizedBox(height:10 ,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Managed by ',style: TextStyle(color: Colors.black,fontSize: 13),),
                        Image.asset('assets/neurobots.png',scale:4,),
                      ],
                    ),
                    InkWell(
                        onTap: (){
                          _launchURL('https://www.nuerobots.com/');
                          finish(context);
                        },
                        child: const Text('https://www.nuerobots.com/',style: TextStyle(color: Colors.blueAccent,fontSize: 13)))
                  ],
                );
              }
          ),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: InkWell(
                  onTap:(){
                    finish(context);
                  },
                  child: Container(
                    width: 120,
                    height: 35,
                    decoration:  BoxDecoration(
                      boxShadow:  [
                        const BoxShadow(
                          color:cl323A71,
                        ),
                        BoxShadow(
                          color: cl000000.withOpacity(0.25),
                          spreadRadius: -5.0,
                          // blurStyle: BlurStyle.inner,
                          blurRadius: 20.0,
                        ),

                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(35)),
                      gradient: const LinearGradient(
                        begin: Alignment(-1.00, -0.00),
                        end: Alignment(1, 0),
                        colors: [Color(0xFF3E4FA3), Color(0xFF253068)],
                      ),

                    ),
                    alignment: Alignment.center,
                    child:Text(
                      'Ok',
                      style: whitePoppinsBoldM15,
                    ),
                  ),
                ),
              ),
            )],


        );
      });


}

void alertSupport(context){
  HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
  showDialog(
      context: context,
      builder: (BuildContext context) {
        final width=MediaQuery.of(context).size.width;
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          contentPadding: EdgeInsets.zero,


          content:
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 170,
              width:width*.70,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Connect Support Team',
                    style: TextStyle(
                      color: myBlack,
                      fontSize: 14,
                      fontFamily: 'JaldiBold',
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height:10),

                  const Text(
                    'Excellence in helpline services is the heartbeat of user satisfaction.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: cl5C5C5C,
                      fontSize: 12,
                      fontFamily: 'JaldiBold',
                      fontWeight: FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex:1,
                        child: InkWell(
                          onTap:(){
                            launch("tel://${homeProvider.contactNumber}");
                            finish(context);
                          },
                          child: Container(
                            height: 35,
                            alignment:Alignment.center,
                            decoration: ShapeDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment(-1.00, -0.00),
                                end: Alignment(1, 0),
                                colors: [cl3E4FA3, cl253068],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(34),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.phone,color: myWhite,size: 19),
                                SizedBox(width: 6,),
                                Text(
                                  'Call',
                                  style: TextStyle(
                                    color: myWhite,
                                    fontSize: 12,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                          flex:1,
                          child:InkWell(
                            onTap:(){
                              launch('whatsapp://send?phone=${homeProvider.contactNumber}');
                              finish(context);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              height: 35,
                              alignment:Alignment.center,
                              decoration: ShapeDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment(-1.00, -0.00),
                                  end: Alignment(1, 0),
                                  colors: [cl3E4FA3, cl253068],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(34),
                                ),
                              ),
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/whatsapp.png",scale: 3.5,color: myWhite,),

                                    SizedBox(width: 3,),

                                    Text(
                                      'WhatsApp',
                                      style: TextStyle(color: myWhite,
                                        fontSize: 12,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  ),


                ],
              ),
            ),


        );
      });



}

void _launchURL(String _url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}

class LoadingIndicator extends StatelessWidget{
  const LoadingIndicator({this.text = ''});

  final String text;

  @override
  Widget build(BuildContext context) {
    var displayedText = text;

    return Container(
        padding: const EdgeInsets.all(16),
        color: Colors.white,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _getLoadingIndicator(),
              _getHeading(context),
            ]
        )
    );
  }

  Padding _getLoadingIndicator() {
    return const Padding(
        child: SizedBox(
            child: CircularProgressIndicator(
                strokeWidth: 3
            ),
            width: 32,
            height: 32
        ),
        padding: EdgeInsets.only(bottom: 16)
    );
  }

  Widget _getHeading(context) {
    return
      const Padding(
          child: Text(
            'Please wait …',
            style: TextStyle(
                color: Colors.black,
                fontSize: 16
            ),
            textAlign: TextAlign.center,
          ),
          padding: EdgeInsets.only(bottom: 4)
      );
  }


}