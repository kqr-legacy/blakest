
# Blakest

Blakest is a static blog generator (whose name is the combination of
**bl**og-m**ake**-**st**atic) using only very standard POSIX tools in its core:
make, awk, m4, sed, tr, sort and cat are the big ones.

The idea is that Blakest should also be very easily extendable so if you want to
support some other markup format for your post sources, you just create a make
target for that. Possibly in its own file to make version control easier.


## Short Tutorial

(But also see the included source examples.)

Store blog posts in the `src' subdirectory, named <slug>.<format>.  HTML is the
only format supported out of the box, Slug must be unique.

Also create a <slug>.meta file containing metadata about the blog post, such as
title, publish date and tags. This metadata uses a simple syntax where a line
can contain at most one definition like `<field_name>=\t<value>'. You can store
any metadata you want and use it in your templates.

Create templates in the `template' subdirectory. These templates are written
with m4 syntax, which in short means any time you mention a field name it will
be replaced with the corresponding value from the post .meta file. More advanced
features are available.

Put static content in the `static' subdirectory. This directory will be copied
verbatim to the generated site.

When you are done setting up your blog, run

    $ make

    $ make install

