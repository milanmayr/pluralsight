<?php

// Define a constant string
define('CHECK_CONSTANT', "Yes, I am a constant!");

// Define different variable types to test the different variable type methods
$intVar = 1234;
$stringVar = "I'm a string";
$boolVar = false;
$floatVar = 12.34;

// echo is_int($boolVar);
// echo is_string($stringVar);
// echo is_bool($boolVar);
// echo is_float($floatVar);

echo defined('CHECK_CONSTANT');