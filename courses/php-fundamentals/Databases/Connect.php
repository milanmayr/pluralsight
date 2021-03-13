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