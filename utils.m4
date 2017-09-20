divert(-1)
define(`post_list',
   `include(`$2')
    $1
    undefine(`URL') undefine(`TITLE') undefine(`PUBLISHED')
    ifelse($#, 1, , $#, 2, ,
       `define(`shifted', `shift(shift($@))') post_list($1, shifted)')')
divert dnl
