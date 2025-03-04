{include file='header.tpl'}
<div id="app-content" class="mz-portal py-0 d-flex" style="background-color: var(--bs-secondary-bg);background-image: linear-gradient(to top, var(--bs-secondary-bg), transparent), url('{$BANNER_IMAGE}');">
    <div class="d-flex flex-column w-100">
        <div class="d-flex d-md-none align-items-center bg-body bg-opacity-50 flex-row px-5 py-1">
            <a href="{$SITE_HOME}" class="fw-bold text-body text-decoration-none">{$SITE_NAME}</a>
            <div class="ms-auto p-2" data-bs-toggle="offcanvas" href="#offcanvasNav" role="button" aria-controls="offcanvasNav">
                <i class="bi bi-list fs-5"></i>
            </div>
        </div>
        <div class="d-none d-md-flex align-items-center bg-body bg-opacity-50 flex-row mx-auto pe-5 py-1 rounded-bottom-5" style="padding-left: 3rem">
            {assign var="centerLink" value=(((count($NAV_LINKS) - 1) / 2) + 1)}

            {foreach from=$NAV_LINKS item=item key=key name=name}
                {if isset($item.items)}
                    <a href="#" class="cursor-pointer p-2 text-body text-decoration-none YURFseY6" data-bs-title="{$item.title}" data-body-class="p-0 FSedGGY3" data-element="#popover-navbar-{$key}" data-bs-toggle="popover" data-bs-trigger="focus" tabindex="0" data-bs-html="true" style="order: {if $item@iteration >= $centerLink}{$item@iteration + 1}{else}{$item@iteration + 1}{/if}">{$item.title} <i class="bi bi-chevron-down ms-2"></i></a>
                    <div class="d-none">
                        <div id="popover-navbar-{$key}" class="d-flex flex-column">
                            <div class="list-group list-group-flush mb-2">
                                {foreach from=$item.items item=dropdown}
                                    <a class="list-group-item list-group-item-action" href="{$dropdown.link}" target="{$dropdown.target}">{$dropdown.icon} {$dropdown.title}</a>
                                {/foreach}
                            </div>
                        </div>
                    </div>
                {else}
                    {if ($key == $PORTAL_ITEM || $PORTAL_ITEM == null && (($item@total / 2) + 0.5 == $item@iteration))}
                        <a href="{$item.link}" class="btn btn-primary bg-opacity-100 rounded-5 px-4 mx-2" id="btn-center-nav" style="order: {$centerLink}">{if empty($item.icon)} <i class="bi bi-star"></i> {else} {$item.icon} {/if} {$item.title}</a>
                    {else}
                        <a href="{$item.link}" class="p-2 text-body text-decoration-none YURFseY6" style="order: {if $item@iteration >= $centerLink}{$item@iteration + 1}{else}{$item@iteration + 1}{/if}">{$item.title}</a>
                    {/if}
                {/if}
            {/foreach}
        </div>
        <div class="container my-auto">
            <div class="d-flex flex-column w-100">
            
                <div class="mt-5 mx-auto d-flex flex-column align-items-center">
                    <img src="{if (isset($LOGO_IMAGE))}{$LOGO_IMAGE}{else}https://namelessmc.com/uploads/avatars/defaults/15a1d8fbaef6dd_olqikfemgjnhp.png{/if}" style="transform: scale(1.1);width: 10rem;height: 10rem" class="mb-4 mx-auto position-relative logo-pulse">
                    <div class="display-1 fw-bold"> {$SITE_NAME} </div>
                    <div class="text-body-secondary px-3 text-center">{$CONTENT_PORTAL}</div>
                </div>
                {if isset($MINECRAFT) && isset($SERVER_QUERY)}
                    <div class="mx-auto my-2">
                        <div class="rounded-3 bg-body bg-opacity-50 py-2 px-3 d-flex align-items-center" onclick="copy('#default-server-ip')" data-bs-toggle="tooltip" title="{$CLICK_TO_COPY_TOOLTIP}">
                            <i class="bi bi-play-circle-fill fs-3 me-3"></i>
                            <div class="d-flex flex-column">
                                <strong id="default-server-ip">{$DEFAULT_IP}</strong>
                                <small class="text-body-secondary mb-0">
                                    {$SERVER_QUERY.status_full}
                                </small>
                            </div>
                        </div>
                    </div>
                {/if}
            </div>
        </div>
    </div>
</div>


<div class="offcanvas offcanvas-start" tabindex="-1" id="offcanvasNav" aria-labelledby="offcanvasNavLabel">
  <div class="offcanvas-header">
    <h5 class="offcanvas-title" data-href="{$SITE_HOME}" id="offcanvasNavLabel">{$SITE_NAME}</h5>
    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body px-0">
    <div class="list-group list-group-flush">
        {foreach from=$NAV_LINKS key=name item=item}
            {if isset($item.items)}
                <a href="{$item.link}" target="{$item.target}" class="list-group-item list-group-item-action d-flex {if isset($item.active)}active{/if}" data-bs-toggle="collapse" data-bs-target="#navOCCollapse-{$name}" aria-expanded="false" aria-controls="navOCCollapse-{$name}">{$item.icon} {$item.title} <div class="ms-auto"><i class="bi bi-chevron-down"></i></div></a>
                <div class="collapse" id="navOCCollapse-{$name}">
                    <div class="list-group list-group-flush">
                        {foreach from=$item.items item=dropdown}
                            <a class="list-group-item list-group-item-action ps-4" href="{$dropdown.link}" target="{$dropdown.target}">{$dropdown.icon} {$dropdown.title}</a>
                        {/foreach}
                    </div>
                </div>
            {else}
                <a href="{$item.link}" target="{$item.target}" class="list-group-item list-group-item-action {if isset($item.active) || $name == 'index'}active{/if}">{$item.icon} {$item.title}</a>                
            {/if}
        {/foreach}
    </div>
  </div>
</div>

<div class="toast-container position-fixed bottom-0 start-0 p-3" id="app-toast-container"></div>

{foreach from=$TEMPLATE_JS item=script}
{$script}
{/foreach}
</div>
</body>
</html>