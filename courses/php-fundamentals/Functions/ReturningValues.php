<?php

function booksByAuthorYear($tempAuthorName, $tempYear = 1910)
{
    echo $tempYear;
    echo "\n";
    echo $tempAuthorName;
    echo "\n";
}

function getAuthor()
{
    return "Charles Dickens";
}

$year = 1920;
$authorName = getAuthor();

booksByAuthorYear($authorName, $year);