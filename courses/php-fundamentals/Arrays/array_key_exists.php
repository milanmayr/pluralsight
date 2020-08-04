<?php

$authors = array("Charles Dickens", "Jane Austin", "William Shakespeare");

$authorsAssociative = array (
        "quarky" => "Charles Dickens",
        "brilliant" => "Jane Austin",
        "poetic" => "Wiliam Shakespeare"
    );

// echo $authors[1];
// echo $authorsAssociative['quarky'];

echo array_key_exists('poetic', $authorsAssociative);