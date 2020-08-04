<?php

$authors = [
    "Male" => array(
        "Charles Dickens" => array("A Christmas Carol", "Oliver Twist"),
        "William Shakespeare" => array("Romeo & Juliet", "Richard III"),
        "Mark Twain" => array("Tom Sawyer", "Huck Finn")
    ),
    "Female" => array(
        "L. M. Montgomery" => array("Anne of Green Gables", "Anne of Avonlea"),
        "Louisa May Alcott" => array("Little Women")
    )
    ];

echo count($authors, COUNT_RECURSIVE);