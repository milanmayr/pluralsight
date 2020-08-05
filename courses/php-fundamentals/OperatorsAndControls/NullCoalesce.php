<?php

$authors = array("Charles Dickens",
        "Jane Austin",
        "William Shakespeare",
        "Mark Twain",
        "Louisa May Alcott"
    );
// $count = count($authors);

$outcome = $count ?? $anotherVariable ?? "Count unavailable.";

echo $outcome;