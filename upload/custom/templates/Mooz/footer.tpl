
</div>


{* 
<div class="ui inverted vertical footer segment" id="footer">
    <div class="ui container">
        <div class="ui stackable inverted divided equal height stackable grid">
            <div class="{if $SOCIAL_MEDIA_ICONS|count > 0}six{else}eight{/if} wide column">
                <h4 class="ui inverted header">{$SITE_NAME}</h4>
                <div class="ui inverted link list">
                    <span class="item">&copy; {$SITE_NAME} {'Y'|date}</span>
                    <span class="item">Powered By <a href="https://namelessmc.com">NamelessMC</a></span>
                    {if $PAGE_LOAD_TIME}
                    <span class="item" id="page_load"></span>
                    {/if}
                    <span class="item" id="darkmode">
                        <input type="checkbox" class="darkmode-toggle" id="darkmode-toggle" onclick="toggleDarkLightMode()">
                        <label for="darkmode-toggle" class="darkmode-toggle-label">
                            <i class="fas fa-moon"></i>
                            <i class="fas fa-sun"></i>
                            <div class="darkmode-ball"></div>
                        </label>

                        <script type="text/javascript">
                            if (document.body.classList.contains('dark')) {
                                document.getElementById("darkmode-toggle").checked = true;
                            } else {
                                document.getElementById("darkmode-toggle").checked = false;
                            }
                        </script>
                    </span>
                    {if isset($AUTO_LANGUAGE)}
                        <a class="item" href="javascript:" onclick="toggleAutoLanguage()" id="auto-language"></a>
                    {/if}
                </div>
            </div>
            <div class="{if $SOCIAL_MEDIA_ICONS|count > 0}five{else}eight{/if} wide column">
                <h4 class="ui inverted header">{$FOOTER_LINKS_TITLE}</h4>
                <div class="ui inverted link list">
                    {foreach from=$FOOTER_NAVIGATION key=name item=item}
                    {if isset($item.items)}
                    <div class="ui dropdown item">
                        <span class="text">{$item.icon} {$item.title} <i class="dropdown icon"></i></span>
                        <div class="menu">
                            <div class="header">{$item.title}</div>
                            {foreach from=$item.items item=dropdown}
                            <a class="item" href="{$dropdown.link}" target="{$dropdown.target}">{$dropdown.icon}
                                {$dropdown.title}</a>
                            {/foreach}
                        </div>
                    </div>
                    {else}
                    <a class="item" href="{$item.link}" target="{$item.target}">{$item.icon} {$item.title}</a>
                    {/if}
                    {/foreach}
                    <a class="item" href="{$TERMS_LINK}">{$TERMS_TEXT}</a>
                    <a class="item" href="{$PRIVACY_LINK}">{$PRIVACY_TEXT}</a>
                </div>
            </div>
            {if $SOCIAL_MEDIA_ICONS|count > 0}
            <div class="five wide column">
                <h4 class="ui inverted header">{$FOOTER_SOCIAL_TITLE}</h4>
                <div class="ui inverted link list">
                    {foreach from=$SOCIAL_MEDIA_ICONS item=icon}
                    <a class="item" href="{$icon.link}">{$icon.text}</a>
                    {/foreach}
                </div>
            </div>
            {/if}
        </div>
    </div>
</div> *}
<div id="app-footer" class="py-4">
    <div class="container">
      <div class="row">
        <div class="col-12 col-md-4 mb-4 mb-md-0">
          <strong class="mb-3">{$SITE_NAME}</strong>
          <p class="text-secondary mb-0">
            <a class="text-white-50 text-decoration-none" href="#">{$SITE_NAME}</a> &copy; {'Y'|date}
          </p>
          <p class="text-secondary mb-0">
            Forum Software <a class="text-white-50 text-decoration-none" href="https://namelessmc.com">NamelessMC</a>
          </p>
          <p class="text-secondary mb-0">
            Designed by <a class="text-white-50 text-decoration-none" href="https://cuberico.cloud">zHarry</a>
          </p>
        </div>
        <div class="col-12 col-md-4 mb-4 mb-md-0">
          <strong class="mb-3">{$FOOTER_LINKS_TITLE}</strong>
          <div class="d-flex flex-column">
            {foreach from=$FOOTER_NAVIGATION key=name item=item}
                {if isset($item.items)}
                    <div class="ui dropdown item">
                        <span class="text">{$item.icon} {$item.title} <i class="dropdown icon"></i></span>
                        <div class="menu">
                            <div class="header">{$item.title}</div>
                            {foreach from=$item.items item=dropdown}
                                <a class="item" href="{$dropdown.link}" target="{$dropdown.target}">{$dropdown.icon} {$dropdown.title}</a>
                            {/foreach}
                        </div>
                    </div>
                {else}
                    <a href="{$item.link}" target="{$item.target}" class="text-white-50 text-decoration-none p-1">{$item.icon} {$item.title}</a>
                {/if}
            {/foreach}
            
            <a class="text-white-50 text-decoration-none p-1" href="{$TERMS_LINK}">{$TERMS_TEXT}</a>
            <a class="text-white-50 text-decoration-none p-1" href="{$PRIVACY_LINK}">{$PRIVACY_TEXT}</a>
          </div>
        </div>
        {if $SOCIAL_MEDIA_ICONS|count > 0}
            <div class="col-12 col-md-4 mb-4 mb-md-0">
                <strong class="mb-3">{$FOOTER_SOCIAL_TITLE}</strong>
                <div class="d-flex flex-row">
                    {foreach from=$SOCIAL_MEDIA_ICONS item=icon}
                        <a href="{$icon.link}" class="text-white text-decoration-none p-1">
                            <i class="{$icon.icon} fab fs-3" data-bs-toggle="tooltip" title="{$icon.text}"></i>
                        </a>
                    {/foreach}
                </div>
            </div>
        {/if}        
      </div>
    </div>
  </div>
