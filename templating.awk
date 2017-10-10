$1 == "@post" {
    print "pushdef(`_N_',"NR")pushdef(`PUBLISHED',"$2")pushdef(`TITLE',"$3")pushdef(`TAGS',"$4")pushdef(`SLUG',"$5")pushdef(`BODY',"$6")";
    if (template) {
        print template;
    } else {
        system("cat "$7);
    }
    print "popdef(`_N_')popdef(`PUBLISHED')popdef(`TITLE')popdef(`TAGS')popdef(`SLUG')popdef(`BODY')";
    next;
}

$1 == "@tag" {
    print "pushdef(`_N_',"NR")pushdef(`TAG',"$2")pushdef(`TAGANCHOR', `tagged`#'\$1')pushdef(`SEARCHTAG', `search tagged=\$1')";
    print template;
    print "popdef(`_N_')popdef(`TAG')popdef(`TAGANCHOR')popdef(`SEARCHTAG')";
    next;
}

$1 == "@listof" {
    $1 = "";
    source = $0;
        
    template = "";
    while (getline && $1 == "#") {
        $1 = "";
        template = template "\\n" $0;
    }

    system("make "source" | awk -F'\t' -v template='"template"' -f templating.awk | m4 | awk -f templating.awk | cat")
    next;
}
    
{
    print;
}
