<?php
/*
 *  Mooz Template | Made by zJerino
 *  
 *  NamelessMC version 2.1.2
 *  License: MIT
 */

const ZDEV = true;

class Mooz_Template extends TemplateBase {

    private array $_template;

    /** @var Language */
    private Language $_language;

    /** @var User */
    private User $_user;

    /** @var Pages */
    private Pages $_pages;

    public function __construct($cache, $smarty, $language, $user, $pages) {
        $template = [
            'name' => 'Mooz',
            'version' => '2.0.0',
            'nl_version' => '2.1.3',
            'author' => '<a href="https://cuberico.cloud/" target="_blank">zJerino</a>',
        ];

        $template['path'] = (defined('CONFIG_PATH') ? CONFIG_PATH : '') . '/custom/templates/' . $template['name'] . '/';

        parent::__construct($template['name'], $template['version'], $template['nl_version'], $template['author']);

        $this->_settings = ROOT_PATH . '/custom/templates/' . $template['name'] . '/template_settings/settings.php';

        $this->assets()->include([
            AssetTree::FONT_AWESOME,
            AssetTree::JQUERY,
            AssetTree::JQUERY_COOKIE,
        ]);

        $smarty->assign('TEMPLATE', $template);

        // Languages
        $smarty->assign('mzlang', array(
            'mc_account' => $language->get('user', 'minecraft_username'),
            'integrations' => $language->get('admin', 'integrations'),
        ));

        // Other variables
        $smarty->assign('FORUM_SPAM_WARNING_TITLE', $language->get('general', 'warning'));

        $this->_template = $template;
        $this->_language = $language;
        $this->_user = $user;
        $this->_pages = $pages;
        $this->_smarty = $smarty;
    }

    public function onPageLoad() {
        // Page load
        $page_load = microtime(true) - PAGE_START_TIME;
        define('PAGE_LOAD_TIME', $this->_language->get('general', 'page_loaded_in', ['time' => round($page_load, 3)]));

        // Theme configuration
        include ROOT_PATH . '/custom/templates/' . $this->_template['name'] . '/template_settings/config.php';

        $this->_smarty->assign(array(
            'MZ_THEME' => [
                'darkmode' => $theme['defaultMode'] ?? 1
            ]
        ));

        // Styles
        $customBs = join(DIRECTORY_SEPARATOR, ['assets', 'css', 'bs-custom.css']);
        $MoozCSS = join(DIRECTORY_SEPARATOR, ['assets', 'css', 'mooz.css']);

        $this->addCSSFiles([
            $this->_template['path'] . $customBs . ((defined('ZDEV') && ZDEV == true) ? ('?v=' . filemtime(join(DIRECTORY_SEPARATOR, [__DIR__, $customBs]))) : '') => [],
            $this->_template['path'] . $MoozCSS . ((defined('ZDEV') && ZDEV == true) ? ('?v=' . filemtime(join(DIRECTORY_SEPARATOR, [__DIR__, $MoozCSS]))) : '') => [],
            'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css' => [],
        ]);

        $route = (isset($_GET['route']) ? rtrim($_GET['route'], '/') : '/');

        // JSVars
        $JSVariables = [
            'siteName' => Output::getClean(SITE_NAME),
            'siteURL' => URL::build('/'),
            'fullSiteURL' => URL::getSelfURL() . ltrim(URL::build('/'), '/'),
            'page' => PAGE,
            'avatarSource' => AvatarSource::getUrlToFormat(),
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
            'onePlayerOnline' => $this->_language->get('general', 'currently_1_player_online'),
            'xPlayersOnline' => $this->_language->get('general', 'currently_x_players_online'),
            'noPlayersOnline' => $this->_language->get('general', 'no_players_online'),
            'offline' => $this->_language->get('general', 'offline'),
            'confirmDelete' => $this->_language->get('general', 'confirm_deletion'),
            'debugging' => (defined('DEBUGGING') && DEBUGGING == 1) ? '1' : '0',
            'loggedIn' => $this->_user->isLoggedIn() ? '1' : '0',
            'cookie' => defined('COOKIE_NOTICE') ? '1' : '0',
            'loadingTime' => Util::getSetting('page_loading') === '1' ? PAGE_LOAD_TIME : '',
            'route' => $route,
            'csrfToken' => Token::get(),
        ];

        // Logo
        $cache = new Cache(['name' => 'nameless', 'extension' => '.cache', 'path' => ROOT_PATH . '/cache/']);
        $cache->setCache('backgroundcache');
        $logo_image = $cache->retrieve('logo_image');
        $JSVariables['logoImage'] = !empty($logo_image) ? $logo_image : null;

        if (str_contains($route, '/forum/topic/') || PAGE === 'profile') {
            $this->assets()->include([
                AssetTree::JQUERY_UI,
            ]);
        }

        if (str_contains($route, '/members/') || PAGE === 'members') {
            $this->assets()->include([
                AssetTree::SELECT2,
            ]);
            $this->addCSSFiles([
                'https://cdn.jsdelivr.net/npm/select2-bootstrap-5-theme@1.3.0/dist/select2-bootstrap-5-theme.min.css' => [],
            ]);
            $this->addJSFiles([
                'https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js' => [],
            ]);
        } else if (PAGE === 'portal') {
            $this->_smarty->assign(array(
                'CONTENT_PORTAL' => ($theme['portal']['text'] ?? ''),
                'PORTAL_ITEM' => ($theme['portal']['nav_item'] ?? null),
            ));
        }

        $JSVars = '';
        $i = 0;
        foreach ($JSVariables as $var => $value) {
            $JSVars .= ($i == 0 ? 'const ' : ', ') . $var . ' = ' . json_encode($value);
            $i++;
        }

        $this->addJSScript($JSVars);

        $this->addJSFiles([
            $this->_template['path'] . 'assets/js/core/core.js' . ((defined('ZDEV') && ZDEV == true) ? ('?v=' . filemtime(join(DIRECTORY_SEPARATOR, [__DIR__, 'assets/js/core/core.js']))) : '') => [],
            $this->_template['path'] . 'assets/js/core/user.js' . ((defined('ZDEV') && ZDEV == true) ? ('?v=' . filemtime(join(DIRECTORY_SEPARATOR, [__DIR__, 'assets/js/core/user.js']))) : '') => [],
            $this->_template['path'] . 'assets/js/core/pages.js' . ((defined('ZDEV') && ZDEV == true) ? ('?v=' . filemtime(join(DIRECTORY_SEPARATOR, [__DIR__, 'assets/js/core/pages.js']))) : '') => [],
            $this->_template['path'] . 'assets/js/core/mooz.js' . ((defined('ZDEV') && ZDEV == true) ? ('?v=' . filemtime(join(DIRECTORY_SEPARATOR, [__DIR__, 'assets/js/core/mooz.js']))) : '') => [],
            'https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js' => [],
        ]);

        foreach ($this->_pages->getAjaxScripts() as $script) {
            $this->addJSScript('$.getJSON(\'' . $script . '\', function(data) {});');
        }
    }
}

$template = new Mooz_Template($cache, $smarty, $language, $user, $pages);
$template_pagination = ['div' => 'pagination d-inline-flex mb-0', 'a' => 'page-link {x}'];