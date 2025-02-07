{extends file="base/user.tpl"}

{block name=content}
    <div class="bg-body shadow-sm rounded-3 py-3 d-flex flex-column mb-3">                
        <h5 class="mx-3">{$OVERVIEW}</h5>
        
        <ul class="list-group list-group-flush">
            {nocache}
                {foreach from=$USER_DETAILS_VALUES key=name item=value}
                    <li class="list-group-item">
                        <div class="d-flex flex-column">
                            <strong class="header">{$name}</strong>
                            <div class="text-body-secondary ms-1">{$value}</div>
                        </div>
                    </li>
                {/foreach}
            {/nocache}
        </ul>


        {if isset($FORUM_GRAPH)}
            <div class="mt-3">
                <h5 class="mx-3">{$FORUM_GRAPH}</h5>
                <div id="chartWrapper" class="mx-3">
                    <canvas id="dataChart" width="100%" height="40"></canvas>
                </div>
            </div>
        {/if}
    </div>
{/block}