# PSEmoji
[![PowerShell Gallery Version](https://img.shields.io/powershellgallery/v/PSEmoji)](https://www.powershellgallery.com/packages/PSEmoji/1.0.5)

Using emojis with Powershell has never been more fun and easy! 
But, what's the excitement about it? well if you have watched <a href="https://www.youtube.com/watch?v=8gw0rXPMMPE">this Microsoft new windows terminal release trailer</a> you know what I'm saying right?!

That's right, amongst all amazing features Microsoft has been providing with the new windows terminal one is the ability to render beatiful emojis!

### Why I created this at first place?
In order to display emojis in your terminal, you must do some UTF-32 encoding, the downside is that you would have to do it everytime, you could of course save a static variable in your Powershell profile, or even creating your own function for it, that's fine, but not super straight forward right? 

### So, why should I use this?
Because its super fun and easy! you can have how many emojis available you want in your terminal, and you can organize them in categories the way you want, and you can easily carry them with you anywhere you are!, how cool is that? read through this document to see how it works :)
### Installation
```PowerShell
# install module
Install-Module -Name PSEmoji -Repository PSGallery

# import module
Import-Module -Name PSEmoji
```
### How to access your emojis
After you install and import <b>PSEmoji</b> module, this will export a new variable <b>$PSEMOJI</b>.  
The <b>$PSEMOJI</b> variable is an object instance of a custom class <b>psemoji</b> and this is what you'll use for accessing your emojis.  
The emojis will be stored on nested properties of property emojis.
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

### Creating new emoji category and adding a new emoji to it
![example](/media/new_category_example.png)
