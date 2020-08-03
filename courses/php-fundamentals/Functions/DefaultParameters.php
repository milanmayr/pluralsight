<?php

function bookByAuthorYear($tempAuthorName, $tempYear = 1910)
{
    echo $tempYear;
    echo "\n";
    echo $tempAuthorName;
    echo "\n";
}

$year = 1920;
$authorName = "William Shakespeare";

bookByAuthorYear($authorName);