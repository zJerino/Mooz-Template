<div id="app-header" class="position-relative" {if isset($BANNER_IMAGE)} style="background-image:url('{$BANNER_IMAGE}')" {/if}>
    <nav id="app-header-userbar" class="overflow-auto">
      <div class="container d-flex flex-row align-items-center">
        <a class="d-inline-block p-2 px-3 text-light" type="button" onclick="toggleDarkLightMode()"><i class="bi bi-palette2"></i></a>      
        {foreach from=$USER_SECTION key=name item=item}
            {if isset($item.items)}

                <div class="z-1{if ($name == 'alerts')} me-auto{/if}">
                    {if $name == 'account'}
                        <a data-bs-title="{$item.title}" data-body-class="p-0" data-element="#popover-user" data-bs-toggle="popover" data-bs-trigger="focus" tabindex="0" data-bs-html="true" class="d-inline-block p-2 px-3 text-light ASdDWYf text-decoration-none" type="button">{$item.icon} <span>{$item.title}</span></a>
                    {else}
                        <a class="d-inline-block p-2 px-3 text-light dropdown-toggle" type="button" data-bs-toggle="modal" data-bs-target="#modal-user-list-{$name}" data-user-item="{$name}">{$item.icon}</a>
                    {/if}
                </div>
            {else}
                {if ($name == "panel")}
                    <a class="d-inline-block p-2 text-light ms-auto" href="{$item.link}" target="{$item.target}">{$item.icon}</a>
                {else}
                    <a class="align-items-center {if ($name == "login")} ms-auto {/if}d-inline-block p-2 text-decoration-none text-light" href="{$item.link}" target="{$item.target}">
                        <span class="fw-bold" style="line-height: 0;">{$item.title}</span>
                    </a>
                {/if}
            {/if}
        {/foreach}
      </div>
    </nav>
    <nav id="app-header-navbar" class="navbar text-light">
      <div class="container" style="align-items: normal;">
        <a class="text-light navbar-brand" href="{$SITE_HOME}">
          <img id="app-navbar-logo" src="https://cuberico.cloud/assets/latin-foro/2020/logo.png" />
          <strong>{$SITE_NAME}</strong>
        </a>
        
        <div id="app-navbar-slider" class="align-items-stretch d-none flex-nowrap m-0 d-sm-flex">
          <div id="app-ns-container">
            <ul id="app-ns-items" class="list-unstyled m-0">
                {foreach from=$NAV_LINKS key=name item=item}
                    {if isset($item.items)}
                        <div class="item">
                            <div class="header">{$item.title} <span class="icon">{$item.icon}</span></div>
                            <div class="menu">
                                {foreach from=$item.items item=dropdown}
                                    <a class="item" href="{$dropdown.link}" target="{$dropdown.target}">{$dropdown.icon} {$dropdown.title}</a>
                                {/foreach}
                            </div>
                        </div>
                    {else}
                        <li {if isset($item.active)}class="active"{/if}>
                            <a href="{$item.link}" target="{$item.target}">{$item.icon} {$item.title}</a>
                        </li>
                    {/if}
                {/foreach}
            </ul>
          </div>
        </div>
        
        <button class="bg-transparent border-0 h-100 m-0 my-auto navbtn rounded-3 d-flex d-sm-none">
          <i class="fa fa-bars"></i>
        </button>
      </div>
    </nav>

    <div id="app-header-info" class="d-flex justify-content-center align-items-center">
      <a href="{$SITE_HOME}"><img id="app-header-logo" src="https://cuberico.cloud/assets/latin-foro/2020/logo.png" /></a>
    </div>
</div>