</div>
</div>
<div class="toast-container position-fixed bottom-0 start-0 p-3" id="app-toast-container"></div>

{if isset($GLOBAL_WARNING_TITLE)}
<div class="ui medium modal" id="modal-acknowledge">
    <div class="header">
        {$GLOBAL_WARNING_TITLE}
    </div>
    <div class="content">
        {$GLOBAL_WARNING_REASON}
    </div>
    <div class="actions">
        <a class="ui positive button" href="{$GLOBAL_WARNING_ACKNOWLEDGE_LINK}">{$GLOBAL_WARNING_ACKNOWLEDGE}</a>
    </div>
</div>
{/if}

{foreach from=$TEMPLATE_JS item=script}
    {$script}
{/foreach}
{block name=beforeJS}{/block}
{if isset($GLOBAL_WARNING_TITLE)}
<script type="text/javascript">
    $('#modal-acknowledge').modal({ closable: false }).modal('show');
</script>
{/if}

<script type="text/javascript">
    function statusDarkMode() {
        let defaultStatus = "{if $MZ_THEME.darkmode == 1}dark{else}light{/if}";

        if (window.localStorage.getItem('mz-theme') != 'dark' || window.localStorage.getItem('mz-theme') != 'light') {
            return defaultStatus;
        } else if (window.localStorage.getItem('mz-theme') == 'dark') {
            return 'dark';
        } else {
            return 'light'
        }
    }

    function toggleDarkLightMode() {
        $.post("{$DARK_LIGHT_MODE_ACTION}", { token: "{$DARK_LIGHT_MODE_TOKEN}" })
            .done(function (e) {
                var newStatus = (statusDarkMode() == 'light' ? 'dark' : 'light');

                document.body.dataset.bsTheme = newStatus;
                window.localStorage.setItem('mz-theme', newStatus);
            });

        return false;
    }

    {if isset($AUTO_LANGUAGE)}
        const autoLanguage = document.getElementById('auto-language');
        const autoLanguageValue = $.cookie('auto_language') ?? 'true';
        autoLanguage.innerText = '{$AUTO_LANGUAGE_TEXT} (' + (autoLanguageValue === 'true' ? '{$ENABLED}' : '{$DISABLED}') + ')';
        {if isset($AUTO_LANGUAGE_VALUE)}
            if (autoLanguageValue) {
                autoLanguage.title = '{$AUTO_LANGUAGE_VALUE}';
            }
        {/if}

        function toggleAutoLanguage() {
            $.cookie(
                'auto_language',
                autoLanguageValue === 'true' ? 'false' : 'true',
                { path: '/' }
            );
            window.location.reload();
        }
    {/if}
</script>

{if isset($NEW_UPDATE) && ($NEW_UPDATE_URGENT != true)}
    <script src="{$TEMPLATE.path}/js/core/update.js"></script>
{/if}

{if !isset($EXCLUDE_END_BODY)}
    {if isset($DEBUGBAR_HTML)}
    {$DEBUGBAR_HTML}
{/if}
</body>

</html>
{/if}
