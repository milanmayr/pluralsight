<?php

$authors = array(
        "Charles Dickens",
        "Jane Austin",
        "William Shakespeare"
    );

$lastValue = array_pop($authors);

echo $lastValue;
print_r($authors);