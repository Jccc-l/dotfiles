设置总界面

```
Please pick one of the following options:

(1)  Configure settings for history, i.e. command lines remembered
     and saved by the shell.  (Recommended.)

(2)  Configure the new completion system.  (Recommended.)

(3)  Configure how keys behave when editing command lines.  (Recommended.)

(4)  Pick some of the more common shell options.  These are simple "on"
     or "off" switches controlling the shell's features.

(0)  Exit, creating a blank ~/.zshrc file.

(a)  Abort all settings and start from scratch.  Note this will overwrite
     any settings from zsh-newuser-install already in the startup file.
     It will not alter any of your other settings, however.

(q)  Quit and do nothing else.  The function will be run again next time.
--- Type one of the keys in parentheses ---
```

进行zsh的历史保存配置

```
History configuration
=====================

# (1) Number of lines of history kept within the shell.
HISTSIZE=1000                                                                           (not yet saved)
# (2) File where history is saved.
HISTFILE=~/.histfile                                                                    (not yet saved)
# (3) Number of lines of history to save to $HISTFILE.
SAVEHIST=1000                                                                           (not yet saved)

# (0)  Remember edits and return to main menu (does not save file yet)
# (q)  Abandon edits and return to main menu

--- Type one of the keys in parentheses ---
```

1. 设置在shell中保存的历史记录条数（设为`5000`）
2. 设置历史的保存路径（设置为`~/.zsh_history`）
3. 设置保存到文件中的历史记录条数（设为`5000`）

按`0`保存并退出

### 2.设置新的补全系统

```
The new completion system (compsys) allows you to complete
commands, arguments and special shell syntax such as variables.  It provides
completions for a wide range of commonly used commands in most cases simply
by typing the TAB key.  Documentation is in the zshcompsys manual page.
If it is not turned on, only a few simple completions such as filenames
are available but the time to start the shell is slightly shorter.

You can:
  (1)  Turn on completion with the default options.

  (2)  Run the configuration tool (compinstall).  You can also run
       this from the command line with the following commands:
        autoload -Uz compinstall
        compinstall
       if you don't want to configure completion now.

  (0)  Don't turn on completion.
```

选择2，使用compinstall来进行配置

```
--- Type one of the keys in parentheses --- 2I haven't found any existing completion definitions.
If you have some already defined by compinstall, edit the name of the
file where these can be found.  Note that this will only work if they
are exactly the form in which compinstall inserted them.  If you leave
the line as it is, or empty, I won't search.
file> /home/jccc/.zshrc
Starting a new completion configuration from scratch.
This will be written to the new file /home/jccc/.zshrc.
Note that you will be given a chance to save the new setup
somewhere else at the end.
--- Hit newline to continue or `q' to exit without saving ---

