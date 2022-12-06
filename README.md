# Mastering-42
less pain, more gain. An opinionated strategy guide on how to get the most out of 42 School, and/or learning to program in general.

This guide is written from 42 Students for 42 Students.
Its [website](https://haglobah.github.io/Mastering-42) is built on top of [Pollen](https://pollenpub.com).

# Why?
You probably only got to this guide in the first place because there was something missing you needed to properly go on with your work at 42.
We've seen and experienced these obstacles, and decided to do something about it.

With this guide, we try to get everyone of us the team mate we would've liked to have when we were stuck, or even unsure how to start.

# Getting up and Running

1. Download & Install [Racket](https://racket-lang.org): [download.racket-lang.org](https://download.racket-lang.org)
2. Install [Pollen](https://pollenpub.com):
```
λ raco pkg install pollen
```
3. Fork this repo
4. (when creating new files, add them to ```index.ptree```)
4. Install the dependecies for the repo:
```
λ raco pkg install --auto sha
```
4. Start Pollens' project server:
```
λ raco pollen start
```
5. edit some file; reload your browser window; see the change.

# How do I get that damn "♢"?
If you're using VS Code, open your ```keybindings.json``` and paste the following:
```
{"key": "ctrl+alt+l",
 "command": "type",
 "args": {
 "text": "◊"},
 "when": "editorTextFocus"}
 ```

# Contributing

First of all, thanks for considering to contribute! :blush:

There are two main ways to contribute:

1. Fixing/adding something to an existing guide.
2. Adding a whole new guide.

For both of these options, you have to:

1. Fork the repo
2. Create a new branch _that is named after the issue you want to fix_.
3. Add what you want to add
   1. For typos/small fixes, just edit the file, and commit.
   2. For new guides, you have to add the file to `index.ptree` as well as to `index.poly.pm`, as well as to git.
4. Open the pull request
5. Assign a person to review your fix/guide

Also, there is the option to create issues — the better they are described, the more we can do about it.

If you want to join us (to maintain the repo) or have any other questions, just write @bhagenlo or @skienzle on Slack. 

# Writing

In particular, so that you can start writing more easily if you want to write articles on your own, here are all the commands you can use:

| Tag | Effect |
|------------------------------|-----------------------------------------------------------------|
| ```◊title[#:sub "by marvin" #:version "42"]{libft}``` | Title of the Subpage, along with its subtitle and version. |
| ```◊heading[1]{libft}``` | A Heading with its _level_(1 in this case). |
| ```◊sec[#:sub "Don't try this at Home!" 2 #:open? #f]{Burning your PC.}``` | A Section which can be opened (or closed), with subtitle and level. |
| ```◊link["https://intra.42.fr"]{The Intra}``` | A Link. |
| ```◊b{bold}``` | **bold** text. |
| ```◊e{italic}``` | _emphasized_ text. |
| ```◊quote-block{This is a quote.}``` | An indented blockquote (those blue ones) |
| ```◊narr{Here speaks the narrators voice..}``` | Non-indented monospaced grey text. |
| ```◊irr{You've heard that already, time and again}``` | Text that is more and more irrelevant, though it might be helpful as a reminder a few times before it vanishes completely (during the course of the holy graph, for example). |
| ```◊hline{}``` | A red, horizontal line. |
| ```◊spoiler{This could spoil you. Do you want that?}``` | A Spoiler that only makes itself visible on click. |
| ```◊hint[#:type "info"]{This is a piece of information for the reader}``` | A hint for the reader. It can be a ```info```(blue), ```warning```(yellow), ```error```(red) or a ```resolved```(green) |
| ```◊sec-hint[#:type "error" "Click here to expand."]{This is what gets shown on expansion.}``` | An expandable hint. (that expands and shrinks on click)|
| ```◊img["./path/to/img.jpg" #:height 10 #:width 100]{This is a caption.}``` | An image  —  beware that if you explicitly set height _and_ width, you most likely distort the picture.|
| ```◊ol{◊li{}}``` | An ordered list. |
| ```◊ul{◊li{}}``` | An unordered list. |
| ```◊ol-mark{a.}/◊ul-mark{o}``` | Something that formats anything as a list point, so that one can mention it in the accompanying text.|
| ```◊code{#this is code.}``` | Inline code. |
| ```◊code-block['python]{#this is python code.}``` | A code block, with syntax highlighting.|

