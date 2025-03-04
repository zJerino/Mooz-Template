<?php
/*
 *  Made by Samerton
 *  https://github.com/NamelessMC/Nameless/
 *  NamelessMC version 2.0.0-pr13
 *  License: MIT
 */

use ScssPhp\ScssPhp\Compiler;
use ScssPhp\ScssPhp\OutputStyle;

$TEMPLATE_NAME = 'Mooz';
$TEMPLATE_PATH  = dirname(__DIR__);

$tcfile = join(DIRECTORY_SEPARATOR, [__DIR__, 'config.php']);

$navTOP = $navigation->returnNav('top');

$theme = [
    'defaultMode' => 1,
    'gradient' => 0,
    'fs' => '1rem',
    'ff' => '"Montserrat", sans-serif',
    'ffl' => 'https://fonts.googleapis.com/css2?family=Montserrat:wght@100;300;400;500;600;700&display=swap',
    'colors' => [
        'primary' => '#0d6efd',
        'secondary' => '#adb5bd',
        'success' => '#198754',
        'info' => '#0dcaf0',
        'warning' => '#ffc107',
        'danger' => '#dc3545',
    ],
    'portal' => [
        'nav_item' => $navTOP[array_key_first($navTOP)] ?? null,
        'text' => 'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Praesentium, itaque. Rem esse, accusantium neque eius minima iure inventore iste, nobis dolores pariatur consequatur blanditiis delectus temporibus rerum deleniti error labore!'
    ]
];


include_once $tcfile;

if (Input::exists()) {
    if (Token::check()) {
        if (isset($_POST['home']) || isset($_POST['portal'])) {
            $theme['portal'] = array_merge($theme['portal'], $_POST['portal']);
        } else if (isset($_POST['colors'])) {
            $colors = $_POST['colors'] ?? [];
            if (isset($_POST['gradient'])) $theme['gradient'] = ($_POST['gradient'] ?? 0);

            if (isset($_POST['fs'])) $theme['fs'] = ($_POST['fs'] ?? '1rem');
            if (isset($_POST['ff'])) $theme['ff'] = ($_POST['ff'] ?? '"Montserrat", sans-serif');
            if (isset($_POST['ffl'])) $theme['ffl'] = ($_POST['ffl'] ?? 'https://fonts.googleapis.com/css2?family=Montserrat:wght@100;300;400;500;600;700&display=swap');

            require join(DIRECTORY_SEPARATOR, [$TEMPLATE_PATH, 'utils', 'vendor', 'autoload.php']);
            $compiler = new Compiler();

            $theme['colors'] = array_merge($theme['colors'], $colors);
            
            $compiler->setOutputStyle(OutputStyle::COMPRESSED);
            $compiler->setImportPaths(join(DIRECTORY_SEPARATOR, [$TEMPLATE_PATH, 'assets', 'scss']));
            
            $result = $compiler->compileString('
                @import "functions";

                '.(strlen($theme['ffl']) > 1 ? '@import url("'.$theme['ffl'].'");' : '').'
                $font-family-base: '. $theme['ff'] .';
                $font-size-base: '. $theme['fs'] .';

                $mz-gradient: '.(($theme['gradient'] == '1') ? 1 : 0).';

                $primary: '. $theme['colors']['primary'] .';
                $secondary: '. $theme['colors']['secondary'] .';
                $success: '. $theme['colors']['success'] .';
                $info: '. $theme['colors']['info'] .';
                $warning: '. $theme['colors']['warning'] .';
                $danger: '. $theme['colors']['danger'] .';

                @import "variables";
                @import "variables-dark";

                $custom-colors: (
                    "indigo":     $indigo,
                    "purple":     $purple,
                    "pink":       $pink,
                    "orange":     $orange,
                    "teal":       $teal,
                );

                $theme-colors: map-merge($theme-colors, $custom-colors);

                @import "maps";
                @import "mixins";
                @import "utilities";

                // Layout & components
                @import "root";
                @import "reboot";
                @import "type";
                @import "images";
                @import "containers";
                @import "grid";
                @import "tables";
                @import "forms";
                @import "buttons";
                @import "transitions";
                @import "dropdown";
                @import "button-group";
                @import "nav";
                @import "navbar";
                @import "card";
                @import "accordion";
                @import "breadcrumb";
                @import "pagination";
                @import "badge";
                @import "alert";
                @import "progress";
                @import "list-group";
                @import "close";
                @import "toasts";
                @import "modal";
                @import "tooltip";
                @import "popover";
                @import "carousel";
                @import "spinners";
                @import "offcanvas";
                @import "placeholders";

                // Helpers
                @import "helpers";

                // Utilities
                @import "utilities/api";

                // Mooz
                @import "mooz";
                // scss-docs-end import-stack

            ');


            $filecss = join(DIRECTORY_SEPARATOR, [$TEMPLATE_PATH, 'assets', 'css', 'bs-custom.css']);
            file_put_contents($filecss, $result->getCss());
        }

        if (isset($_POST['defaultMode'])) $theme['defaultMode'] = ($_POST['defaultMode'] ?? 0);


        file_put_contents($tcfile, "<?php" . PHP_EOL . "/**" . PHP_EOL . "* Settings" . PHP_EOL . "*/ " . PHP_EOL . "\$theme = array_merge(\$theme ?? [], ". var_export($theme, true) .");");
        Session::flash('admin_templates', $language->get('admin', 'successfully_updated'));
    } else {
        $errors = [$language->get('general', 'invalid_token')];
    }
}

// Discord ID

$current_template->assets()->include([
    AssetTree::TINYMCE,
    AssetTree::BOOTSTRAP_COLORPICKER
]);
$current_template->addJSScript("
    document.querySelectorAll('.bscp').forEach(e => {
        $(e).colorpicker();
    })
");

if (Util::getSetting('home_type') == 'portal') {
    $current_template->addJSScript(Input::createTinyEditor($language, 'portal-description', ($theme['portal']['text'] ?? 'Change text')));
} else {
    $current_template->addJSScript(Input::createTinyEditor($language, 'inputHomeCustomContent', Util::getSetting('home_custom_content')));
}

$smarty->assign([
    'SUBMIT' => $language->get('general', 'submit'),
    'mzl' => [
        'portal' => $language->get('admin', 'portal'),
        'enabled' => $language->get('admin', 'enabled'),
        'disabled' => $language->get('admin', 'disabled'),
        'dark_mode' => $language->get('admin', 'dark_mode'),        
    ],
    'mzv' => [
        'portal' => (Util::getSetting('home_type') === 'portal')
    ],
    'theme' => $theme,
    'navtop' => $navTOP,
    'HOME_CUSTOM_CONTENT' => $language->get('admin', 'home_custom_content'),
    'SETTINGS_TEMPLATE' => ROOT_PATH . '/custom/templates/Mooz/template_settings/settings.tpl'
]);