Completion directories /usr/share/zsh/functions/Completion/*
are already in your $fpath, good.
--- Hit newline to continue or `q' to exit without saving ---
```

这里询问我们是否选择已经存在的compinstall配置文件，我们还没有，就直接回车


#### 进入compinstall菜单

```
               *** compinstall: main menu ***
Note that hitting `q' in menus does not abort the set of changes from
lower level menus.  However, quitting at top level will ensure that nothing
at all is actually written out.

1.  Completers:  choose completion behaviour for tasks such as
    approximation, spell-checking, expansion.

2.  Matching control: set behaviour for case-insensitive matching,
    extended (partial-word) matching and substring matching.

3.  Styles for changing the way completions are displayed and inserted.

4.  Styles for particular completions.

c.  Change context (plus more information on contexts).

q.  Return without saving.
0.  Save and exit.

--- Hit choice ---
```

输入1进入补全器的配置

```
              *** compinstall: completer menu ***

Current context: :completion:*

The following completers are available.  Those marked `(*)' are already
set for the context shown above.  If none are selected, the completers will
not be set for this context at all.

1. (*) Basic completion.
2.     Approximate completion:  completion with correction of existing word.
3.     Correction:  correct existing word, no completion.
4.     Expansion: use globbing and parameter substitution, if possible.

o.     Set options for the completers above.
m.     Set completers that modify the behaviour of the four main ones above.
q.     Return without saving.
0.     Done setting completers.
```

1. 基础补全
2. 近似补全：对现有单词进行自动校正的补全
3. 纠正：仅校正现有单词，不执行补全
4. 扩展：尽可能使用通配符匹配和参数替换功能

全都选上，然后输入`o`进入各个补全器的配置

```
              *** compinstall: completer options ***

Current context: :completion:*

The following options are available.  Note that these require the relevant
completers to be present, as set in the menu above this one.

a.     Set options for approximation or correction.
e.     Set options for expansion.
q.     Return without saving.

0.     Done setting options.
```

选`0`，配置近似补全或校正

```
Approximation and correction can correct the errors in what you have typed,
up to a maximum number of errors which you can specify.  Each `error'
is the omission of a character, the addition of a superfluous character,
the substitution of one character by an incorrect one, or transposition of
two different characters.

Current context: :completion:*

To have different values for approximation and correction, you should
change the context appropriately.  For approximation, use
`:completion:*:approximate:*' and for correction use
`:completion:*:correct:*'.

Enter maximum number of errors allowed:

number>
```

选择允许的错误字符数（包括漏字符、错字符、多字符、字符顺序颠倒）

这里输入`2`

```
Select behaviour of numeric prefix.

1.     Numeric prefix is not used by approximation or completion.
2.     Numeric prefix, if provided, gives max number of errors allowed,
       replacing the number you just typed for that one completion.
3.     Numeric prefix, if provided, prevents approximation or completion
       from taking place at all for that one completion.

--- Hit selection ---
```

这里配置通过数字前缀，动态调整当前命令的补全容错阈值

```
You can edit a prompt which will appear above lists of corrections.  The
string `%e' inside the prompt will be replaced with the number of errors
found.  Leave blank for no prompt.  Quotation marks will be added
automatically.
prompt> Found %e error(s). Select correction:
```
这里是配置发现错误时的纠正提示，设置为`Found %e error(s). Select correction:`

保存退出到`completer options`的配置

```
              *** compinstall: completer options ***

Current context: :completion:*

The following options are available.  Note that these require the relevant
completers to be present, as set in the menu above this one.

a.     Set options for approximation or correction.
e.     Set options for expansion.
q.     Return without saving.

0.     Done setting options.

--- Hit selection ---
```

选`e`进入扩展配置

```
The _expand completer can be tuned to perform any of globbing (filename
generation), substitution (anything with a `$' or backquote), or
normal completion (which is useful for inserting all possible completions
into the command line).  For each feature, a 1 turns it on, while a 0 turns
it off; if the feature is unset, that expansion will *not* be performed.

You can also give more complicated mathematical expressions, which can use
the parameter NUMERIC to refer to the numeric argument.  For example, the
expression `NUMERIC == 2' means that the expansion takes effect if you
type ESC-2 (Emacs mode) or 2 (Vi command mode) before the expansion.
Quotes will be added automatically as needed.

g.     Set condition to perform globbing: NUMERIC==1
s.     Set condition to perform substitution: NUMERIC==2
c.     Set condition to perform completion: 1
0.     Done setting conditions (will not be saved until you leave options)

--- Enter selection ---
```

`_expand`补全器用于控制通配符扩展、变量/命令替换和普通补全的触发条件（*.txt展开为所有匹配到的.txt文件名。将`$HOME`展开为`/home/user`。插入所有可能的补全项目）

这里将通配符展开设置为前缀`NUMERIC==1`，当按了1<tab>快捷键后，展开通配符

将变量展开设置为前缀`NUMERIC==2`，当按了2<tab>快捷键后，展开通配符

普通补全设置为`1`，始终打开

设置完毕，按`0`保存退出到`compinstall`主菜单

```
              *** compinstall: completer menu ***

Current context: :completion:*

The following completers are available.  Those marked `(*)' are already
set for the context shown above.  If none are selected, the completers will
not be set for this context at all.

1. (*) Basic completion.
2. (*) Approximate completion:  completion with correction of existing word.
3. (*) Correction:  correct existing word, no completion.
4. (*) Expansion: use globbing and parameter substitution, if possible.

o.     Set options for the completers above.
m.     Set completers that modify the behaviour of the four main ones above.
q.     Return without saving.
0.     Done setting completers.
```

选`m`配置修饰性补全器，在上面的四个补全器的基础上配置附加功能

```
              *** compinstall: minor completer menu ***

Current context: :completion:*

The following completers are available.  Those marked `(*)' are already
set for the context shown above.  Note none of these are required for
normal completion behaviour.

1. (*) _ignored: Use patterns that were previously ignored if no matches so far.
2.     _list:    Only list matches until the second time you hit TAB.
3.     _oldlist: Keep matches generated by special completion functions.
4.     _match:   If completion fails, retry with pattern matching.
5.     _prefix:  If completion fails, retry ignoring the part after the cursor.

o.     Set options for the completers above.
q.     Return without saving.
0.     Done setting minor completers.
```

`o`：为上面所选的补全器进行配置

```
              *** compinstall: minor completer options ***

Current context: :completion:*

l.     Set options for _list: condition for delay and comparison.
o.     Set options for _oldlist: when to keep old list.
m.     Set options for _match: whether to assume a `*' at the cursor.
p.     Set options for _prefix: whether to add a space before the suffix.

q.     Return to the previous menu without saving.
0.     Done setting completer options.

--- Hit selection ---
```

```
              *** compinstall: minor completer options ***

Current context: :completion:*

l.     Set options for _list: condition for delay and comparison.
o.     Set options for _oldlist: when to keep old list.
m.     Set options for _match: whether to assume a `*' at the cursor.
p.     Set options for _prefix: whether to add a space before the suffix.

q.     Return to the previous menu without saving.
0.     Done setting completer options.

--- Hit selection --- l
You can set a condition under which the _list completer will delay completion
until the second keypress.  It should evaluate to a number; a non-zero value
turns this behaviour on.  It can include parameters, in particular NUMERIC
to refer to a numeric argument.  For example, `NUMERIC != 1' forces the
delay unless you give an argument 1 to the command.  Leave it blank to
assume the condition is true.
condition>
```
留空，首次按`<tab>`仅显示匹配到的数量，第二次才显示补全列表

```
_list will usually compare the contents of the entire line with its previous
contents to decided if it has been changed since the last keypress.  You
can instead perform this comparison on just the current word, ignoring
the rest of the command line.  Do you want to do this? (y/n) [n]
```

`n`表示在命令行中任意位置进行了修改，zsh都会认为输入发生改变并对补全的内容进行调整

`y`表示只检测光标下的单词是否改变，可能在对前面的命令进行修改，而光标处单词没改变时，zsh会误认为没做修改，从而无法刷新补全列表

这里选`n`

```
              *** compinstall: minor completer options ***

Current context: :completion:*

l.     Set options for _list: condition for delay and comparison.
o.     Set options for _oldlist: when to keep old list.
m.     Set options for _match: whether to assume a `*' at the cursor.
p.     Set options for _prefix: whether to add a space before the suffix.

q.     Return to the previous menu without saving.
0.     Done setting completer options.

--- Hit selection --- o
_oldlist can keep a generated completion list for reshowing in the usual
way, e.g. with ^D, even if the list was generated by some special completion
command.  The default behaviour of _oldlist is to show this list if it was
not already visible, otherwise to generate the standard completion listing,
but you can force it always to be shown, or make it never shown.
Alternatively, you can specify a list of completers for which _oldlist will
be used.  Choose:

d.    Default behaviour.
a.    Always show old list.
n.    Never show old list.
s.    Specify a list of completers.
```

选择`d`默认行为

```
_oldlist can keep the old completion list for use in menu completion, e.g. by
repeatedly hitting tab, even if the list was generated by some special
completion command.  This is the default behaviour of _oldlist, but
you can turn it off, so that hitting tab would use the standard completion
list.

Do you want to turn it off? (y/n) [n]
```

默认提供了在补全菜单中保留旧列表的功能，询问是否关闭这个功能（选`n`保持开启）

```
              *** compinstall: minor completer options ***

Current context: :completion:*

l.     Set options for _list: condition for delay and comparison.
o.     Set options for _oldlist: when to keep old list.
m.     Set options for _match: whether to assume a `*' at the cursor.
p.     Set options for _prefix: whether to add a space before the suffix.

q.     Return to the previous menu without saving.
0.     Done setting completer options.

--- Hit selection --- m
The _match completer will usually assume there is a `*' at the cursor
position when trying pattern matches.  For example, `f*n<TAB>e' would
be able to complete to `filename', not just to patterns matching `f*ne'.
(Note that this assumes you have the option COMPLETE_IN_WORD set, else all
completion takes place at the end of the word.)  You can tell _match not
to assume there is a `*', or to try first without the `*', then with it.
Type one of:

a.     Always assume `*' at cursor position.
n.     Never assume `*' at cursor position.
w.     Try without the `*', then with it if that fails.
```

`_match`补全器在进行模式匹配时，通常会假设光标位置有一个`*`通配符
- `a`：始终在光标位置假设存在`*`
- `n`：从不在光标位置假设存在`*`
- `w`：现场是无`*`匹配，失败后再添加`*`

这里选`w`

```
              *** compinstall: minor completer options ***

Current context: :completion:*

l.     Set options for _list: condition for delay and comparison.
o.     Set options for _oldlist: when to keep old list.
m.     Set options for _match: whether to assume a `*' at the cursor.
p.     Set options for _prefix: whether to add a space before the suffix.

q.     Return to the previous menu without saving.
0.     Done setting completer options.

--- Hit selection --- p
The _prefix completer completes only what is behind the cursor, ignoring
completely what is after, even if there is no space at the cursor position.
However, you can force it to add a space between the resulting completion
and the part ignored.  For example, `f<TAB>bar' might expand to `filebar'
without this, and to `file bar' with it.  Do wish _prefix to add the
space? (y/n) [n]
```

`_prefix`补全器默认选仅补全光标前面的字符，如果选了`n`，则补全后直接拼接光标后面的文本。如果选了`y`，则补全的结果与后续文本之间强制插入空格。这里选`n`

设置完毕，按`0`退出，`completer`配置完毕

```
               *** compinstall: main menu ***
Note that hitting `q' in menus does not abort the set of changes from
lower level menus.  However, quitting at top level will ensure that nothing
at all is actually written out.

1.  Completers:  choose completion behaviour for tasks such as
    approximation, spell-checking, expansion.

2.  Matching control: set behaviour for case-insensitive matching,
    extended (partial-word) matching and substring matching.

3.  Styles for changing the way completions are displayed and inserted.

4.  Styles for particular completions.

c.  Change context (plus more information on contexts).

q.  Return without saving.
0.  Save and exit.
```

`2`：配置配置大小写敏感匹配、扩展匹配、子串匹配

```
              *** compinstall: matcher menu ***

`Matchers' compare the completion code with the possible matches in some
special way.  Numbers in parentheses show matchers to be tried and the order.
The same number can be assigned to different matchers, meaning apply at the
same time.  Omit a sequence number to try normal matching at that point.
A `+' in the first line indicates the element is added to preceding matchers
instead of replacing them; toggle this with `t'.  You don't need to set
all four, or indeed any matchers --- then the style will not be set.

   (    )   `+' indicates add to previous matchers, else replace
n. (    ) No matchers; you may want to try this as the first choice.
c. (    ) Case-insensitive completion (lowercase matches uppercase)
C. (    ) Case-insensitive completion (lower/uppercase match each other)
p. (    ) Partial-word completion:  expand 'f.b' to 'foo.bar', etc., in one go.
          You can choose the separators (here `.') used each time.
s. (    ) Substring completion:  complete on substrings, not just initial
          strings.  Warning: it is recommended this not be used for element 1.

t.        Toggle replacing previous matchers (` ' at top) or add (`+')
q.        Return without saving.
0.        Done setting matchers.
```

n. 不匹配
c. 小写匹配大写
C. 大小写双向匹配
s. 子串匹配，支持任意位置匹配

```
              *** compinstall: matcher menu ***

`Matchers' compare the completion code with the possible matches in some
special way.  Numbers in parentheses show matchers to be tried and the order.
The same number can be assigned to different matchers, meaning apply at the
same time.  Omit a sequence number to try normal matching at that point.
A `+' in the first line indicates the element is added to preceding matchers
instead of replacing them; toggle this with `t'.  You don't need to set
all four, or indeed any matchers --- then the style will not be set.

   (++++)   `+' indicates add to previous matchers, else replace
n. (    ) No matchers; you may want to try this as the first choice.
c. (    ) Case-insensitive completion (lowercase matches uppercase)
C. (1   ) Case-insensitive completion (lower/uppercase match each other)
p. ( 2  ) Partial-word completion:  expand 'f.b' to 'foo.bar', etc., in one go.
          You can choose the separators (here `.') used each time.
s. (  3 ) Substring completion:  complete on substrings, not just initial
          strings.  Warning: it is recommended this not be used for element 1.

t.        Toggle replacing previous matchers (` ' at top) or add (`+')
q.        Return without saving.
0.        Done setting matchers.

--- Hit selection --- p
Set/unset for element number (1234)? 2
Edit the set of characters which terminate partial words.  Typically
these are punctuation characters, such as `.', `_' and `-'.
The expression will automatically be quoted.

characters> ._-

You can allow the partial-word terminators to be matched in the pattern,
too:  then  for example `c.u' would expand to `comp.source.unix', whereas
usually you would need to type an extra intervening dot.  Do you wish the
terminators to be matched in this way? (y/n) [n]
```

输入`._-`等分隔符，系统通过这些符号拆分单词进行补全

是否宽松匹配终止符。`n`：`c.u`只能匹配`comp.unix`而不能匹配`comp.source.unix`。`y`：`c.u`可以匹配`comp.source.unix`

按`t`让每个匹配阶段继承上一个匹配阶段的规则

`0`保存退出

```
               *** compinstall: main menu ***
Note that hitting `q' in menus does not abort the set of changes from
lower level menus.  However, quitting at top level will ensure that nothing
at all is actually written out.

1.  Completers:  choose completion behaviour for tasks such as
    approximation, spell-checking, expansion.

2.  Matching control: set behaviour for case-insensitive matching,
    extended (partial-word) matching and substring matching.

3.  Styles for changing the way completions are displayed and inserted.

4.  Styles for particular completions.

c.  Change context (plus more information on contexts).

q.  Return without saving.
0.  Save and exit.
```

`3`：配置补全显示与插入行为的视觉呈现样式

```
         *** compinstall: display and insertion options ***

1.  Change appearance of completion lists:  allows descriptions of
    completions to appear and sorting of different types of completions.

2.  Change how completions are inserted: includes options for sorting,
    and keeping the original or an unambiguous prefix with correction etc.

3.  Configure coloured/highlighted completion lists, selection of items
    and scrolling.

4.  Change whether old-style `compctl' completions will be used.

q.  Return without saving.
0.  Done setting display and insertion options.
```

选`1`更改补全列表的外观

```
       *** compinstall: order and descriptions in completion lists ***
Type the appropriate number for more information on how this would affect
listings.

1.  Print a message above completion lists describing what is being
    completed.

2.  Make different types of completion appear in separate lists.

3.  Make completion verbose, using option descriptions etc. (on by default).

4.  Make single-valued options display the value's description as
    part of the option's description.

q.  Return without saving.
0.  Done setting options for formatting of completion lists.
```

选`1`配置打印补全内容的说明

```
You can set a string which is displayed on a line above the list of matches
for completions.  A `%d' in this string will be replaced by a brief
description of the type of completion.  For example, if you set the
string to `Completing %d', and type ^D to show a list of files, the line
`Completing files' will appear above that list.  Enter an empty line to
turn this feature off.  If you enter something which doesn't include `%d',
then `%d' will be appended.  Quotation will be added automatically.

description> Completing %d
```

自定义补全列表顶部的描述提示行

```
       *** compinstall: order and descriptions in completion lists ***
Type the appropriate number for more information on how this would affect
listings.

1.  Print a message above completion lists describing what is being
    completed.

2.  Make different types of completion appear in separate lists.

3.  Make completion verbose, using option descriptions etc. (on by default).

4.  Make single-valued options display the value's description as
    part of the option's description.

q.  Return without saving.
0.  Done setting options for formatting of completion lists.
```

选`2`，配置将不同类型的补全项归类为独立区块展示

```
Normally, all possible completions are listed together in a single list, and
if you have set a description with 1) above, the descriptions are listed
together above that.  However, you can specify that different types of
completion appear in separate lists; any description appears above its
own list.  For example, external commands and shell functions would appear
in separate lists when you are completing a command name.  Do you
want to turn this on?

[y]es, [n]o, [k]eep old setting?
```

选`y`启用补全项归类显示功能


```
       *** compinstall: order and descriptions in completion lists ***
Type the appropriate number for more information on how this would affect
listings.

1.  Print a message above completion lists describing what is being
    completed.

2.  Make different types of completion appear in separate lists.

3.  Make completion verbose, using option descriptions etc. (on by default).

4.  Make single-valued options display the value's description as
    part of the option's description.

q.  Return without saving.
0.  Done setting options for formatting of completion lists.
```

选`3`，配置`verbose`模式，为补全项附加功能描述

```
By default, completion uses a `verbose' setting.  This
affects different completions in different ways.  For example,  many
well-known commands have short, uninformative option names; in some cases,
completion will indicate what the options do when offering to complete them.
If you prefer shorter listings you can turn this off.  What setting to
you want?

[v]erbose, [n]ot verbose, [k]eep old setting?
```

选`v`启用补全项目的功能描述

```
       *** compinstall: order and descriptions in completion lists ***
Type the appropriate number for more information on how this would affect
listings.

1.  Print a message above completion lists describing what is being
    completed.

2.  Make different types of completion appear in separate lists.

3.  Make completion verbose, using option descriptions etc. (on by default).

4.  Make single-valued options display the value's description as
    part of the option's description.

q.  Return without saving.
0.  Done setting options for formatting of completion lists.
```

选`4`，配置为单值参数选项添加参数描述，明确所需类型或用途

```
Many commands have options which take a single argument.  In some cases,
completion is not set up to describe the option even though it has a
description for the argument.  You can enter a string containing `%d',
which will be replaced by the description for the option.  For
example, if you enter the string `specify: %d', and an option -ifile
exists which has an argument whose description is `input file', then the
description `specify: input file' will appear when the option itself
is listed.  As this long explanation suggests, this is only occasionally
useful.  Enter an empty line to turn this feature off.  If you enter
something which doesn't include `%d', then `%d' will be appended.
Quotation will be added automatically.

auto-description>:%d
```

用冒号作为选项与说明之间的分隔符

按`0`保存退出

```
         *** compinstall: display and insertion options ***

1.  Change appearance of completion lists:  allows descriptions of
    completions to appear and sorting of different types of completions.

2.  Change how completions are inserted: includes options for sorting,
    and keeping the original or an unambiguous prefix with correction etc.

3.  Configure coloured/highlighted completion lists, selection of items
    and scrolling.

4.  Change whether old-style `compctl' completions will be used.

q.  Return without saving.
0.  Done setting display and insertion options.
```

选2配置补全项被插入命令行时的行为逻辑

```
          *** compinstall: options for inserting completions ***

1.   In completers that change what you have already typed, insert any
     unambiguous prefix rather than go straight to menu completion.

2.   In completers which correct what you have typed, keep what you
     originally typed as one of the list of possible completions.

q.   Return without saving.
0.   Done setting options for insertion.
```

```
          *** compinstall: options for inserting completions ***

1.   In completers that change what you have already typed, insert any
     unambiguous prefix rather than go straight to menu completion.

2.   In completers which correct what you have typed, keep what you
     originally typed as one of the list of possible completions.

q.   Return without saving.
0.   Done setting options for insertion.

-- Hit selection --- 1
The completers which do pattern matching and correction often alter the
string which is already on the line, in the first case because it was a
pattern and in the second case because what you typed was wrong.
Since the possible completions can bear little or no resemblance to one
another in those cases, so that typing extra characters to resolve the
completion doesn't make much sense, menu completion is usually turned on
straight away to allow you to pick the completion you want.  This style
tells completion that if there is a common, unambiguous prefix in this
case, you would prefer that to be inserted rather than going straight
to menu completion.  Do you want this?

[y]es, [n]o, [k]eep old setting?
```

唯一匹配时跳过菜单，直接补全到无歧义的部分，选`y`

```
          *** compinstall: options for inserting completions ***

1.   In completers that change what you have already typed, insert any
     unambiguous prefix rather than go straight to menu completion.

2.   In completers which correct what you have typed, keep what you
     originally typed as one of the list of possible completions.

q.   Return without saving.
0.   Done setting options for insertion.

-- Hit selection --- 2
For completers which correct what you have typed, you sometimes want
to keep the original string instead, so if the correction was ambiguous
the original string is always listed as a possible completion.  However,
if there was just one completion it is usually accepted.  You can
force completion to offer the original string as a possibility even in
this case.  Do you want this?

[y]es, [n]o, [k]eep old setting?
```

拼写修正后选列表始终包含原始的错误输入（防止误修正，可选择原始输入而不需要重新输入），选`y`

按`0`保存退出

```
         *** compinstall: display and insertion options ***

1.  Change appearance of completion lists:  allows descriptions of
    completions to appear and sorting of different types of completions.

2.  Change how completions are inserted: includes options for sorting,
    and keeping the original or an unambiguous prefix with correction etc.

3.  Configure coloured/highlighted completion lists, selection of items
    and scrolling.

4.  Change whether old-style `compctl' completions will be used.

q.  Return without saving.
0.  Done setting display and insertion options.
```

选`3`配置补全列表的视觉样式与交互逻辑（颜色、高亮、滚动等）

```
     *** compinstall: options for colouring and selecting in lists ***

1.   Use coloured lists for listing completions.

2.   Use cursor keys to select completions from completion lists.

3.   Allow scrolling of long selection lists and set the prompt.

q.   Return without saving.
0.   Done setting options for insertion.
```

```
     *** compinstall: options for colouring and selecting in lists ***

1.   Use coloured lists for listing completions.

2.   Use cursor keys to select completions from completion lists.

3.   Allow scrolling of long selection lists and set the prompt.

q.   Return without saving.
0.   Done setting options for insertion.

--- Hit selection --- 1
Zsh can produce coloured completion listings where different file types
etc. appear in different colours.  If you want to tailor that to your
own needs, you will have to edit ~/.zshrc.  Here you have the choice of:

1.  Using the default colours.
2.  Using the colours already set up for GNU ls via the $LS_COLORS
    environment variable.  Note this must be set before the completion
    configuration code is executed.
3.  Turn colouring off.
0.  Leave the setting the way it is.  Choose this if you have a custom
    setting and you don't want to lose it.
```

选`2`，复用`ls`命令的颜色配置，从`$LS_COLOR`变量中继承颜色配置

`0`保存退出

```
     *** compinstall: options for colouring and selecting in lists ***

1.   Use coloured lists for listing completions.

2.   Use cursor keys to select completions from completion lists.

3.   Allow scrolling of long selection lists and set the prompt.

q.   Return without saving.
0.   Done setting options for insertion.
```

选`2`配置使用方向键进行补全项的选择

```
     *** compinstall: options for colouring and selecting in lists ***

1.   Use coloured lists for listing completions.

2.   Use cursor keys to select completions from completion lists.

3.   Allow scrolling of long selection lists and set the prompt.

q.   Return without saving.
0.   Done setting options for insertion.

--- Hit selection --- 2
If you use zsh's menu completion and the feature that all short completion
lists appear below the line on which you are editing, you can enable
`menu selection', which lets you pick a completion with the cursor keys:
the choice is highlighted, and hitting return accepts it.  Note that
this only happens when you are already using menu completion.  This
feature can be set so that it is only enabled when there are a certain
number of completions.  Please enter:

- 0 or 1, to turn this feature on unconditionally
- a higher number to turn this feature on when there are that many
  completions
- an `l' for `long' to turn it on for listings which don't fit on the
  screen.
- an `ll' for `long list' to turn it on for completions which don't fit
  on the screen, even for commands which only do listing of completions.
  This may be combined with a number which will be used in ordinary selection.
- a negative number to turn this feature off
- an empty line to leave the setting the way it is.

value>
```

`0`或`1`表示无条件启用，只要弹出补全菜单，必须使用方向键选择目标并确认，永不插入首个后选项

`>1`的数字：当匹配项$\leq$输入值时，强制要求手动选择，如果匹配项$<$输入值时，直接插入首个候选

这里输入`2`，当候选项大于2时，才弹出补全菜单进行选择。

```
You can also set a prompt to use for menu selection when it would scroll
off the screen.  Unless this is set, you won't see a prompt, but the feature
is still enabled.

Edit a prompt below.  It can contain `%l' to show the number of matches
as `current_number/total_number', `%p' to show the fraction of
the way down the list, or font-control sequences such as %B, %U, %S and
the corresponding %b, %u, %s; quotes will be added automatically.  Delete
the whole line to turn it off.  Hit return to keep the current value.

prompt> %SScrolling (%p) | %l | Press ↑↓ to select%s
```

配置滚动提示符，动态提示所处补全菜单的位置信息

```
     *** compinstall: options for colouring and selecting in lists ***

1.   Use coloured lists for listing completions.

2.   Use cursor keys to select completions from completion lists.

3.   Allow scrolling of long selection lists and set the prompt.

q.   Return without saving.
0.   Done setting options for insertion.

--- Hit selection --- 3
You can make completion lists scroll when they don't fit on the screen.
Note this is different from scrolling in menu selection --- a more basic
pager is used which should work even with fairly stupid terminals.

To enable this, edit a prompt to show when scrolling is active; an empty
string turns this feature off.  It can contain `%l' to show the number of
matches as `current_number/total_number', `%p' to show the fraction of
the way down the list, or font-control sequences such as %B, %U, %S and the
corresponding %b, %u, %s; quotes will be added automatically.  Delete the
whole line to turn this behaviour off, in which case the display of
completions which don't fit on the screen is controlled by the LISTMAX
parameter (currently 100), which specifies the maximum number
to show without asking.  Hit return to keep the current value.

prompt> %SAt %p: Hit TAB for more, or the character to insert%s
```

`3`配置长补全列表的滚动行为与位置提示

改成`%SScroll: %p (%l) | ↑↓ to move, TAB to accept%s`

```
         *** compinstall: display and insertion options ***

1.  Change appearance of completion lists:  allows descriptions of
    completions to appear and sorting of different types of completions.

2.  Change how completions are inserted: includes options for sorting,
    and keeping the original or an unambiguous prefix with correction etc.

3.  Configure coloured/highlighted completion lists, selection of items
    and scrolling.

4.  Change whether old-style `compctl' completions will be used.

q.  Return without saving.
0.  Done setting display and insertion options.
```

`4`配置是否启用旧式的`compctl`规则。选择不启用，保持现代默认的补全系统

`0`保存退出

```
               *** compinstall: main menu ***
Note that hitting `q' in menus does not abort the set of changes from
lower level menus.  However, quitting at top level will ensure that nothing
at all is actually written out.

1.  Completers:  choose completion behaviour for tasks such as
    approximation, spell-checking, expansion.

2.  Matching control: set behaviour for case-insensitive matching,
    extended (partial-word) matching and substring matching.

3.  Styles for changing the way completions are displayed and inserted.

4.  Styles for particular completions.

c.  Change context (plus more information on contexts).

q.  Return without saving.
0.  Save and exit.
```

`4`特定的补全风格

```
      *** compinstall: options for particular types of completion ***

1.  Options for file completion.

q.  Return without saving.
0.  Done setting options for particular completions.
```

配置文件补全选项

```
      *** compinstall: options for filename completion ***

1.  Choose how to sort the displayed list of filename matches.

2.  In expressions with .., don't include directories already implied.

3.  Allow completion of . and .. for the bone idle.

4.  When expanding paths, `foo//bar' is treated as `foo/bar'.

5.  Configure how multiple paths are expanded and displayed,
    e.g. /f/b -> /foo/bar

6.  Keep certain prefixes unchanged, such as `//resource/'.

q.  Return without saving.
0.  Done setting options for filename completion.
```

```
      *** compinstall: options for filename completion ***

1.  Choose how to sort the displayed list of filename matches.

2.  In expressions with .., don't include directories already implied.

3.  Allow completion of . and .. for the bone idle.

4.  When expanding paths, `foo//bar' is treated as `foo/bar'.

5.  Configure how multiple paths are expanded and displayed,
    e.g. /f/b -> /foo/bar

6.  Keep certain prefixes unchanged, such as `//resource/'.

q.  Return without saving.
0.  Done setting options for filename completion.

--- Hit selection --- 1
Filenames listed as possible completions are usually displayed in
alphabetical order.  You can alternatively choose:
  s  File size
  l  Number of (hard) links
  m  Modification time
  a  Access time
  i  Inode change time
  n  File name
  k  Keep the current setting
You can also specify the reverse of any of the above orders (except `k'):  to
do this, type the appropriate letter in upper case.

--- Hit selection ---n
```

按照文件名进行排序

```
      *** compinstall: options for filename completion ***

1.  Choose how to sort the displayed list of filename matches.

2.  In expressions with .., don't include directories already implied.

3.  Allow completion of . and .. for the bone idle.

4.  When expanding paths, `foo//bar' is treated as `foo/bar'.

5.  Configure how multiple paths are expanded and displayed,
    e.g. /f/b -> /foo/bar

6.  Keep certain prefixes unchanged, such as `//resource/'.

q.  Return without saving.
0.  Done setting options for filename completion.

--- Hit selection --- 2
When you type an expression containing `..', you may usually not want to
be offered certain directories for completion.
  p   Don't offer parents:  in `foo/bar/../', don't make `bar' a completion.
  c   Don't offer the current directory, e.g. after `../'.
  o   Only perform the two tests if there is a real `..' in the word so far.
  d   Only perform the two tests when completing directory names.
  0   None of the above; use normal completion.
  k   Keep the current settings.
You may specify any combination of p, c, o, d including at least one of p
and c, or you may specify either 0 or k.  Note that the _ignored completer
functions in the normal way, i.e. you would be able to complete the
directories in question if nothing else matched.

selection>pod
```

避免冗余补全，过滤被`..`抵消的路径，确保补全结果严格符合路径简化后的实际位置（p的功能包括了c的功能）

```
      *** compinstall: options for filename completion ***

1.  Choose how to sort the displayed list of filename matches.

2.  In expressions with .., don't include directories already implied.

3.  Allow completion of . and .. for the bone idle.

4.  When expanding paths, `foo//bar' is treated as `foo/bar'.

5.  Configure how multiple paths are expanded and displayed,
    e.g. /f/b -> /foo/bar

6.  Keep certain prefixes unchanged, such as `//resource/'.

q.  Return without saving.
0.  Done setting options for filename completion.
```

选`3`配置是否将当前目录和父目录添加到补全菜单中

```
Filename completion does not usually offer the directory names `.' and
`..' as choices.  However, some immensely lazy people can't even be
bothered to type these.  Do you wish to be offered `.' and `..' as
choices ([y]es, [n]o, [k]eep current setting)?
```

这里选了`n`

```
      *** compinstall: options for filename completion ***

1.  Choose how to sort the displayed list of filename matches.

2.  In expressions with .., don't include directories already implied.

3.  Allow completion of . and .. for the bone idle.

4.  When expanding paths, `foo//bar' is treated as `foo/bar'.

5.  Configure how multiple paths are expanded and displayed,
    e.g. /f/b -> /foo/bar

6.  Keep certain prefixes unchanged, such as `//resource/'.

q.  Return without saving.
0.  Done setting options for filename completion.

--- Hit selection --- 4
Filename completion can complete sets of path segments at once, for example
`/u/X/l/X' to `/usr/X11R6/lib/X11'.  Normally this means that multiple
slashes in filenames are treated as matching multiple directories.  For
example, `foo//bar' could expand to `foo/datthe/bar'.  You can, however,
stick to the usual UNIX convention that multiple slashes are treated as
a single slash.  Do you wish to treat multiple slashes the same as just
one ([y]es, [n]o, [k]eep current setting)?
````
`4`，配置是否将连续的`/`斜杠视为一条斜杠`/`，比如`foo//bar`能被补全为`foo/bar`还是`foo/datthe/bar`。选`y`

```
      *** compinstall: options for filename completion ***

1.  Choose how to sort the displayed list of filename matches.

2.  In expressions with .., don't include directories already implied.

3.  Allow completion of . and .. for the bone idle.

4.  When expanding paths, `foo//bar' is treated as `foo/bar'.

5.  Configure how multiple paths are expanded and displayed,
    e.g. /f/b -> /foo/bar

6.  Keep certain prefixes unchanged, such as `//resource/'.

q.  Return without saving.
0.  Done setting options for filename completion.

--- Hit selection --- 5

When expanding /f/b, the shell will attempt to match /f*/b* (e.g. /foo/bar),
and so on to any depth.  If the first part of the expansion fails, by default
the shell will not expand the remainder.  However, you can force it always
to expand the first part.  Currently this feature is off.
Do you want it on ([y]es, [n]o, [k]eep current setting)?
```

配置在路径补全时，是否在首段失败后强行匹配剩余部分。这里选`n`

```
Further, if /f*/b* is ambiguous, the shell will usually only expand
as far as the part that is unambiguous; for example, if /foo/bar and
/food/basket exist, it will wait for you to choose either /foo or /food,
and not attempt to expand the rest of the match.  However, you can force
it to add all possible completions for you to resolve conflicts in the
normal way.  Currently this feature is off.
Do you want it on ([y]es, [n]o, [k]eep current setting)?
```

这个配置控制了路径歧义时，是否强制展开所有完整匹配项，还是只显示没有歧义的部分。

选`n`，不展开完整路径而是补全到没有歧义的部分，再进行选择

```
When listing expansions of /f/b such as /foo/bar, /foo/bad, /failed/bag,
the shell will usually only show the first part of the path if it is
ambiguous, hence /foo will appear twice.  It is possible to show the
full path in this case.  Currently this feature is on.
Do you want this behaviour ([y]es, [n]o, [k]eep current setting)?

