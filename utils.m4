divert(-1)
define(`post_list',
    `include(`$2') $1 ifelse($#, 1, , $#, 2, ,
        `define(`shifted', `shift(shift($@))') post_list($1, shifted)')')
divert dnl
