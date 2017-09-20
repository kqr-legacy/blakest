
# Blakest

Blakest is a static blog generator (whose name is the combination of
**bl**og-m**ake**-**st**atic) using only very standard POSIX tools
in its core:

* `make` drives the generation,
* `m4` is used for templating,
* `sed` is used for some basic parsing, and
* `mkdir`, `cat`, `cp` etc. are used for file management.

However! Blakest is also extendable so you can easily create support
for your preferred markup language, as long as it can output HTML.
The way to do this is to create a `make` target for it and add it to
`extensions`.


## Todo

* Index generation is not quite working because `m4`...
* Tag support
* Static page support
* Include BML as a generator



## Short Tutorial

(But also see the included source examples.)

Store blog posts in the `src' subdirectory, named <slug>.<format>.
HTML is the only format supported out of the box, but look in
`extensions` to see how to enable BML support. Slug must be unique.

Also create a <slug>.meta file containing metadata about the blog
post, such as title, publish date and tags. This metadata uses a
simple syntax where a line can contain at most one definition like
`<field_name>=<value>'. Any lines not using this syntax are assumed
to use m4 syntax, enabling more advanced features. You can store any
metadata you want and use it in your templates.

Create templates in the `template' subdirectory. These templates are
written with m4 syntax, which in short means any time you mention a
field name it will be replaced with the corresponding value from the
post .meta file. More advanced features are available.

Put static content in the `static' subdirectory. This directory will
be copied verbatim to the generated site.

When you are done setting up your blog, run

    $ make

    $ make install


## Command ideas

* `make list posts` (list of posts with greppable status among other things)
* `make list tags` (list of tags)
* possibly more to add tags etc to posts!!
