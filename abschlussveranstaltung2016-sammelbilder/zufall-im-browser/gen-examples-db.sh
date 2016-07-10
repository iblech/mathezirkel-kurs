#!/bin/bash

for lang in de en; do
    {
        cd examples/$lang
        for i in *.py; do
            perl -we '
                my $name = $ARGV[0];
                $name =~ s/\.py$//;

                chomp(my $description = <>);
                $description =~ s/^# //;

                local $/;
                my $code = <>;
                $code =~ s/\n$//;
                $code =~ s/(["\\])/\\$1/g;
                $code =~ s/\n/\\n/gm;
                print "examples[\"$name\"] = { description: \"$description\", code: \"$code\" };\n";
            ' "$i"
        done
    } | sed -e 's+\\$+\\n\\+' > examples-db.$lang.js
done
