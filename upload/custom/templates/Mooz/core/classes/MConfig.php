<?php
/**
 * Made by zJerino
 */

class MConfig {
    private static string $_file = ROOT_PATH . '/core/config.php';
    private static array $_files = array();

    public static function getStr(string $str = null, string $def = "") :string {
        $conf = self::get($str);
        if (is_string($conf) && $conf != '__ERROR-EXISTS__') {
            return $conf;
        } else {
            return $def;
        }
    }
    public static function getNum(string $str = null, int $def = 0) :int {
        $conf = self::get($str);
        if (is_numeric($conf) && $conf != '__ERROR-EXISTS__') {
            return $conf;
        } else {
            return $def;
        }
    }
    public static function getArray(string $str = null, array $def = array()) : array
    {
        $conf = self::get($str);
        if (is_array($conf) && $conf != '__ERROR-EXISTS__') {
            return $conf;
        } else {
            return $def;
        }
    }
    public static function getBool(string $str = null, bool $def = false) : bool
    {
        $conf = self::get($str);
        if (is_bool($conf) && $conf != '__ERROR-EXISTS__') {
            return $conf;
        } else {
            return $def;
        }
    }
    public static function get($path = null) {
        if ($path) {
            if (!isset($GLOBALS['config'])) {
                throw new Exception('Config unavailable. Please refresh the page.');
            }

            if (!isset(self::$_files[self::$_file])) {
                if (!file_exists(self::$_file)) {
                    throw new Exception('[CUSTOM] config unavailable. Please refresh the page.');
                }

                include_once self::$_file;

                if (isset($conf)) {
                    self::$_files[self::$_file] = $conf;
                } else if (self::$_file == ROOT_PATH . '/core/config.php') {
                    self::$_files[self::$_file] = $GLOBALS['config'];
                }
            }

            $config = (isset(self::$_files[self::$_file]) && is_array(self::$_files[self::$_file]) ? self::$_files[self::$_file] : array());

            $path = explode('/', $path);

            foreach ($path as $bit) {
                if (isset($config[$bit])) {
                    $config = $config[$bit];
                } else {
                    $not_matched = true;
                }
            }

            if (!isset($not_matched)) {
                return $config;
            }
        }
        return '__ERROR-EXISTS__';
    }


    public static function set($key, $value): bool
    {
        if (!file_exists(self::$_file)) {
            fopen(self::$_file, 'w');
        }

        include(self::$_file);

        if (!isset($conf) || !is_array($conf)) {
            $conf = array();
        }

        $path = explode('/', $key);

        if (!is_array($path)) {
            $conf[$key] = $value;
        } else {
            $loc = &$conf;
            foreach($path as $step) {
                $loc = &$loc[$step];
            }
            $loc = $value;
        }

        return static::write($conf);
    }
    public static function setMultiple($values): bool
    {
        if (!file_exists(self::$_file)) {
            fopen(self::$_file, 'w');
        }

        include(self::$_file);

        if (!isset($conf) || !is_array($conf)) {
            $conf = array();
        }

        foreach ($values as $key => $value) {
            $path = explode('/', $key);

            if (!is_array($path)) {
                $conf[$key] = $value;
            } else {
                $loc = &$conf;
                foreach($path as $step) {
                    $loc = &$loc[$step];
                }
                $loc = $value;
            }
        }

        return static::write($conf);
    }
    public static function write($config): bool
    {
        $file = fopen(self::$_file, 'wa+');
        fwrite($file, '<?php' . PHP_EOL . '$conf = ' . var_export($config, true) . ';');
        return fclose($file);
    }

    public static function setFile(string $filename ): void {
        if (!file_exists($filename)) {
            $file = fopen($filename, 'wa+');
            fwrite($file, '<?php' . PHP_EOL . '$conf = ' . var_export(array(), true) . ';');
            fclose($file);
        }

        self::$_file = $filename;
    }
    public static function getFile(): string {
        return self::$_file;
    }
}