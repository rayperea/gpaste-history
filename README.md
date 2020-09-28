# gpaste-history
A script to move forward and backward through the gpaste clipboard history


## Requirements
This script requires the following packages in order to work correctly:

- **gpaste** - Of course, this utility manages your clipboard history and the whole reason for having this script
- **bash** - This is the shell that this script was written for. Although this script may work in other shells, it hasn't been tested
- **recode** - This utility is used to convert ASCII text from your clipboard into HTML to be displayed
- **zenity** - This utility is used to display and select the clipboard history. If you don't have a desktop that supports zenity, you'll need to modify the script to use something else.


## Usage
To use this script simply execute either of the following commands

```shell script
sh gpasteHistory.sh backward
sh gpasteHistory.sh forward
```

The `backward` command will move the history backward and the `forward` command will move the history forward

When either of these commands are executed, a dialog box is shown that allows the user to select the clipboard history entry shown.
The user simply needs to click button or hit the entry key to select the displayed history entry and copy it to the clipboard


## Keyboard Shortcuts
If you are using a desktop environment that supports keyboard shortcuts, you can (and should) assign the commands to a
keyboard shortcut like `<ctrl>+<arrow-right>` and `<ctrl>+<arrow-left>`

For example:

Assign: `<ctrl>+<right-arrow>` to the command `sh /path/to/gpasteHistory.sh forward`  
Assign: `<ctrl>+<left-arrow>` to the command `sh /path/to/gpasteHistory.sh backward`

Once keyboard shortcuts are assigned, you should be able to move backward and forward very quickly through the clipboard
history using the keyboard shortcuts you assigned
