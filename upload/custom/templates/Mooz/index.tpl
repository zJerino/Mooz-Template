{extends file="base/empty.tpl"}

{block name=content}
{if isset($HOME_SESSION_FLASH)}
    <div class="bg-body border-3 border-start border-success d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
        <div class="text-success text-center rounded-3 fv-small fw-bold me-3">
            <i class="bi bi-check-circle-fill fs-2"></i>
        </div>
        <div class="text-body-secondary">
            <strong class="text-success me-2">{$SUCCESS_TITLE}</strong>
            {$HOME_SESSION_FLASH}
        </div>
    </div>
{/if}

{if isset($HOME_SESSION_ERROR_FLASH)}
    <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
        <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
            <i class="bi bi-x-circle-fill fs-2"></i>
        </div>
        <div class="text-body-secondary">
            <strong class="text-danger me-2">{$ERROR_TITLE}</strong>
            {$HOME_SESSION_ERROR_FLASH}
        </div>
    </div>
{/if}

<div id="news-container">
    <div class="row justify-content-center">
        <div class="col-12 col-md-8">
            {foreach from=$NEWS item=item}
                <div class="d-flex flex-column mb-3">
                    <div class="text-bg-primary rounded-4 p-3 d-flex mb-1 align-items-center">
                        {if isset($item.label)}{$item.label}{/if} <a href="{$item.url}" class="{if isset($item.label)}ms-2{/if} text-reset fw-bold text-decoration-none">{$item.title}</a>
                    </div>
                    <div class="d-flex flex-column bg-body shadow-sm rounded-4">
                        <div class="p-3">{$item.content}</div>

                        <div class="bg-body-tertiary rounded-bottom-4 d-flex p-2 px-3">
                            <div class="d-flex align-items-center">
                                <img class="rounded-circle me-2" src="{$item.author_avatar}" alt="{$item.author_name}" style="width: 1.5rem; height: 1.5rem; object-fill: fit">
                                <a style="text-decoration: none; {$item.author_style}" href="{$item.author_url}" data-poload="{$USER_INFO_URL}{$item.author_id}">{$item.author_name}</a>
                            </div>
                            <a class="btn btn-primary btn-sm ms-auto" href="{$item.url}">
                                {$READ_FULL_POST}
                            </a>
                        </div>
                    </div>
                </div>
            {foreachelse}
                <div class="align-items-center bg-body border-3 border-start border-warning d-flex flex-row mb-3 px-3 py-2 rounded-3 shadow-sm" id="status-message">
                    <div class="fv-small fw-bold me-3 rounded-3 text-center text-warning-emphasis">
                        <i class="bi bi-exclamation-circle-fill fs-2"></i>
                    </div>
                    <div class="text-body-secondary">
                        {$NO_NEWS}
                    </div>
                </div>
            {/foreach}
        </div>
        {if count($WIDGETS_RIGHT)}
            <div class="col-12 col-md-4">
                {foreach from=$WIDGETS_RIGHT item=widget}
                    {$widget}
                {/foreach}
            </div>
        {/if}
    </div>
</div>
<div class="ui stackable grid d-none">
    <div class="ui centered row">
        {if count($WIDGETS_LEFT)}
        <div class="ui six wide tablet four wide computer column">
            {foreach from=$WIDGETS_LEFT item=widget}
            {$widget}
            {/foreach}
        </div>
        {/if}
        <div
            class="ui {if count($WIDGETS_LEFT) && count($WIDGETS_RIGHT) }four wide tablet eight wide computer{elseif count($WIDGETS_LEFT) || count($WIDGETS_RIGHT)}ten wide tablet twelve wide computer{else}sixteen wide{/if} column">
            {if $HOME_TYPE === 'news'}
            {foreach from=$NEWS item=item}
            <div class="ui fluid card" id="news-post">
                <div class="content">
                    <div class="header">
                        {if isset($item.label)}{$item.label}{/if}
                        <a href="{$item.url}" data-toggle="popup">{$item.title}</a>
                        <div class="ui popup wide transition hidden">
                            <h4 class="ui header">{$item.title}</h4>
                            {$BY|capitalize} <a style="{$item.author_style}"
                                href="{$item.author_url}">{$item.author_name}</a> |
                            {$item.date}
                        </div>
                    </div>
                    <div class="meta" data-toggle="tooltip" data-content="{$item.date}">
                        {$item.time_ago}
                    </div>
                    <div class="description forum_post">
                        {$item.content}
                    </div>
                </div>
                <div class="extra content">
                    <div class="right floated author">
                        <img class="ui avatar image" src="{$item.author_avatar}" alt="{$item.author_name}"> <a
                            style="{$item.author_style}" href="{$item.author_url}"
                            data-poload="{$USER_INFO_URL}{$item.author_id}">{$item.author_name}</a>
                    </div>
                    <a class="ui mini primary button" href="{$item.url}">
                        {$READ_FULL_POST}
                    </a>
                </div>
            </div>
            {foreachelse}
            <div class="ui segment red">
                
            </div>
            {/foreach}
            {elseif $HOME_TYPE === 'custom'}
            {$CUSTOM_HOME_CONTENT}
            {/if}
        </div>
        {if count($WIDGETS_RIGHT)}
        <div class="ui six wide tablet four wide computer column">
            {foreach from=$WIDGETS_RIGHT item=widget}
            {$widget}
            {/foreach}
        </div>
        {/if}
    </div>
</div>

{/block}