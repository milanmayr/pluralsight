<?php

$authors = array("Charles Dickens",
        "Jane Austin",
        "William Shakespeare",
        "Mark Twain",
        "Louisa May Alcott"
    );

$count = count($authors) - 4;

if($count == 1)
{
    echo "There is 1 author.";
}
elseif($count > 0)
{
    echo "There is a total of ".$count." authors.";
}
else
{
    echo "There are no authors.";
}