--- Hit selection ---
```

这一步选`y`

```
        *** compinstall: options for filename completion ***

1.  Choose how to sort the displayed list of filename matches.

2.  In expressions with .., don't include directories already implied.

3.  Allow completion of . and .. for the bone idle.

4.  When expanding paths, `foo//bar' is treated as `foo/bar'.

5.  Configure how multiple paths are expanded and displayed,
    e.g. /f/b -> /foo/bar

6.  Keep certain prefixes unchanged, such as `//resource/'.

q.  Return without saving.
0.  Done setting options for filename completion.

--- Hit selection --- 6
On some systems, there are special forms for the start of a filename
which should be left alone by the completion system.  For example, Cygwin
uses a double slash to indicate a network resource, hence a prefix of
the form `//resource/' should be left alone.  This style gives a pattern
to match any such prefixes; alternatives separated by `|' are therefore
possible.  Edit the pattern as you like.  If this is empty, the shell will not
handle any prefixes specially.
pattern> //[^/]##/
```

`6`配置定义需保持原样的特殊路径前缀以双斜杠开头，后跟非斜杠字符，并以斜杠结尾的路径前缀在Tab补全时不被自动展开或转换。保持默认。

```
                      *** compinstall: main menu ***
Note that hitting `q' in menus does not abort the set of changes from
lower level menus.  However, quitting at top level will ensure that nothing
at all is actually written out.

