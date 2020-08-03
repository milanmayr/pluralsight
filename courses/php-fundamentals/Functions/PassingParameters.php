<?php

function bookByAuthorYear($authorName, $year)
{
    echo $year;
    echo "\n";
    echo $authorName;
    echo "\n";
}

$year = 1910;
$authorName = "William Shakespeare";

bookByAuthorYear($authorName, $year);