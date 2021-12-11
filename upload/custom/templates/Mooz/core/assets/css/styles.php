<?php
    header("Content-type: text/css; charset: UTF-8");
    require_once '../../classes/autoload.php';
?>
<?php
    $GLOBALS['config'] = array();

    $path = join(DIRECTORY_SEPARATOR, array(__DIR__, '..', '..', 'config.php'));
    MConfig::setFile($path);
    echo ':root {';

    if (!MConfig::getBool('styles/primary-type', true)) {
        echo '--primary: '.MConfig::getStr('styles/primary-1').' !important;';
    } else {
        echo '--primary: linear-gradient(to right, var(--color1), var(--color2)) !important;';
    }
    print('
    --color1: '.MConfig::getStr('styles/primary-1').' !important;
    --color2: '.MConfig::getStr('styles/primary-2').' !important;
    --secondary: '.MConfig::getStr('styles/secondary').' !important;
    --body: '.MConfig::getStr('styles/body-bg').' !important;
    --hicons: '.MConfig::getStr('styles/banner-icons').' !important;
    --success: '.MConfig::getStr('styles/success-color').' !important;
    --info: '.MConfig::getStr('styles/info-color').' !important;
    --warning: '.MConfig::getStr('styles/warning-color').' !important;
    --danger: '.MConfig::getStr('styles/danger-color').' !important;
    --text-1: '.MConfig::getStr('styles/font-color-1').' !important;
    --text-2: '.MConfig::getStr('styles/font-color-2').' !important;
    --text-3: '.MConfig::getStr('styles/font-color-3').' !important;
    --text-4: '.MConfig::getStr('styles/font-color-4').' !important;
    --cardb: '.MConfig::getStr('styles/card-body').' !important;
    --cardf: '.MConfig::getStr('styles/card-footer').' !important;
    --FONT_SIZE: '.MConfig::getStr('styles/font-size').' !important;
}
');
echo MConfig::getStr('styles/font-import');
?>

<?php
    if (MConfig::getBool('styles/primary-type', true)){
?>
    .blockquote{
        border-left:.3125rem solid var(--primary);
    }
    .badge-primary{
        background: var(--primary);
    }
    .page-link:focus,.page-link:hover{
        background: var(--primary)
    }
    .page-link.active,.page-link:active{
        background:var(--primary)
    }
    .page-item.active .page-link{
        background:var(--primary)
    }
    .btn.disabled,.btn:disabled{
        background: var(--primary);
    }
    .btn-primary{
        background:var(--primary)
    }
    .btn-flat-primary,.btn-flat-primary:active,.btn-flat-primary:focus,.btn-flat-primary:hover,.btn-outline-primary,.btn-outline-primary:active,.btn-outline-primary:focus,.btn-outline-primary:hover{
        color:var(--primary)
    }
    .asdasasdasdasdadsas:after,.card-body .card-header .card-title:after{
        background:var(--primary);
    }
    .card-news .card-header{
        background:var(--primary);
    }
    .card.border-primary{
        border: solid 1px var(--primary);
        box-shadow: none;
    }
    .card-header{
        background:var(--primary)
    }
    table{
        width: 100% !important;
    }
    .btn-flat-primary, .btn-flat-primary:active, .btn-flat-primary:focus, .btn-flat-primary:hover, .btn-outline-primary, .btn-outline-primary:active, .btn-outline-primary:focus, .btn-outline-primary:hover {
        color: var(--text-1);
    }
    .bg-primary{
        background: var(--primary);
    }
<?php
    } else {
?>
//Hola 1
<?php
    }
?>
.card {
    border-radius: 5px;
}
body, label, input {
    color: var(--text-1) !important;
    font-size: <?php echo MConfig::getStr('styles/font-size', '0.9rem');?> !important;
    <?php echo MConfig::getStr('styles/font-family', 'font-family: \'Montserrat\', sans-serif;');?>;
}
.alert-primary {
    background-color: var(--cardb) !important;
}
.spoiler {
    background-color: var(--cardf);
    border-left: 3px solid var(--color1);
    box-shadow: none;
}
.text-muted {
    color: var(--text-2) !important;
}
.nav-pills .nav-link {
    color: var(--text-1) !important;
}
.nav-pills .nav-link.active{
    background: var(--primary) !important;
}
    .card-body, .list-group-item, .list-group-item:hover, .breadcrumb{
        background-color: var(--cardb) !important;
        color: var(--text-1);
    }
    .ui.popup, .ui.bottom.left.popup:before {
        background-color: var(--cardb);
        color: var(--text-1) !important;
    }
    .ui.popup{
        border: 1px #9c9c9c61 solid;
    }
    .tox .tox-edit-area__iframe, .tox .tox-statusbar, .tox .tox-toolbar, .tox-tinymce, .tox .tox-toolbar__group:not(:last-of-type), .tox .tox-tbtn svg, .tox .tox-tbtn--bespoke .tox-tbtn__select-label, .mce-content-body {
        background-color: var(--cardb) !important;
        color: var(--text-1) !important;
        border: 0px solid #94949421 !important;
        border-radius: 6px !important;
        fill:  var(--text-1) !important;
    }
    
    .breadcrumb-item.active {
        color: var(--text-1);
    }
    .card-footer {
        background-color: var(--cardf);
    }
    input.btn {
        color: var(--text-3) !important;
    }

    .navbar-nav .nav-link{
        cursor: pointer;
    }
    avatar>img {
    width: 2.5rem;
    height: 2.5rem;
    border-radius: 50%;
}
#ChatMensajes {
    margin-bottom: 12px;
    background-color: rgba(148, 148, 148, 0.10196078431372549);
    border-radius: 6px;
    height: 250px;
    max-width: 100%;
    overflow-y: scroll;
    max-height: 13rem;
}
.hicons {
    color: var(--hicons)
}