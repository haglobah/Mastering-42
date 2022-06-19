#lang pollen

◊title[#:sub "by tpeters"]{VSCode Debugger}

◊sec["Compile with -g flag" 1 #:open? #f]{
    To debug your code you need to compile it with the –g flag. You don't need to compile every file with that flag, just the files you want to debug. (e.g. If you're on a project which allows the use of the Libft, then you probably don't need to compile the Libft with the extra flag but only the "new" code) One easy way to do this is by adding a target-specific variable value to your CFLAGS-Variable and adding a debug Target:
    ◊code-block['make]{
        CFLAGS = -Wall -Wextra –Werror
        # ...
        debug : CFLAGS += -g
        debug : all
    }
}

◊sec["Create a launch.json File" 1 #:open? #f]{
    To create the launch.json select a .c file in the editor and klick on the button on the Left and Press on the "create a launch.json file".
    ◊img["../src/Images/vscode_debugger/run_and_debug_button.png"]{}
    Then press on the “C++ (GDB/LLDB)”, since we want to use the gdb/lldb debugger and the new launch.json should open in the editor.
    ◊img["../src/Images/vscode_debugger/select_gdb.png"]{}
}

Paste following code into the launch.json:

◊code-block['json]{
    {
        // Use IntelliSense to learn about possible attributes.
        // Hover to view descriptions of existing attributes.
        // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
        "version": "0.2.0",
        "configurations": [
            {
                "name": "Launch",
                "type": "cppdbg",
                "program": "${workspaceFolder}/<executable Name>",
                "args": [],
                "cwd": "${workspaceFolder}",
                "request": "launch",
                "MIMode": "lldb"
            }
        ]
    }
}

You need to change the value for "program" to the path to the executable and if your program needs any arguments you can specify them in "args". If you're running your project at home on a linux/windows you can try changing the "MIMode" to "gdb".

◊sec["Example" 1 #:open? #f]{
    For example if you want to call your main.exe with the arguments 1 2 3: ("main.exe 
    1 2 3")
    ◊code-block['json]{
        // ...
        "program": "${workspaceFolder}/main.exe",
        "args": ["1", "2", "3"],
        // ...
    }
}

◊sec["Running the Debugger" 1 #:open? #f]{
    On the left the big blue "Run and Debug" button should disappear now and you can now see a small green triangle at the top next to the name specified in the "name" of the json.
    ◊img["../src/Images/vscode_debugger/green_triangle.png"]{}
    If you now press F5 (or press that smol green triangle) your program should be executed and if it has any output you should also be able to see that in the debug-terminal:
    ◊img["../src/Images/vscode_debugger/debugoutput.png"]{}
}

◊sec["The useful stuff a Debugger can do for you" 1 #:open? #f]{
    ◊img["../src/Images/vscode_debugger/breakpoint.png"]{}
    If you go to one of your c files and set a Breakpoint by clicking to the left of that code line and then start the Debugger (F5/green triangle) the code gets executed until that Breakpoint but not further:(e.g. look at the terminal output for this example)
    ◊img["../src/Images/vscode_debugger/running_debugger.png"]{}
    At the top in the middle a new Menu popped up, which lets you either run until the next Breakpoint, run one line(F10) or jump into that function(F11). If you try to step into a function which wasn't compiled with the –g flag it just gets executed, but you can't see it step by step.

    And if you have any function parameters or Variables you can see their values on the top left: 
    ◊img["../src/Images/vscode_debugger/local-variables.png"]{}
}

◊sec["Pointers" 1]{
◊ul{
    ◊li{◊link["https://go.microsoft.com/fwlink/?linkid=830387"]{Official Debugger Tutorial}}
}

}