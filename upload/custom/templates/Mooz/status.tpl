{extends file="base/empty.tpl"}

{block name='content'}
    <div class="bg-body rounded-3 p-3 d-flex flex-column">
        <div class="d-flex align-items-center">
            <h3 class="text-primary me-2 fs-1 m-0 mb-1">&bull;</h3>
            <h4 class="m-0">{$STATUS}</h4>
        </div>



        {if count($SERVERS)}
            <div class="d-flex flex-column" id="servers">
                {foreach from=$SERVERS item=server}
                <div class="card p-2 rounded-3 d-flex flex-row align-items-center {if !($server@last)}mb-3{/if}" style="height: 100%;" id="server{$server->id|escape}"
                    data-server="{$server->id|escape}" data-bungee="{$server->bungee|escape}" data-bedrock="{$server->bedrock|escape}" data-players="{$server->player_list|escape}">

                    <div class="d-flex flex-column w-100">
                        <strong>{$server->name|escape:'html'}</strong>
                        <div class="d-flex flex-row">
                            <div class="me-auto">
                                {if $server->show_ip}
                                    <span class="text-body" data-bs-toggle="tooltip" title="{$CLICK_TO_COPY_TOOLTIP}" onclick="copy('#copy-{$server->id|escape}')">{$IP}: <span id="copy-{$server->id|escape}">{$server->query_ip|escape:'html'}{if $server->port && $server->port != 25565}:{$server->port|escape:'html'}{/if}</span></span>
                                {/if}
                            </div>
                            <div class="d-flex align-items-center">
                                <small class="text-body-secondary" id="server-counter-{$server->id|escape}"></small>

                                <small class="spinner-border spinner-border-sm spinner-grow-sm text-dark ms-2" role="status" id="status-server-spinner-{$server->id|escape}">
                                    <span class="visually-hidden">Loading...</span>
                                </small>
                            </div>
                        </div>
                        {if !$server->bedrock}
                            <div class="mt-2 d-none" id="server-players-{$server->id|escape}"></div>
                        {/if}
                    </div>
                </div>
                {/foreach}
            </div>
        {/if}
    </div>
{/block}

{if count($SERVERS)}
<div class="ui centered three stackable cards" id="servers">
    {foreach from=$SERVERS item=server}
    <div class="ui fluid card center aligned server" style="height: 100%;" id="server{$server->id|escape}"
        data-id="{$server->id|escape}" data-bungee="{$server->bungee|escape}" data-bedrock="{$server->bedrock|escape}"
        data-players="{$server->player_list|escape}">
        <div class="content">
            <div class="header">
                {if $server->show_ip}<div class="ui top right attached label" data-toggle="popup"
                    data-html="<span id='copy{$server->id|escape}'>{$server->query_ip|escape:'html'}{if $server->port && $server->port != 25565}:{$server->port|escape:'html'}{/if}</span>"
                    onclick="copy('#copy{$server->id|escape}')">{$IP}</div>{/if}
                {$server->name|escape:'html'}
            </div>
            <div class="description" id="server-status">
                <i class="notched circle loading icon"></i>
            </div>
        </div>
        {if !$server->bedrock}
        <div class="extra content" id="server-players"></div>
        {/if}
    </div>
    {/foreach}
</div>
{else}
<div class="ui error icon message">
    <i class="x icon"></i>
    <div class="content">
        <div class="header">{$ERROR_TITLE}</div>
        {$NO_SERVERS}
    </div>
</div>
{/if}

{include file='footer.tpl'}