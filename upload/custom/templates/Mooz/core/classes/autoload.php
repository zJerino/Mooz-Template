<?php

spl_autoload_register(function ($class) {
    $path = join(DIRECTORY_SEPARATOR, array(__DIR__, $class . '.php'));
    if (file_exists($path)) {
        require_once($path);
    }
});
