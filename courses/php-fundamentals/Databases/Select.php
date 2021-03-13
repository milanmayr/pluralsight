<?php

$dbPassword = "PHPFundamentals";
$dbUserName = "PHPFundamentals";
$dbServer = "172.17.0.4:3306";
$dbName = "PHPFundamentals";

$connection = new mysqli($dbServer, $dbUserName, $dbPassword, $dbName);

if($connection->connect_errno)
{
    exit("Database Connection failed. Reason: ".$connection->connect_error);
}

$query = "SELECT first_name, last_name, pen_name FROM Authors ORDER BY first_name";
$resultObj = $connection->query($query);

if ($resultObj->num_rows > 0)
{
    while ($singleRowFromQuery = $resultObj->fetch_assoc())
    {
        print_r($singleRowFromQuery)
    }
}

$connection->close();