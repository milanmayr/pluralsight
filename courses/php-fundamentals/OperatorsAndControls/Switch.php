<?php

$authors = array("Charles Dickens",
        "Jane Austin",
        "William Shakespeare",
        "Mark Twain",
        "Louisa May Alcott"
    );

$count = count($authors);

switch($count)
{
    case 0:
        echo "There are no authors.".PHP_EOL;
        break;
    case 1:
        echo "There is only 1 author.".PHP_EOL;
        break;
    default:
        echo "There are ".$count." authors.".PHP_EOL;
        break;
}

switch( 5 <=> 7)
{
    case 1:
        echo "Greater Than";
        break;
    case 0:
        echo "Equal";
        break;
    case -1:
        echo "Less Than";
        break;
}