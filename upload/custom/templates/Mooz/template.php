<?php
/*
 *	NamelessMC by Samerton |  Mooz Template by zJerino
 *
 *	License: MIT
 *	Cache d158baba76918cba404ac4ed3da2b2ff345227cd.cache
 */

require_once 'core/classes/autoload.php';

MConfig::setFile(join(DIRECTORY_SEPARATOR, array(__DIR__, 'core', 'config.php')));
define('CPATH', (defined('CONFIG_PATH') ? CONFIG_PATH : ''));

/* ······················[Mooz Setup]······················ */
if (!MConfig::getBool('installed')) {
    MConfig::setMultiple(array(
        'installed' => true,
        'web' => array(
            'site-name' => SITE_NAME,
            'description' => "I'am Using Mooz Template",
            'keywords' => 'NamelesssMC, CMS, Mooz',
            'logo' => (defined('CONFIG_PATH') ? CONFIG_PATH : '') . '/custom/templates/Mooz/img/logo.png',
            'banner' => (defined('CONFIG_PATH') ? CONFIG_PATH : '') . '/custom/templates/Mooz/img/banner.png',
            'footer-text' => 'Change in StaffCP -> Layout -> Templates -> Mooz Settings -> Footer',
            'announcements' => true,
            'emoji-system' => true,
            'animations' => true,
        ),
        'styles' => array(
            'primary-type' => 1,
            'primary-1' => 'rgb(255, 224, 80)',
            'primary-2' => 'rgb(255, 116, 116)',
            'secondary' => 'rgb(194, 194, 194)',
            'light-color' => 'rgb(231, 231, 231)',
            'dark-color' => 'rgb(22, 22, 22)',
            'success-color' => "rgb(49, 206, 0)",
            'info-color' => "rgb(2, 190, 249)",
            'warning-color' => "rgb(247, 247, 0)",
            'danger-color' => "rgb(253, 0, 0)",
            // OTHERS
            'body-bg' => "rgb(231, 231, 231)",
            'banner-icons' => "rgb(73, 73, 73)",
            'font-color-1' => "rgb(73, 73, 73)",
            'font-color-2' => "rgb(103, 103, 103)",
            'font-color-3' => "rgb(243, 241, 241)",
            'font-color-4' => "rgb(36, 36, 36)",
            'card-body' => "rgb(255, 255, 255)",
            'card-footer' => "rgb(247, 247, 247)",
            'font-import' => "@import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@100;300;400;500;600;700&display=swap');",
            'font-family' => "font-family: 'Montserrat', sans-serif;",
            'font-size' => "0.9rem"

        ),
    ));

    // Success Alert
    $success = "Mooz se a autoconfigurado.";
    Session::flash('admin_templates', $success);
}

$MzLang = new Language(ROOT_PATH . '/custom/templates/Mooz/core/language', LANGUAGE);
$smarty->debugging = true;
$smarty->assign('mooz', array(
    'web' => MConfig::getArray('web'),
    'lang' => array(
        'quick_link' => $MzLang->get('general', 'quick_link'),
        'about_us' => $MzLang->get('general', 'about_us'),
    )
));





class Mooz_Template extends TemplateBase {
    private Language $_language;
    private User $_user;
    private Pages $_pages;
    private array $_template;
    private Cache $_cache;
    private Smarty $_smarty;

