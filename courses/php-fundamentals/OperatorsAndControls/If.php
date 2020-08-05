<?php

$authors = array("Charles Dickens",
        "Jane Austin",
        "William Shakespeare",
        "Mark Twain",
        "Louisa May Alcott"
    );
$authors = [];

$count = count($authors);

if($count > 0)
{
    echo "There is a total of ".$count." authors(s).";
}
else
{
    echo "There are no authors.";
}