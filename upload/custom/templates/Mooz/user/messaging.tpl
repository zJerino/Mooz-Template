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
            <h5>{$MESSAGING}</h5>
            <a class="ms-auto btn btn-dark dark-border rounded-3" href="{$NEW_MESSAGE_LINK}">{$NEW_MESSAGE}</a>
        </div>
        
        {nocache}
            {if count($MESSAGES)}
                <div class="list-group list-group-flush">
                    <a class="list-group-item">
                        <div class="row">
                            <div class="col-6">
                                <strong>{$MESSAGE_TITLE}</strong>
                            </div>
                            <div class="col-6">
                                <strong>{$LAST_MESSAGE}</strong>
                            </div>
                        </div>
                    </a>

                    {foreach from=$MESSAGES key=name item=msg}
                        <li class="list-group-item list-group-item-action" data-href="{$msg.link}">
                            <div class="row">
                                <div class="col-6">
                                    <div class="d-flex flex-column">
                                        <strong>{$msg.title}</strong>
                                        <small class="text-body-secondary">{$msg.participants}</small>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="d-flex align-items-center">
                                        <img src="{$msg.last_message_user_avatar}" class="rounded-circle me-2" style="width: 2rem; height: 2rem">
                                        <div class="d-flex flex-column">
                                            <strong data-href="{$msg.last_message_user_profile}" style="{$msg.last_message_user_style}">{$msg.last_message_user}</strong>
                                            <small class="text-body-secondary" data-bs-toggle="tooltip" title="{$msg.last_message_date_full}">{$msg.last_message_date}</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    {/foreach}
                </div>
            {else}
                <div class="bg-body border-3 border-start border-info d-flex flex-row mx-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
                    <div class="text-info text-center rounded-3 fv-small fw-bold me-3">
                        <i class="bi bi-exclamation-circle-fill fs-2"></i>
                    </div>
                    <div class="text-body-secondary">
                        {$NO_MESSAGES}
                    </div>
                </div>
            {/if}
        {/nocache}
    </div>
{/block}