    public function __construct($cache, $smarty, $language, $user, $pages){

        $template = array(
            'name' => 'Mooz',
            'version' => '1.6.3',
            'nl_version' => "2.0.0-pr12",
            'author' => '<a href="https://discord.gg/SKk3GvQ" target="_blank">zJerino</a>',
            'path' =>  CPATH . '/custom/templates/Mooz/',
            'assets' => CPATH . '/custom/templates/Mooz/core/assets/',
        );
        $NamelessMC['core']['assets'] =  (defined('CONFIG_PATH') ? CONFIG_PATH : '') . '/core/assets/';

        parent::__construct($template['name'], $template['version'], $template['nl_version'], $template['author']);

        $this->addCSSFiles(array(
            $template['assets'] . 'css/material.css' => array('async' => "yes"),
            $template['assets'] . 'css/bootstrap-grid.min.css' => array('async' => "yes"),
            $template['assets'] . 'css/all.min.css' => array('async' => "yes"),
            $template['assets'] . 'css/toastr.min.css' => array(),
            $template['assets'] . 'semantic-ui/transition.min.css' => array(),
            $template['assets'] . 'semantic-ui/popup.min.css' => array(),
            $NamelessMC['core']['assets'] . 'plugins\tinymce\plugins\spoiler\css\spoiler.css' => array('async' => "yes"),
             //Temp
            $template['assets'] . 'css/styles.php' => array(),
        ));

        $this->_settings = ROOT_PATH . '/custom/templates/Mooz/core/panel/index.php';

        // Addons
        MConfig::setFile(join(DIRECTORY_SEPARATOR, array(__DIR__, 'core', 'config.php')));
        if (MConfig::getBool('web/animations', true)) {
            $this->addCSSFiles(array(
                $template['assets'] . 'css/animate.css' => array('async' => "yes"),
            ));
        }
        if (MConfig::getBool('web/emoji-system', true)) {
            $this->addJSFiles(array(
                'https://twemoji.maxcdn.com/v/13.0.0/twemoji.min.js' => array('integrity' => "sha384-avLpk7eChiSgpDvwa4N7hvg9vj6V9sfFmGHurVkPOlWUalASzcO3d2x3qcbQqhsH", 'crossorigin' => "anonymous"),
                $NamelessMC['core']['assets'] . 'plugins/emojionearea/js/emojionearea.min.js' => array('defer' => "yes"),
            ));
            $this->addCSSFiles(array(
                $NamelessMC['core']['assets'] . 'plugins/emojionearea/css/emojionearea.min.css' => array('defer' => "yes"),
            ));
            $this->addJSScript('
				twemoji.parse(document.body);
			');
        }

        $this->addJSFiles(array(
            $template['assets'] . 'js/jquery.min.js' => array(),
            $template['assets'] . 'js/popper.min.js' => array(),
            $template['assets'] . 'js/jquery.cookie.js' => array(),
            $template['assets'] . 'js/bootstrap.min.js' => array(),
            $template['assets'] . 'js/material.js' => array(),
            $template['assets'] . 'semantic-ui/transition.min.js' => array(),
            $template['assets'] . 'semantic-ui/popup.min.js' => array(),
            $NamelessMC['core']['assets'] . 'plugins\tinymce\plugins\spoiler\js\spoiler.js' => array(),
            $template['assets'] . 'js/toastr.min.js' => array(),
        ));

        // Define chatbox script path
        define('CHATBOX_SCRIPT', $template['assets'] . 'js/chatbox.js');

        $smarty->assign(array(
            'TEMPLATE' => $template,
        ));
        $this->_template = $template;
        $this->_language = $language;
        $this->_smarty = $smarty;
        $this->_user = $user;
        $this->_pages = $pages;
        $this->_cache = $cache;
    }

    public function getSettings(){
        return $this->_settings;
    }

    public function onPageLoad() {

        $this->addCSSFiles(array(
            $this->_template['assets'] . 'css/custom.css' => array('async' => "yes"),
        ));
        //Ruta
        $route = (isset($_GET['route']) ? rtrim($_GET['route'], '/') : '/');
        $this->_smarty->assign(array(
            'SITE_URL_SET' => $route,
        ));
        //Java Script Variables
        $JSVariables = array(
            'siteName' => SITE_NAME,
            'Mantenimiento' => $this->_language->get('admin', 'maintenance_enabled'),
            'siteURL' => URL::build('/'),
            'fullSiteUrl' => Util::getSelfURL() . ltrim(URL::build('/'), '/'),
            'page' => PAGE,
            'avatarSource' => Util::getAvatarSource(),
            'copied' => $this->_language->get('general', 'copied'),
            'cookieNotice' => $this->_language->get('general', 'cookie_notice'),
            'noMessages' => $this->_language->get('user', 'no_messages'),
            'newMessage1' => $this->_language->get('user', '1_new_message'),
            'newMessagesX' => $this->_language->get('user', 'x_new_messages'),
            'noAlerts' => $this->_language->get('user', 'no_alerts'),
            'newAlert1' => $this->_language->get('user', '1_new_alert'),
            'newAlertsX' => $this->_language->get('user', 'x_new_alerts'),
            'bungeeInstance' => $this->_language->get('general', 'bungee_instance'),
            'andMoreX' => $this->_language->get('general', 'and_x_more'),
            'noPlayersOnline' => $this->_language->get('general', 'no_players_online'),
            'offline' => $this->_language->get('general', 'offline'),
            'confirmDelete' => $this->_language->get('general', 'confirm_deletion'),
            'debugging' => ((defined('DEBUGGING') && DEBUGGING == 1) ? '1' : '0'),
            'loggedIn' => ($this->_user->isLoggedIn() ? '1' : '0'),
            'cookie'  => (defined('COOKIE_NOTICE') ? '1' : '0'),
            'loadingTime' => ((defined('PAGE_LOADING') && PAGE_LOADING == 1) ? PAGE_LOAD_TIME : ''),
            'route' => $route
        );
        $JSVars = '';
        $i = 0;
        foreach ($JSVariables as $var => $value) {
            $JSVars .= ($i == 0 ? 'var ' : ', ') . $var . ' = "' . $value . '"';
            $i++;
        }

        if (PAGE === 'cc_messaging') {
            $this->addJSFiles(array(
                $this->_template['assets'] . 'plugin/eoa/emojionearea.min.js' => array(),
            ));$this->addCSSFiles(array(
                $this->_template['assets'] . 'plugin/eoa/emojionearea.min.css' => array(),
            ));
        }
        $this->addJSScript($JSVars);
        $this->addJSFiles(array(
            $this->_template['assets'] . 'js/core/core.js' => array(),
            $this->_template['assets'] . 'js/core/user.js' => array(),
            $this->_template['assets'] . 'js/core/pages.js' => array(),
            $this->_template['assets'] . 'js/core/chuchuwa.js' => array(),
            $this->_template['assets'] . 'js/scripts.js' => array(),
        ));

        foreach($this->_pages->getAjaxScripts() as $script){
            $this->addJSScript('$(document).ready(function(){ $.getJSON(\'' . $script . '\', function(data) {}); });');
        }

        $this->addJSScript('console.debug("\n| ······················[TEMPLATE INFO]······················ \n Name: '.$this->getName().' \n Version: '.$this->getVersion().'\n NamelessMC: '.$this->getNamelessVersion().' - '. NAMELESS_VERSION .'\n| ······················[TEMPLATE INFO]······················ |")');
    }
    //Agregar Archivos CSS
    public function addCSSFiles($files){
        if(is_array($files) && count($files)){
            foreach($files as $href => $file)
                $this->_css[] = '<link rel="stylesheet"  href="' . $href . '"'. (isset($file['defer']) ? ' defer=""' : '') . (isset($file['async']) ? ' async=""' : '') . (isset($file['integrity']) ? ' integrity="' . $file['integrity'] . '"' : '') . (isset($file['crossorigin']) ? ' crossorigin="' . $file['crossorigin'] . '"' : '') . '>';
        }
    }
    //Agregar Estilos CSS
    public function addCSSStyle($style = null){
        if($style)
            $this->_css[] = '<style>' . $style . '</style>';
    }
    //Agregar Archivos JavaScript
    public function addJSFiles($files){
        if(is_array($files) && count($files)){
            foreach($files as $href => $file)
                $this->_js[] = '<script type="text/javascript" src="' . $href . '"'. (isset($file['media']) ? ' media="' . $file['integrity'] . '"' : '') . (isset($file['defer']) ? ' defer=""' : '') . (isset($file['async']) ? ' async=""' : '') . (isset($file['integrity']) ? ' integrity="' . $file['integrity'] . '"' : '') . (isset($file['crossorigin']) ? ' crossorigin="' . $file['crossorigin'] . '"' : '') . '></script>';
        }
    }
    //Agregar Scripts JavaScript
    public function addJSScript($script = null){
        if($script)
            $this->_js[] = '<script type="text/javascript">' . $script . '</script>';
    }
}
$template = new Mooz_Template($cache, $smarty, $language, $user, $pages);