1.  Completers:  choose completion behaviour for tasks such as
    approximation, spell-checking, expansion.

2.  Matching control: set behaviour for case-insensitive matching,
    extended (partial-word) matching and substring matching.

3.  Styles for changing the way completions are displayed and inserted.

4.  Styles for particular completions.

c.  Change context (plus more information on contexts).

q.  Return without saving.
0.  Save and exit.
```

`c`为特定的命令单独制定补全规则。

```
             *** compinstall: change context ***

The context tells the completion system under what circumstances your
value will be used.  It has this form:
  :completion:<function-name>:<completer>:<command>:<argument>:<tag>
See the documentation for more detail on each of these components.  The
default context `:completion:*' matches everywhere in completion, unless you
define a more specific pattern which matches the completion context being
used. `More specific' means either a string instead of a pattern, or a
longer pattern instead of a shorter pattern.

Edit a new context, or leave the line blank to reset the context to the
default value.  Note that you do not require quotes around the context,
which will automatically be added later.  Line editing and history are
available.

context> :completion:*
```

保持默认，匹配所有命令的补全场景，覆盖所有子命令、参数和补全类型

`0`保存退出

```
               *** compinstall: main menu ***
Note that hitting `q' in menus does not abort the set of changes from
lower level menus.  However, quitting at top level will ensure that nothing
at all is actually written out.

1.  Completers:  choose completion behaviour for tasks such as
    approximation, spell-checking, expansion.

2.  Matching control: set behaviour for case-insensitive matching,
    extended (partial-word) matching and substring matching.

3.  Styles for changing the way completions are displayed and inserted.

4.  Styles for particular completions.

c.  Change context (plus more information on contexts).

q.  Return without saving.
0.  Save and exit.

--- Hit choice --- 0
Save new settings to /home/jccc/.zshrc ([y]es, [n]o)? y
Copied old file to /home/jccc/.zshrc~.
Successfully added compinstall lines to /home/jccc/.zshrc.
Set new styles for immediate use ([y]es, [n]o)?y
```

