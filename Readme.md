# Extensions do not open when they are signed using the command line tools
Hello there
We have recently discovered an issue where extensions in an app bundle would not open if they are signed (using codesign, in our case). We are assuming that this is because they can either not be run by the main app (because of some signing/security issue) or that the system immediately kills them because they are incorrectly signed.

## The setup
1. Simply create a main app containing any **app extension** (we have tried FinderSync and Share)
2. Archive and export the app using the **xcodebuild** command (though exporting it through Xcode works aswell)
3. Sign the app container (.app)  and the extension (.appex file in Contents/PlugIns).
4. Open the app
5. The Extension won't be visible in the Preferences and is not running

## The problem
If we do not sign the app extension, the main app and app extension start as expected (this not an option though, because notarization will fail when the app extension is not signed). If we sign the app extension, the app extension will not start (when running the main app). We assume that this is because macOSs Gatekeeper immediately kills them when started. But we are not sure why.

## Demo Project
You can find a very simple demo project in the Github Repository linked below. This demo project only contains an almost empty main app, a completely default App Extension (everything is left as when generated, except the myFolderURL which was changed to / for testing purposes).

The demo project also contains two scripts, one which builds app and signs it completely (with app extension) and one which builds the app and signs everything but the App Extension. Both scripts export a .app file, and a zip file. 

Make sure to **insert the name of your Developer ID Application Certificate into the script (simply replace the XXXXXXX with the name of your certificate)**

To reproduce our issue:
1. Run the unsigned app and open the preferences with the button to confirm that the app extension have been added.
2. **delete the app** (to make sure the app extension is not still in the preferences when testing the signed app)
3. Open the app with the signed extension and you'll see that upon opening the app and viewing the preferences that the app extension is not present in the list (and therefore not open). This can be tested using the Activity Monitor or 'top' command as well.

## Conclusion
To summarise: When signing an app extension (Finder Sync in the Demo), the extension does not open/gets killed when the extension is signed. If the extension is not signed everything works as intended. As said, we believe that either signing, notarising, or the gatekeeper might be the cause of this issue, probably this is some issue with our build/sign automation (the demo contains the scripts with our automation code). Can that be the case or are extensions handled differently and we are missing a step?
