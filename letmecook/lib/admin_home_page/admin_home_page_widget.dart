import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'admin_home_page_model.dart';
export 'admin_home_page_model.dart';
import 'package:letmecook/repositories/auth_repository.dart';
import 'package:letmecook/repositories/recipe_repository.dart';

class AdminHomePageWidget extends StatefulWidget {
  const AdminHomePageWidget({super.key});

  @override
  State<AdminHomePageWidget> createState() => _AdminHomePageWidgetState();
}

class _AdminHomePageWidgetState extends State<AdminHomePageWidget> {
  late AdminHomePageModel _model;
  final AuthRepository _authRepository = AuthRepository();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final RecipeRepository _recipeRepository = RecipeRepository();
  late Future<List<Map<String, dynamic>>> _approvedRecipes;

  // Add current page index
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AdminHomePageModel());
    _approvedRecipes = _recipeRepository.getApprovedRecipesWithUsernames();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  void _refreshRecipes() {
    setState(() {
      _approvedRecipes = _recipeRepository.getApprovedRecipesWithUsernames();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Color(0xFFF1F4F8),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Keep the header
            Material(
              color: Colors.transparent,
              elevation: 2.0,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.254,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Color(0xFFE59368),
                ),
                child: Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(16.0, 24.0, 16.0, 24.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'LetMeCook',
                        style: FlutterFlowTheme.of(context)
                            .headlineMedium
                            .override(
                              fontFamily: 'Inter Tight',
                              color: Colors.white,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Content area that changes based on navigation
            Expanded(
              child: <Widget>[
                // Home Page Content
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 60.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.filter_list,
                                        color: Colors.black,
                                        size: 24.0,
                                      ),
                                      SizedBox(width: 8.0),
                                      Expanded(
                                        child: TextField(
                                          controller: _model.searchController,
                                          decoration: InputDecoration(
                                            hintText: 'Search by recipe name...',
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0),
                                            hintStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .override(
                                                      fontFamily: 'Inter',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                          ),
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => _model.performSearch(context),
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                    size: 24.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          'Trending',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Inter Tight',
                                color: Colors.black,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                        FutureBuilder<List<Map<String, dynamic>>>(
                          future: _approvedRecipes,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return Center(
                                  child: Text('No recipes available'));
                            }

                            return Column(
                              children: snapshot.data!
                                  .map((recipe) {
                                    return Material(
                                      color: Colors.transparent,
                                      elevation: 2.0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        height: 200.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16.0),
                                              child: ClipRect(
                                                child: Align(
                                                  alignment: Alignment.center,
                                                  child: Container(
                                                    height: 250,
                                                    child: Center(
                                                      child: Image.network(
                                                        recipe['image'],
                                                        fit: BoxFit
                                                            .contain, // Or use BoxFit.scaleDown if you prefer
                                                        alignment:
                                                            Alignment.center,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  1.0,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  1.0,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.black
                                                  ],
                                                  stops: [0.7, 1.0],
                                                  begin: AlignmentDirectional(
                                                      0.0, -1.0),
                                                  end: AlignmentDirectional(
                                                      0.0, 1.0),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 16.0, 16.0, 16.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      recipe['recipeTitle'] ??
                                                          'Untitled Recipe',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .titleMedium
                                                          .override(
                                                            fontFamily:
                                                                'Inter Tight',
                                                            color: Colors.white,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                    ),
                                                    Text(
                                                      'by ${recipe['username']}',
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodySmall
                                                          .override(
                                                            fontFamily:
                                                                'Inter Tight',
                                                            color:
                                                                Colors.white70,
                                                            letterSpacing: 0.0,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  })
                                  .toList()
                                  .divide(SizedBox(height: 24.0)),
                            );
                          },
                        ),
                      ].divide(SizedBox(height: 24.0)),
                    ),
                  ),
                ),
                // List Page Content
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        // Add padding here
                        padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0,
                            16.0, 16), // Adjust padding values as needed
                        child: Text(
                          'My List',
                          style: FlutterFlowTheme.of(context)
                              .headlineSmall
                              .override(
                                fontFamily: 'Inter Tight',
                                color: Colors.black,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            child: ListTile(
                              title: Text('Recipe ${index + 1}',
                                  style: TextStyle(color: Colors.black)),
                              leading: Icon(
                                Icons.restaurant_menu,
                                color: Colors.black,
                              ),
                              subtitle: Text('Recipe description goes here',
                                  style: TextStyle(color: Colors.black)),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // Profile Page Content
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      24.0, 24.0, 24.0, 24.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Card(
                        color: Colors.white,
                        child: ListTile(
                          leading: Icon(Icons.settings, color: Colors.black),
                          title: Text('Edit Profile',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.pushNamed('upload_recipe_page');
                        },
                        child: Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(Icons.article, color: Colors.black),
                            title: Text('Upload Recipe',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          context.pushNamed('pending_approval_recipe_page');
                        },
                        child: Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(Icons.pending, color: Colors.black),
                            title: Text('View Pending Approval Recipes',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Use GoRouter to navigate to the login page when Logout is clicked
                          _authRepository.logout();
                          GoRouter.of(context).go('/loginPage');
                        },
                        child: Card(
                          color: Colors.white,
                          child: ListTile(
                            leading: Icon(Icons.logout, color: Colors.black),
                            title: Text('Logout',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ][currentPageIndex],
            ),

            // Bottom Navigation Bar
            Material(
              color: Colors.transparent,
              elevation: 4.0,
              child: Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          currentPageIndex = 0;
                          _refreshRecipes(); // Trigger a refresh if already on homepage
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home,
                            color: currentPageIndex == 0
                                ? Color(0xFFE59368)
                                : FlutterFlowTheme.of(context).secondaryText,
                            size: 28.0,
                          ),
                          Text(
                            'Home',
                            style:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      fontFamily: 'Inter',
                                      color: currentPageIndex == 0
                                          ? Color(0xFFE59368)
                                          : FlutterFlowTheme.of(context)
                                              .secondaryText,
                                      letterSpacing: 0.0,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          currentPageIndex = 1;
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.list,
                            color: currentPageIndex == 1
                                ? Color(0xFFE59368)
                                : FlutterFlowTheme.of(context).secondaryText,
                            size: 28.0,
                          ),
                          Text(
                            'List',
                            style:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      fontFamily: 'Inter',
                                      color: currentPageIndex == 1
                                          ? Color(0xFFE59368)
                                          : FlutterFlowTheme.of(context)
                                              .secondaryText,
                                      letterSpacing: 0.0,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          currentPageIndex = 2;
                        });
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_outline,
                            color: currentPageIndex == 2
                                ? Color(0xFFE59368)
                                : FlutterFlowTheme.of(context).secondaryText,
                            size: 28.0,
                          ),
                          Text(
                            'Me',
                            style:
                                FlutterFlowTheme.of(context).bodySmall.override(
                                      fontFamily: 'Inter',
                                      color: currentPageIndex == 2
                                          ? Color(0xFFE59368)
                                          : FlutterFlowTheme.of(context)
                                              .secondaryText,
                                      letterSpacing: 0.0,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