```
Please pick one of the following options:

(1)  Configure settings for history, i.e. command lines remembered
     and saved by the shell.  (Unsaved changes.)

(2)  Use the new completion system.  (Configured.)

(3)  Configure how keys behave when editing command lines.  (Recommended.)

(4)  Pick some of the more common shell options.  These are simple "on"
     or "off" switches controlling the shell's features.

(0)  Exit, leaving the existing ~/.zshrc alone.

(a)  Abort all settings and start from scratch.  Note this will overwrite
     any settings from zsh-newuser-install already in the startup file.
     It will not alter any of your other settings, however.

(q)  Quit and do nothing else.  The function will be run again next time.
--- Type one of the keys in parentheses ---
```

输入`3`配置键位

```
Default editing configuration
=============================

The keys in the shell's line editor can be made to behave either
like Emacs or like Vi, two common Unix editors.  If you have no
experience of either, Emacs is recommended.  If you don't pick one,
the shell will try to guess based on the EDITOR environment variable.
Usually it's better to pick one explicitly.

# (1) Change default editing configuration
bindkey -e                                                                    (not yet saved)

# (0)  Remember edits and return to main menu (does not save file yet)
# (q)  Abandon edits and return to main menu

--- Type one of the keys in parentheses --- 1
Pick a keymap (set of keys) to use when editing.
Type:
  (e) for Emacs keymap (recommended unless you are vi user)
  (v) for Vi keymap
  (n) not to set a keymap (allow shell to choose)
  (k) to keep the current setting, (e):
--- Type one of the keys in parentheses ---v
```

