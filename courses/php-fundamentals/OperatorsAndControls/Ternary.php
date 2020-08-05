<?php

$authors = array("Charles Dickens",
        "Jane Austin",
        "William Shakespeare",
        "Mark Twain",
        "Louisa May Alcott"
    );

$count = count($authors);

$outcome = ($count > 0) ? "Author Total: ".$count : "No Authors";

echo $outcome;