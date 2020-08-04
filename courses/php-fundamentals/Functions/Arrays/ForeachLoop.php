<?php

$authors = array(
    "quarky" => "Charles Dickens",
    "brilliant" => "Jane Austin",
    "poetic" => "William Shakespeare"
);

foreach($authors as $key => $val)
{
    echo $val." (".$key.")\n";
}