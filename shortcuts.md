##Cursor Movement Commands

CTRL + O 
CTRL + I jump forward

w and e  go forward
W and E  go forward with whitespace and punctuation

b and ge go backward
B and gE take whitespace and punctuation into account

f + (input a letter) jumps ON the next defined letter forward
F + (letter) goes back

t + (input a letter) jumps BEFORE the next letter 
T goes back

(line number/) + G or :n Cursor goes to the specified (n) line


h  left

l  right

k up one line

j down one line


(ex. 10G goes to line 10)

^F (CTRl F) Forward screenful

^B Backward screenful

^f One page forward

^b One page backward

^U Up half screenful

^D Down half screenful

$ Move cursor to the end of current line

0 (zero) Move cursor to the beginning of current line

w Forward one word

b Backward one word

##Text Deletion Commands
x Delete character

dw Delete word from cursor on

db Delete word backward

dd Delete line

d$ Delete to end of line

d^ (d caret, not CTRL d) Delete to beginning of line

Yank (has most of the options of delete)-- VI's copy commmand

yy yank current line

y$ yank to end of current line from cursor

yw yank from cursor to end of current word

5yy yank, for example, 5 lines

Paste (used after delete or yank to recover lines.)

p paste below cursor

P paste above cursor

"2p paste from buffer 2 (there are 9)

u Undo last change

Ctrl + R  (redo)

U Restore line

J Join next line down to the end of the current line

File Manipulation Commands

:w Write workspace to original file

:w file Write workspace to named file

:e file Start editing a new file

:r file Read contents of a file to the workspace

To create a page break, while in the insert mode, press the CTRL key

And l. ^L will appear in your text and will cause the printer to start

A new page.

##Other Useful Commands
Most commands can be repeated n times by typing a number, n, before

the command. For example 10dd means delete 10 lines.

. Repeat last command

cw Change current word to a new word

r Replace one character at the cursor position

R Begin overstrike or replace mode  use ESC key to exit

:/ pattern Search forward for the pattern

:? pattern Search backward for the pattern

n (used after either of the 2 search commands above to

continue to find next occurrence of the pattern.

:g/pat1/s//pat2/g replace every occurrence of pattern1 (pat1) with

pat2

Example :g/tIO/s//Ada.Text_IO/g

This will find and replace tIO by Ada.text_IO everywhere in the file.

:g/a/s// /g replace the letter a, by blank

:g/a/s///g replace a by nothing

note: Even this command be undone by u
