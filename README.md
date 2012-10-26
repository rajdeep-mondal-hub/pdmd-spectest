# pdmd-spectest

For each small file in input-md, render it to html using both `pandoc`
and some other markdown processor (specified on the command line), and
compare the html outputs to see if they are the same (ignoring
whitespace). Call it from its project dir, for example:

    ./pdmd-spectest.pl markdown2.py

where markdown2.py must be somewhere on your PATH.

Output looks like this:

~~~
Checking output of: /home/john/bin/markdown2.py
alt-delim-code-block ...	-- not the same --
bold ...	OK
code-block ...	-- not the same --
code ...	OK
definition-list ...	-- not the same --
delim-code-block ...	-- not the same --
italic ...	OK
list-2 ...	OK
list ...	OK
table ...	-- not the same --
~~~

Those output lines are named the same as the files in input-md
(without the filename extension).