`1`修改默认编辑配置，`v`改为`vi`键位

`0`保存退出

```
Please pick one of the following options:

(1)  Configure settings for history, i.e. command lines remembered
     and saved by the shell.  (Unsaved changes.)

(2)  Use the new completion system.  (Configured.)

(3)  Configure how keys behave when editing command lines.  (Recommended.)

(4)  Pick some of the more common shell options.  These are simple "on"
     or "off" switches controlling the shell's features.

(0)  Exit, leaving the existing ~/.zshrc alone.

(a)  Abort all settings and start from scratch.  Note this will overwrite
     any settings from zsh-newuser-install already in the startup file.
     It will not alter any of your other settings, however.

(q)  Quit and do nothing else.  The function will be run again next time.
--- Type one of the keys in parentheses ---
```

`4`配置一些通用的shell选项

```
Common shell options
====================

The following are some of the shell options that are most often used.
The descriptions are very brief; if you would like more information,
read the zshoptions manual page (type "man zshoptions").

# (1) Change directory given just path.
setopt autocd                                                             (set but not saved)
# (2) Use additional pattern matching features.
setopt extendedglob                                                       (set but not saved)
# (3) Unmatched patterns cause an error.
setopt nomatch                                                                  (no value set)
# (4) Beep on errors.
setopt beep                                                                     (no value set)
# (5) Immediately report changes in background job status.
unsetopt notify                                                                 (no value set)

# (0)  Remember edits and return to main menu (does not save file yet)
# (q)  Abandon edits and return to main menu

--- Type one of the keys in parentheses ---
```

