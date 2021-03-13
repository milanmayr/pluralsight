<?php

$dbPassword = "PHPFundamentals";
$dbUserName = "PHPFundamentals";
$dbServer = "172.17.0.3:3306";
$dbName = "PHPFundamentals";

$connection = new mysqli($dbServer, $dbUserName, $dbPassword, $dbName);

print_r($connection);

if($connection->connect_errno)
{
    exit("Database Connection failed. Reason: ".$connection->connect_error);
}

// $query = "UPDATE Authors SET pen_name = 'L. M. Montgomery' WHERE id = 2";
$query = "INSERT INTO Authors (first_name, last_name, pen_name) VALUES (NULL, 'Arthur Ignatius Conan', 'Doyle', 'Sir Arthur Conan Doyle)";

$connection->query($query);

$connection->close();