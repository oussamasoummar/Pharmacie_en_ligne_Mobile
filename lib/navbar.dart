import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final bool isExpanded;
  final Function(bool) onToggle;

  const Navbar({
    Key? key,
    required this.isExpanded,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: isExpanded ? 180 : 70,
      color: Colors.white,
      child: Column(
        children: [
          // Sidebar Header
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                if (isExpanded) SizedBox(width: 8.0),
                if (isExpanded)
                  Text(
                    'Patient',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView(
              children: [
                _buildMenuItem(Icons.home, 'Home', '/patient/home', context),
                _buildMenuItem(Icons.local_pharmacy, 'Pharmacie', '/patient/pharmacie', context),
                _buildMenuItem(Icons.history, 'Commandes', '/patient/commande', context),
                _buildMenuItem(Icons.history, 'Ordonnances', '/patient/ordonnance', context),
                _buildMenuItem(Icons.location_on, 'location', '/patient/location', context)

              ],
            ),
          ),
          // Sidebar Footer
          if (isExpanded) Divider(),
          ListTile(
            leading: Icon(Icons.logout),
            title: isExpanded ? Text('Logout') : null,
            onTap: () {
              Navigator.pushNamed(context, '/login');
            },
          ),
          GestureDetector(
            onTap: () => onToggle(!isExpanded),
            child: Container(
              width: 20,
              color: Colors.green,
              child: Center(
                child: Icon(
                  isExpanded ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 16.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, String routeName, BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: isExpanded ? Text(title) : null,
      onTap: () {
        Navigator.pushNamed(context, routeName); // Navigate to the route
      },
    );
  }

}
