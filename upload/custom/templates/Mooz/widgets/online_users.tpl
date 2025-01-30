<div class="bg-body rounded-3 shadow-sm d-flex flex-column mb-3" id="widget-online-users">
    <div class="text-primary text-center rounded-top-3 px-3 py-2 fv-small fw-bold">
        {$ONLINE_USERS}
    </div>
    <div class="px-3 d-flex flex-row flex-wrap">
        {if isset($ONLINE_USERS_LIST)}
            {foreach from=$ONLINE_USERS_LIST name=online_users_arr item=user}
                <a class="d-inline-flex" href="{$user.profile}" style="text-decoration: none; {$user.style}" data-poload="{$USER_INFO_URL}{$user.id}">
                    <img src="{$user.avatar}" class="rounded-circle me-2" style="width: 2rem; height: 2rem" alt="{if $SHOW_NICKNAME_INSTEAD}{$user.nickname}{else}{$user.username}{/if}">{if $SHOW_NICKNAME_INSTEAD}{$user.nickname}{else}{$user.username}{/if}
                </a>
            {/foreach}
        {else}
            <span class="text-body-secondary py-2 px-3">{$NO_USERS_ONLINE}</span>
        {/if}
    </div>
    {if isset($ONLINE_USERS_LIST)}    
        <div class="bg-black-50 p-2 px-3 text-center text-body-secondary">
            {$TOTAL_ONLINE_USERS}
        </div>
    {/if}
</div>