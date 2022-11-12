import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

enum CommunityType { Public, Private, Restricted }

class CreateCommunityScreen extends StatefulWidget {
  const CreateCommunityScreen({super.key});
  static const routeName = 'create-community-screen';

  @override
  State<CreateCommunityScreen> createState() => _CreateCommunityScreenState();
}

class _CreateCommunityScreenState extends State<CreateCommunityScreen> {
  final _formKey = GlobalKey<FormState>();
  final _communityNameController = TextEditingController();
  CommunityType? _communityTypeChoosen = CommunityType.Private;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello'),
        ),
        body: Center(
          child: OutlinedButton(
            onPressed: () => showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    SizedBox(
                      width: 70.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Create a community'),
                              IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
                          const Divider(),
                          const Text('Name'),
                          Row(
                            children: const [
                              Text(
                                'Community names including capitalization cannot be changed.',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                              Tooltip(
                                richMessage: TextSpan(
                                    text:
                                        'Names cannot have spaces (e.g,\n "r/bookclub" not "r/book club"),\nmust be between 3-21 characters,\nand underscores("_") are the only\nspecial characters allowed.Avoid\n using solely trademarked names\n (e.g., "r/FansOfAcme" not\n "r/Acme").'),
                                child: Icon(
                                  Icons.error_outline,
                                  size: 14,
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.transparent,
                          ),
                          Form(
                              child: TextFormField(
                            key: _formKey,
                            textAlignVertical: TextAlignVertical.center,
                            controller: _communityNameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              prefixText: 'r/',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: 'r/',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide:
                                      BorderSide(color: Colors.black12)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none),
                              // counterText: "",
                              labelStyle: const TextStyle(
                                fontSize: 15,
                              ),
                              filled: true,
                              //errorText: (!uniqueCommunityName) ? errorMessage : null,
                              errorStyle: const TextStyle(
                                  color: Colors.grey, fontSize: 10),
                              // suffixIcon: ClearTextField(
                              //     typed: _typed,
                              //     clearTextField: clearTextField,
                              //     count: count)
                            ),
                            maxLength: 21,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          )),
                          const Text('Community type'),
                          ListTile(
                            title: RichText(
                              text: const TextSpan(
                                text: 'Public',
                                style: TextStyle(fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        ' Anyone can view, post, and comment to this community',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            leading: Radio<CommunityType>(
                              groupValue: _communityTypeChoosen,
                              value: CommunityType.Public,
                              onChanged: (CommunityType? value) {
                                setState(() {
                                  _communityTypeChoosen = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: RichText(
                              text: const TextSpan(
                                text: 'Restricted',
                                style: TextStyle(fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        ' Anyone can view this community, but only approved users can post',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            leading: Radio<CommunityType>(
                              groupValue: _communityTypeChoosen,
                              value: CommunityType.Restricted,
                              onChanged: (CommunityType? value) {
                                setState(() {
                                  _communityTypeChoosen = value;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            title: RichText(
                              text: const TextSpan(
                                text: 'Private',
                                style: TextStyle(fontSize: 15),
                                children: <TextSpan>[
                                  TextSpan(
                                    text:
                                        ' Only approved users can view and submit to this community',
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                            leading: Radio<CommunityType>(
                              groupValue: _communityTypeChoosen,
                              value: CommunityType.Private,
                              onChanged: (CommunityType? value) {
                                setState(() {
                                  _communityTypeChoosen = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            child: const Text('Create Community'),
          ),
        ));
  }
}
