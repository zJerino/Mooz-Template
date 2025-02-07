{extends file="base/user.tpl"}

{block name=content}
    {if isset($ERROR)}
        <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-x-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary"> {$ERROR} </div>
        </div>
    {/if}
    <div class="bg-body shadow-sm rounded-3 py-3 d-flex flex-column mb-3">                
        <div class="mx-3 d-flex">
            <h5>{$ALERTS}</h5>
            <button class="ms-auto btn btn-danger rounded-3" onclick="$('#form-delete-all').submit();">{$DELETE_ALL}</button>
        </div>
        
        {nocache}
            {if count($ALERTS_LIST)}
                <div class="list-group list-group-flush">
                    {foreach from=$ALERTS_LIST key=name item=alert}
                        <a class="list-group-item list-group-item-action" href="{$alert->view_link}"  data-bs-toggle="tooltip" title="{$alert->date}">
                            <div class="d-flex flex-column">
                                {if $alert->read eq 0}
                                    <strong>{$alert->content}</strong>
                                {else}
                                    <strong class="text-body-secondary">{$alert->content}</strong>
                                {/if}
                                <div class="text-body-secondary">{$alert->date_nice}</div>
                            </div>
                        </a>
                    {/foreach}
                </div>
            {else}
                <div class="bg-body border-3 border-start border-info d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
                    <div class="text-info text-center rounded-3 fv-small fw-bold me-3">
                        <i class="bi bi-exclamation-circle-fill fs-2"></i>
                    </div>
                    <div class="text-body-secondary">
                        {$NO_ALERTS}
                    </div>
                </div>
            {/if}
        {/nocache}
    </div>


    {if count($ALERTS_LIST)}
        <form action="{$DELETE_ALL_LINK}" method="post" class="d-none" id="form-delete-all">
            <input type="hidden" name="token" value="{$TOKEN}">
        </form>
    {/if}
{/block}
