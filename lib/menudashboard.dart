import 'package:flutter/material.dart';

final Color backgroundColor = Colors.white;

class MenuDashboardPage extends StatefulWidget {
  @override
  _MenuDashboardPageState createState() => _MenuDashboardPageState();
}

class _MenuDashboardPageState extends State<MenuDashboardPage>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 300);
  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: duration);
    _scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(_controller);
    _menuScaleAnimation =
        Tween<double>(begin: 0.5, end: 1).animate(_controller);
    _slideAnimation = Tween<Offset>(begin: Offset(-1, 0), end: Offset(0, 0))
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          menu(context),
          dashboard(context),
        ],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: ScaleTransition(
        scale: _menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 50.0,
                        backgroundImage: AssetImage('images/me-1.png'),
                        
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Robert Wade",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 22),
                      ),
                      Text(
                        "Developer",
                        style: TextStyle(color: Colors.blueGrey, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Text("💸 Your Payments",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 22)),
                SizedBox(height: 10),
                Text("📝 Overview",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 22)),
                SizedBox(height: 10),
                Text("👨🏼‍💼Profile",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 22)),
                SizedBox(height: 10),
                Text("❓Help",
                    style: TextStyle(color: Colors.blueGrey, fontSize: 22)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: 0,
      bottom: 0,
      left: isCollapsed ? 0 : 0.6 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          animationDuration: duration,
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          color: backgroundColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ClampingScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      InkWell(
                        child: Icon(Icons.menu, color: Colors.blueGrey),
                        onTap: () {
                          setState(() {
                            if (isCollapsed)
                              _controller.forward();
                            else
                              _controller.reverse();

                            isCollapsed = !isCollapsed;
                          });
                        },
                      ),
                      Text("Your Payments",
                          style:
                              TextStyle(fontSize: 24, color: Colors.blueGrey)),
                      Icon(Icons.settings, color: Colors.blueGrey),
                    ],
                  ),
                  SizedBox(height: 50),
                  Container(
                    height: 220,
                    child: PageView(
                      controller: PageController(viewportFraction: 0.8),
                      scrollDirection: Axis.horizontal,
                      pageSnapping: true,
                      children: <Widget>[
                        Image.asset('images/creditcard.png'),
                        Image.asset('images/creditcard.png'),
                        Image.asset('images/creditcard.png'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Transactions",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text("Payment"),
                          subtitle: Text("Company"),
                          trailing: Text("-999"),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(height: 16);
                      },
                      itemCount: 10)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
