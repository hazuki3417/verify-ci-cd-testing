<?php

use MongoDB\Driver\Command;
use MongoDB\Driver\Manager;

$manager = new Manager('mongodb://verify-ci-cd-mongo:27017');
$command = new Command(['ping' => 1]);

try {
    $cursor = $manager->executeCommand('admin', $command);
} catch(MongoDB\Driver\Exception $e) {
    echo $e->getMessage(), "\n";
    exit;
}

/* The ping command returns a single result document, so we need to access the
 * first result in the cursor. */
$response = $cursor->toArray()[0];

var_dump($response);
