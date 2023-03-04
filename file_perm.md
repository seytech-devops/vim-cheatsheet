Linux umask command

 mask that controls how file permissions are set for newly created files. In one case it also influences how the file permissions are changed explicitly

The umask value will be used to appropriately modify the default fmask for file permissions (base permission 0666) and dmask for directory/folder permissions (base permission 0777).

The effective fmask and dmask values will be calculated by deducting the umask value (Octal calculations).

So a umask 0022 would result in fmask to get a value 0644 (i.e. 0666 - 0022) while dmask would be 0755 (i.e. 0777 - 0022).

The umask 0077 prevent files from being created with any access not only to the world (indicated by the ultimate octal digit) but also your group members (indicated by the penultimate octal digit).




https://en.wikipedia.org/wiki/Umask


About umask
Return, or set, the value of the system's file mode creation mask.
Description
On Linux and other Unix-like operating systems, new files are created with a default set of permissions. Specifically, a new file's permissions may be restricted in a specific way by applying a permissions "mask" called the umask. The umask command is used to set this mask, or to show you its current value.
umask Syntax
umask [-S] [mask]
Options
-S	Accept a symbolic representation of a mask, or return one.	mask	If a valid mask is specified, the umask is set to this value. If no mask is specified, the current umask value is returned.
What Are Permissions, And How Do They Work?
As you may know, each file on your system has associated with it a set of permissions that are used to protect files: a file's permissions determine which users may access that file, and what type of access they have to it.
There are three general classes of users:
The user who owns the file ("User")
Users belonging to the file's defined ownership group ("Group")
Everyone else ("Other")
In turn, for each of these classes of user, there are three types of file access:
The ability to look at the contents of the file ("Read")
The ability to change the contents of the file ("Write")
The ability to run the contents of the file as a program on the system ("Execute")
So, for each of the three classes of user, there are three types of access. Taken together, this information makes up the file's permissions.
How Are Permissions Represented?
There are two ways to represent a file's permissions: symbolically (using symbols like "r" for read, "w" for write, and "x" for execute) or with an octal numeric value.
For example, when you list the contents of a directory at the command line using the ls command as follows:
ls -l 
you will see (among other information) the file permission information for each file. Here, it is represented symbolically, which will look like the following example:
-rwxr-xr-- 
There are ten symbols here. The first dash ("-") means that this is a "regular" file, in other words, not a directory (or a device, or any other special kind of file). The remaining nine symbols represent the permissions: rwxr-xr--. These nine symbols are actually three sets of three symbols each, and represent the respective specific permissions, from left to right:
symbols	meaning	rwx	the file's owner may read, write, or execute this file as a process on the system.	r-x	anyone in the file's group may read or execute this file, but not write to it.	r--	anyone at all may read this file, but not write to it or execute its contents as a process.
Specifying The File Creation Mask Using Symbols
The general symbolic form of a mask is as follows:
[user class symbol(s)][permissions operator][permission symbol(s)][,]...
permission symbol is any combination of r (read), w (write), or x (execute), as described above.
user class symbol may be one or more of the following:
u	User (the owner of the file)	g	Group (any member of the file's defined group)	o	Other (anyone else)	a	All (equivalent to ugo)
permissions operator may be one of the following:
+	allow the specified file permissions to be enabled for the specified user classes (permissions that are not specified are unchanged in the mask)	-	prohibit the specified file permissions from being enabled for the specified user classes (permissions that are not specified are unchanged in the mask)	=	allow the specified file permissions to be enabled for the specified user classes (permissions not specified will be prohibited by the mask during file creation)
So, for example, the following umask command:
umask u+w
sets the mask so that when files are created, they will have permissions which allow write permission for the user (file owner). The rest of the file's permissions would be unchanged from the operating system default.
Multiple changes can be specified by separating multiple sets of symbolic notation with commas (but not spaces!). For example:
umask u-x,g=r,o+w
This command will set the mask so that when subsequent files are created, they will have permissions that:

prohibit the execute permission from being set for the file's owner (user), while leaving the rest of the owner permissions unchanged;

enable read permission for the group, while prohibiting write and execute permission for the group;

enable write permission for others, while leaving the rest of the other permissions unchanged.
Note that if you use the equals operator ("="), any permissions not specified will be specifically prohibited. For example, the command
umask a=
Will set the file creation mask so that new files are inaccessible to everyone.
Specifying the File Creation Mask Using Numeric Representation
The file creation mask can also be represented numerically, using octal values (the digits from 0 to 7). When using octal numeric representation, certain numbers represent certain permissions, and these numbers are added or subtracted from each other to represent the final, combined permissions value. Specifically, the numbers 1, 2, and 4 represent the following permissions:
number	permission	4	read	2	write	1	execute
These numbers are used because any combination of these three numbers will be unique. The following table illustrates their unique combinations:
read value +	write value +	execute value =	combined value:	symbolic equivalent:	0	0	0	0	 	0	0	1	1	x	0	2	0	2	w	0	2	1	3	wx	4	0	0	4	r	4	0	1	5	rx	4	2	0	6	rw	4	2	1	7	rwx
For each class of user, one digit can be used to represent their permissions; using the example above, we could represent the symbolic permission of rwxr-xr-- using the three-digit octal number 754. The order of the digits is always the same: User, Group, Other.
The Other Permission Digit
In octal representations of file permissions, there are actually four digits. The three important digits we've discussed are the last three digits. The first digit is a special file permission indicator, and for the purposes of this discussion can be considered always to be zero. So from here on out, when we discuss file permission 777, it may also be referred to as 0777.
So How Does The Umask Actually Work?
The umask masks permissions by restricting them by a certain value.
Essentially, each digit of the umask is "subtracted" from the OS's default value to arrive at the default value that you define. It's not really subtraction; technically, the mask is negated (its bitwise compliment is taken) and this value is then applied to the default permissions using a logical AND operation. The result is that the umask tells the operating system which permission bits to "turn off" when it creates a file. So it's not really subtraction, but it's a similar concept, and thinking of it as subtraction can help to understand it.
In Linux, the default permissions value is 666 for a regular file, and 777 for a directory. When creating a new file or directory, the kernel takes this default value, "subtracts" the umask value, and gives the new files the resulting permissions.
This table shows how each digit of the umask value affects new file and directory permissions:
umask digit	default file permissions	default directory permissions	0	rw	rwx	1	rw	rw	2	r	rx	3	r	r	4	w	wx	5	w	w	6	x	x	7	(no permission allowed)	(no permission allowed)
So if our umask value is 022, then any new files will, by default, have the permissions 644 (666 - 022). Likewise, any new directories will, by default, be created with the permissions 755 (777 - 022).
umask examples
To view your system's current umask value, enter the command:
umask
which will return your system's umask as a four-digit octal number, for example:
0002
Again, the first zero is a special permission digit and can be ignored; for our purposes, 0002 is the same as 002.
To view this as a symbolic representation, use the -S flag:
umask -S
Which will return the same value symbolically, for example:
u=rwx,g=rwx,o=rx
where u stands for user, g stands for group, and o stands for other. This is telling us the So if we create a new file, it will have the default permissions 664, which is 666 (the default permissions for files) masked by 002 (our umask value).
Let's test this by creating a new file with the touch command:
touch testfile
And now let's get a directory listing for that file:
ls -l testfile
-rw-rw-r-- 1 myusername myusername 0 Jan 7 14:29 testfile
As expected, the new file has permissions -rw-rw-r--, or 0664: The owner and group may read or write the file, and others may only read it.
Now let's change the umask. To set a umask of 022, use the command:
umask 022
This is the same as running umask 0022; if you specify only three digits, the first digit will be assumed to be zero. Let's verify that the change took place:
umask
0022
And now let's create a new file:
touch testfile2
And now let's view its directory listing, along with the first file we created, using the asterisk wildcard ("*") to view all files whose name start with "testfile":
ls -l testfile*
-rw-rw-r-- 1 myusername myusername 0 Jan 7 14:29 testfile
-rw-r--r-- 1 myusername myusername 0 Jan 7 14:39 testfile2
As you can see, testfile2 has the permissions 644.
Here are some other example umask commands:
umask a+r
Sets the mask so that new files will allow all users to read them; other permissions will be unchanged from the default.
umask a-x
Sets the mask so that new files will not initially be executable by any user; other default permissions unchanged from defaults.
umask u=rw,go=
Sets the mask so that new files will be readable and writable by the user who owns the file, but may not be executed; group members and others will have no permissions to access the file.
umask 777
Make new files inaccessible to everyone - no one can read, write, or execute them.
umask 000
Make new files completely accessible (read, write, and execute) to absolutely everyone. However, this is a bad idea. Don't do this.
Related commands
chmod — Change the permissions of files or directories.
csh — The C shell command interpreter.
ksh — The Korn shell command interpreter.
sh — The Bourne shell command interpreter.