1. 命令行中输入目录路径，无需显示输入`cd`命令即可自动执行`cd`进入到该目录
2. 开启扩展通配符支持
3. 如果通配符无匹配文件，则触发错误
4. 发生错误时触发终端蜂鸣声
5. 实时显示后台任务的运行状态

开启1、2、3、4，关闭5

`0`保存退出

```
Please pick one of the following options:

(1)  Configure settings for history, i.e. command lines remembered
     and saved by the shell.  (Unsaved changes.)

(2)  Use the new completion system.  (Configured.)

(3)  Configure how keys behave when editing command lines.  (Unsaved changes.)

(4)  Pick some of the more common shell options.  These are simple "on"
     or "off" switches controlling the shell's features.    (Unsaved changes.)

(0)  Exit, saving the new settings.  They will take effect immediately.

(a)  Abort all settings and start from scratch.  Note this will overwrite
     any settings from zsh-newuser-install already in the startup file.
     It will not alter any of your other settings, however.

(q)  Quit and do nothing else.  The function will be run again next time.
--- Type one of the keys in parentheses ---
```

配置完毕，`0`保存退出

## 插件

提供语法高亮显示

git submodule add https://github.com/zsh-users/zsh-syntax-highlighting zsh/plugins/zsh-syntax-highlighting

