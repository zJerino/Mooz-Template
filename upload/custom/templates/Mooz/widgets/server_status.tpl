<div class="bg-body rounded-3 shadow-sm d-flex flex-column py-2 mb-3" id="widget-latest-posts">
    <div class="text-primary text-center rounded-top-3 px-3 fv-petite fw-bold">
        {$SERVER_STATUS}
    </div>
    <div class="d-flex flex-column px-3">
        {if isset($SERVER)}
            {if $SERVER.status_value eq 1}
                <div class="d-flex flex-column flex-sm-row">
                    <span>{$ONLINE}:</span>
                    <strong class="ms-sm-auto ms-1">{$SERVER.player_count} / {$SERVER.player_count_max}</strong>
                </div>
            {/if}

            <div class="d-flex flex-column flex-sm-row">
                <span>{$IP}:</span>
                <strong class="ms-sm-auto ms-1">{$SERVER.join_at}</strong>
            </div>
            <div class="ui relaxed d-none">
                <div class="content">
                    {if $SERVER.status_value eq 1}
                    <span class="ui label large green">{$ONLINE}
                        {else}
                        <span class="ui label large red">{$OFFLINE}
                            {/if}
                            <div class="detail">{$SERVER.name}</div>
                        </span>

                        {if $SERVER.status_value eq 1}
                        <div class="ui divider"></div>
                        <p>{$ONLINE}: <strong>{$SERVER.player_count} / {$SERVER.player_count_max}</strong></p>
                        {if isset($SERVER.format_player_list) && count($SERVER.format_player_list) && ($SERVER.player_count > 0)}
                        <p>
                            {foreach from=$SERVER.format_player_list item=player}
                            <a href="{$player.profile}" data-toggle="tooltip" data-content="{$player.username}"><img
                                    class="ui avatar" src="{$player.avatar}" alt="{$player.username}" /></a>
                            {/foreach}
                        </p>
                        {/if}
                        {if isset($VERSION)}
                        <p>{$VERSION}</p>
                        {/if}
                        {/if}
                </div>
            </div>
            {else}
            {$NO_SERVERS}
            {/if}
    </div>
</div>