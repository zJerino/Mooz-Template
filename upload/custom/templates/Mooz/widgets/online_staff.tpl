<div class="bg-body rounded-3 shadow-sm d-flex flex-column mb-3" id="widget-online-staff">
    <div class="text-primary text-center rounded-top-3 px-3 py-2 fv-small fw-bold">
        {$ONLINE_STAFF}
    </div>
    <div class="px-3 mb-2 d-flex flex-column">
        {if isset($ONLINE_STAFF_LIST)}
            {foreach from=$ONLINE_STAFF_LIST name=online_staff_arr item=user}
                <div class="align-items-center d-flex mb-2">
                    <img class="rounded-circle me-2" src="{$user.avatar}" alt="{$user.username}" style="width: 2rem; height: 2rem; object-fit: fill">
                    <div class="d-flex flex-column">
                        <a href="{$user.profile}" data-poload="{$USER_INFO_URL}{$user.id}" style="text-decoration: none; {$user.style}">{$user.nickname}</a>
                        {$user.group}
                    </div>
                </div>
            {/foreach}
        {else}
            <span class="text-body-secondary py-2 px-3">{$NO_STAFF_ONLINE}</span>
        {/if}
    </div>
    {if isset($ONLINE_STAFF_LIST)}    
        <div class="bg-black-50 p-2 px-3 text-center text-body-secondary">
            {$TOTAL_ONLINE_STAFF}
        </div>
    {/if}
</div>