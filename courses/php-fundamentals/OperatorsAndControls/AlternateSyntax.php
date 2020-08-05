<?php

$readingIsFun = true;
$authors = array("Charles Dickens",
        "Jane Austin",
        "William Shakespeare",
        "Mark Twain",
        "Louisa May Alcott"
    );
$count = count($authors);

if($count > 0) :
    echo "There is a total of ".$count." authors(s).";
else :
    echo "There are no authors.";
endif;

while ($i < 5) :
    echo "Reading is fun!".PHP_EOL;
    $i++;
endwhile;

for ($i = 0; $i < 5; $i++) :
    echo "Reading is fun!".PHP_EOL;
endfor;