{foreach from=$USER_SECTION key=name item=item}
    {if isset($item.items)}
        {if $name != 'account'}
            <!-- Modal -->
            <div class="modal fade" id="modal-user-list-{$name}" tabindex="-1" aria-labelledby="modal-user-list-{$name}Label" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-body px-0 py-2">
                            <div class="d-flex flex-column">
                                <h1 class="modal-title fs-5 mx-auto mb-3 d-flex align-items-center" id="modal-user-list-{$name}Label">
                                    <i class="mx-1 text-primary">&bull;</i>
                                    {$item.title}
                                    <i class="mx-1 text-primary">&bull;</i>                                    
                                </h1>
                            
                                <div class="list-group list-group-flush mb-3" id="list-{$name}">
                                    {foreach from=$item.items item=dropdown}
                                        {if !isset($dropdown.separator)}
                                            {if isset($dropdown.action)}
                                                <a href="#" data-link="{$dropdown.link}" data-action="{$dropdown.action}" class="list-group-item list-group-item-action">{$dropdown.icon} {$dropdown.title}</a>
                                            {else}
                                                <a href="{$dropdown.link}" target="{$dropdown.target}" class="list-group-item list-group-item-action">{$dropdown.icon} {$dropdown.title}</a>
                                            {/if}
                                        {/if}
                                    {/foreach}
                                </div>

                                {if !empty($item.meta)}
                                    <a href="{$item.link}" class="btn btn-dark dark-border rounded-5 px-5 mx-auto">{$item.meta}</a>                                
                                {/if}
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        {else}
            <div class="d-none">
                <div id="popover-user">
                    <div class="list-group list-group-flush mb-2">
                        {foreach from=$item.items item=dropdown}
                            {if isset($dropdown.separator)}
                            {else}
                                {if isset($dropdown.action)}
                                    <a class="list-group-item list-group-item-action" href="#" data-link="{$dropdown.link}" data-action="{$dropdown.action}">{$dropdown.icon} {$dropdown.title}</a>
                                {else}
                                    <a class="list-group-item list-group-item-action" href="{$dropdown.link}" target="{$dropdown.target}">{$dropdown.icon} {$dropdown.title}</a>
                                {/if}
                            {/if}
                        {/foreach}
                        {if !empty($item.meta)}
                            <a class="list-group-item list-group-item-action" href="{$item.link}">{$item.meta}</a>
                        {/if}
                    </div>
                </div>
            </div>
        {/if}
    {/if}
{/foreach}    
<div id="app-content">
{if (isset($LOGGED_IN_USER) && $LOGGED_IN_USER.username == 'zJerino')}
    {debug}
{/if}
<div class="container">
    <div id="ie-message">
        <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2">
            <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-exclamation-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                <strong class="text-danger me-2">{$INTERNET_EXPLORER_HEADER}</strong>
                {$INTERNET_EXPLORER_INFO}
            </div>
        </div>
    </div>
    {if isset($NEW_UPDATE)}
        <div class="bg-body border-3 border-start border-{if $NEW_UPDATE_URGENT eq true}danger{else}info{/if} d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="update-message">
            <div class="text-{if $NEW_UPDATE_URGENT eq true}danger{else}info{/if} text-center rounded-3 fv-small fw-bold me-3">
                {if $NEW_UPDATE_URGENT eq true}
                    <i class="bi bi-exclamation fs-2"></i>
                {else}
                    <i class="bi bi-exclamation-circle-fill fs-2"></i>
                {/if}
            </div>
            <div class="text-body-secondary d-flex flex-column">
                <strong class="text-{if $NEW_UPDATE_URGENT eq true}danger{else}info{/if} me-2">{$NEW_UPDATE}</strong>
                <div class="d-flex">
                    <span>{$CURRENT_VERSION}</span> > <span>{$NEW_VERSION}</span>
                </div>
                <a href="{$NAMELESS_UPDATE_LINK}" class="btn btn-primary rounded-5">
                    <i class="bi bi-arrow-down"></i>
                </a>
            </div>
        </div>
    {/if}
    {if isset($MUST_VALIDATE_ACCOUNT)}
        <div class="bg-body border-3 border-start border-info d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="ie-message">
            <div class="text-info text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-exclamation-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                {$MUST_VALIDATE_ACCOUNT}
            </div>
        </div>
    {/if}

    {if isset($MAINTENANCE_ENABLED)}
        <div class="bg-body border-3 border-start border-warning d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="ie-message">
            <div class="text-warning text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-exclamation-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                {$MAINTENANCE_ENABLED}
            </div>
        </div>
    {/if}
</div>

{* <div class="pusher">
    <div id="wrapper">
        <div class="ui masthead d-none">
            <div class="ui container">
                <div class="ui stackable grid">
                    <div class="ui middle aligned row">
                        <div class="eight wide column">
                            <h1>{$SITE_NAME}</h1>
                        </div>
                        <div class="eight wide column">
                            {if isset($MINECRAFT) && isset($SERVER_QUERY)}
                            <div class="connect-server">
                                {if isset($SERVER_QUERY.status_value) && ($SERVER_QUERY.status_value == 1)}
                                {if isset($SERVER_QUERY.status_full)}
                                <h4 class="ui header">{$SERVER_QUERY.status_full}</h4>
                                {else}
                                <h4 class="ui header">{$SERVER_QUERY.x_players_online}</h4>
                                {/if}
                                {else}
                                <h4 class="ui header">{$SERVER_OFFLINE}</h4>
                                {/if}
                                {if isset($CLICK_TO_COPY_TOOLTIP)}
                                <h4 class="ui header">
                                    <span onclick="copy('#ip')" data-tooltip="{$CLICK_TO_COPY_TOOLTIP}"
                                        data-variation="mini" data-inverted=""
                                        data-position="bottom center">{$CONNECT_WITH}</span>
                                </h4>
                                {/if}
                            </div>
                            {/if}
                        </div>
                    </div>
                </div>
            </div>
        </div>

        {if !empty($ANNOUNCEMENTS)}
                {foreach from=$ANNOUNCEMENTS item=$ANNOUNCEMENT}
                <div class="ui {if $ANNOUNCEMENT->icon} icon {/if} message announcement"
                    id="announcement-{$ANNOUNCEMENT->id}"
                    style="background-color:{$ANNOUNCEMENT->background_colour}; color:{$ANNOUNCEMENT->text_colour}">
                    {if $ANNOUNCEMENT->closable}
                    <i class="close icon"></i>
                    {/if}
                    {if $ANNOUNCEMENT->icon}
                    <i class="{$ANNOUNCEMENT->icon} icon"></i>
                    {/if}
                    <div class="content">
                        <div class="header">{$ANNOUNCEMENT->header}</div>
                        <p>{$ANNOUNCEMENT->message|escape}</p>
                    </div>
                </div>
                {/foreach}
        {/if}
 *}
