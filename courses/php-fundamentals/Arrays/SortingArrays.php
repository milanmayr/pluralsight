<?php

$authors = array("Charles Dickens",
        "Jane Austin",
        "William Shakespeare",
        "Mark Twain",
        "Louisa May Alcott"
    );

$authorsAssociative = array(
        "quarky" => "Charles Dickens",
        "brilliant" => "Jane Austin",
        "poetic" => "William Shakespeare"
    );

ksort($authorsAssociative);

print_r($authorsAssociative);