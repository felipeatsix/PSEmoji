# PSEmoji
[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/PSEmoji?style=flat)](https://www.powershellgallery.com/packages/PSEmoji/1.0.5) [![PowerShell Gallery](https://img.shields.io/powershellgallery/dt/PSEmoji?color=green&style=flat)](https://www.powershellgallery.com/packages/PSEmoji/1.0.5)

Render emojis on your scripts outputs :)

### Installation
```PowerShell
# install module
Install-Module -Name PSEmoji -Repository PSGallery

# import module
Import-Module -Name PSEmoji
```
### How to access your emojis
After you install and import <b>PSEmoji</b> module, this will export a new variable <b>$PSEMOJI</b>.  
The <b>$PSEMOJI</b> variable is an object instance of a custom class <b>psemoji</b> and this is what you'll use for accessing your emojis. The emojis will be stored on nested properties of property emojis.
```Powershell
# Syntax example: $PSEMOJI.emojis.[emoji-category].[emoji-name]
$PSEMOJI.emojis.face.happy
```
### Managing your emojis
There are 4 functions for manipulating <b>$PSEMOJI</b>:

```Powershell
# Create new emoji category
New-PSEmojiCategory -Name <string>

# Adds new emojis
Add-PSEmoji -EmojiCategory <string> -EmojiName <string> -EmojiUnicode <string>

# Removes existent emojis
Remove-PSEmoji -EmojiCategory <string> -EmojiName <string>

# Removes existent emoji category
Remove-PSEmojiCategory -Name <string>
```
### Importing / Exporting
There'll be two functions available for importing/exporting your emojis so you can keep your created emojis with you anywhere!
```Powershell
# Export your emojis
Export-PSEmojiUnicodeJson -OutFilePath "[file system path of your choice]"

# Import your emojis
Import-PSEmojiUnicodeJson -Path "[path to your EmojiUnicode.json file]"
```

### Opening unicode charts on a web browser
The <b>$PSEMOJI</b> object contains a method <b>UnicodeCharts_Open()</b> which will pop up your default browser and redirect you to a page with the emoji unicode chart so you can know which emoji unicode input to provide on Add-PSEmoji function.

```Powershell
$PSEMOJI.UnicodeCharts_Open()
```

# DEMO

## Creating new emoji category and adding a new emoji to it
![example](/media/new_category_example.png)
## Running tests with your emojis
![tests](/media/gallery_tests.png)
## Monitoring Computer RAM
![testRam](/media/gallery_checkmark.png)
