# Clean before building
xcodebuild clean -target extension.signing.demo -configuration Release
# Archive the project
xcodebuild archive -scheme extension.signing.demo -configuration Release -archivePath Extension_Without_Signing_Demo.xcarchive
# Export archive with given options
xcodebuild -exportArchive -archivePath Extension_Without_Signing_Demo.xcarchive -exportOptionsPlist exportOptionsCI.plist -exportPath .
rm Extension_With_Signing_Demo.app || true
# Rename to make file name more clear
mv extension.signing.demo.app Extension_Without_Signing_Demo.app
# Sign only the app
declare -a to_sign_paths=(
      "Extension_Without_Signing_Demo.app")
for i in "${to_sign_paths[@]}"; do 
  codesign -s "Developer ID Application: XXXXXXXXX (XXXXXXX)" -f --timestamp -o runtime "$i"
done
# Create zip archive
ditto -c -k --sequesterRsrc --keepParent Extension_Without_Signing_Demo.app Extension_Without_Signing_Demo.zip

# Here you could also notarize the app, although it does not make a difference (here notarization will fail, because the extension is not signed)
# xcrun notarytool submit Extension_Without_Signing_Demo.zip --key XXXXXXXX --key-id XXXXXXXX --issuer XXXXXXXX --wait
