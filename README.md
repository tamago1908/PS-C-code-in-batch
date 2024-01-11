# PS-C-code-in-batch
Running multi-line C# code within batch.

This demo uses C# code to disable the window exit button.
## Description
This batch is a demo that allows execution of multiple lines of powershell code.
By being able to execute multiple lines of powershell code, it is possible to derive it to execute C# code as well.
This allows C# code to be executed in a single batch without the need for any additional files.
This code gets the current contents of the batch file with the Get-Content command, extracts only the lines in the range specified by the environment variables startline and endline, and converts them into a ScriptBlock object. The ScriptBlock object is then executed in PowerShell.

**However, it is recommended to use the latest windows version when executing the code. Older versions of windows may not work. At least Powershell 5.0 or later recommended**

It is also not recommended to run the program with administrator privileges granted. In rare cases, antivirus software may falsely detect it as a virus.

A powershell script of 8191 characters or less is recommended.  
You can probably run a powershell script longer than that, but it may be buggy.  
Also, errors in powershell scripts are not traceable. If you want to track errors separately, you need to catch them or run them as a ps1 file  


Permission is hereby granted to redistribute and/or modify this demo and batch in accordance with LICENSE. Feel free to use them.
