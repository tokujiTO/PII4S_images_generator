import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  // Custom function to build the menu items
  Widget _buildSettingTile(String title, VoidCallback onTap) {
    // We use a ListTile to get the classic row look with a tap effect
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white, // Text color is white for contrast
              fontSize: 16.0,
            ),
          ),
          // Sets the overall height of the row to match the image
          dense: true, 
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          onTap: onTap,
          // Optional: Add a subtle hover or tap color if needed, though often default is fine
          // focusColor: Colors.grey[800],
          // hoverColor: Colors.grey[800],
        ),
        // This adds the thin white separator line between items, as seen in the image
        const Divider(
          color: Colors.white,
          height: 1, // Line thickness
          thickness: 0.5,
          indent: 0,
          endIndent: 0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // The main container for the page
    return Scaffold(
      // Set the background color to black/dark for the whole page
      backgroundColor: Colors.black,

      // --- Custom AppBar to match the image's top bar ---
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0), // Standard app bar height
        child: AppBar(
          // Set the specific blue-green color for the header background
          backgroundColor: const Color(0xFF00A3A3), // A shade close to the image
          elevation: 0, // No shadow for a flat look

          // Leading widget for the back button (the left-pointing arrow)
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios, // A common icon for back
              color: Colors.white, // Icon color is white
              size: 24,
            ),
            onPressed: () {
              // Action when the back button is pressed
              Navigator.pop(context);
            },
          ),
          
          // No title is shown in the image, so we leave the title out or set it to a SizedBox.
          title: const SizedBox.shrink(),
          centerTitle: false,
        ),
      ),
      
      // --- Body with the menu options ---
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Redefinir nome
            _buildSettingTile('Redefinir nome', () {
              // TODO: Add navigation or action for "Redefinir nome"
              debugPrint('Redefinir nome tapped');
            }),

            // Redefinir senha
            _buildSettingTile('Redefinir senha', () {
              // TODO: Add navigation or action for "Redefinir senha"
              debugPrint('Redefinir senha tapped');
            }),

            // Redefinir email
            _buildSettingTile('Redefinir email', () {
              // TODO: Add navigation or action for "Redefinir email"
              debugPrint('Redefinir email tapped');
            }),
            
            // Excluir conta - The last item
            // We use the same tile builder, and the divider is handled inside
            _buildSettingTile('Excluir conta', () {
              // TODO: Add navigation or action for "Excluir conta"
              debugPrint('Excluir conta tapped');
            }),
            
            // Note: The original image seems to have a slightly thicker line/divider 
            // after the last item 'Excluir conta'. If you want to perfectly replicate
            // that look, you'd add a final Divider here:
            // const Divider(color: Colors.white, height: 1, thickness: 0.5),

            // If the original image implies the menu items are inside a fixed-height 
            // container, you might need to adjust the structure. But a simple 
            // Column/SingleChildScrollView is standard for a scrollable menu.
          ],
        ),
      ),
    );
  }
}
