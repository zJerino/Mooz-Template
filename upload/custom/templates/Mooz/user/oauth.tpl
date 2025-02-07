{extends file="base/user.tpl"}

{block name=content}
    {if isset($SUCCESS_MESSAGE)}
        <div class="bg-body border-3 border-start border-success d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-success text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-check-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                <strong class="text-success">{$SUCCESS}</strong> {$SUCCESS_MESSAGE}
            </div>
        </div>
    {/if}

    {if isset($ERROR_MESSAGE)}
        <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-x-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                <strong class="text-success">{$ERROR}</strong> {$ERROR_MESSAGE}
            </div>
        </div>
    {/if}

    <div class="bg-body shadow-sm rounded-3 py-3 d-flex flex-column mb-3">                
        <div class="mx-3 d-flex">
            <h5>{$OAUTH}</h5>
        </div>
        {if count($OAUTH_PROVIDERS)}
            <ul class="list-group list-group-flush ">
                {foreach $OAUTH_PROVIDERS as $provider_name => $provider_data}
                    <li class="list-group-item d-flex align-items-center">
                        {if $provider_data.icon}
                            <i class="{$provider_data.icon} fa-lg fs-3">&nbsp;</i>
                        {/if}
                        <div class="d-flex flex-column">
                            <strong>{$provider_name|ucfirst}</strong>
                            {if isset($USER_OAUTH_PROVIDERS[$provider_name])}                            
                                <small class="fv-petite">
                                    <code>{$USER_OAUTH_PROVIDERS[$provider_name]->provider_id}</code>
                                </small>
                            {/if}
                        </div>
                        <div class="ms-auto d-flex">
                            {if isset($USER_OAUTH_PROVIDERS[$provider_name])}
                                <a class="btn btn-danger btn-sm" href="#" data-bs-toggle="modal" data-bs-target="#unlink-{$provider_name}-Modal">{$UNLINK}</a>
                            {else}
                                <a class="btn btn-success btn-sm" href="#" data-bs-toggle="modal" data-bs-target="#link-{$provider_name}-Modal">{$LINK}</a>
                            {/if}
                        </div>
                    </li>
                {/foreach}
            </ul>
        {else}
            <div class="bg-body border-3 border-start border-info d-flex flex-row mx-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
                <div class="text-info text-center rounded-3 fv-small fw-bold me-3">
                    <i class="bi bi-exclamation-circle-fill fs-2"></i>
                </div>
                <div class="text-body-secondary">
                    {$NO_PROVIDERS}
                </div>
            </div>
        {/if}
    </div>

    
    <!-- Modals -->
    {foreach $OAUTH_PROVIDERS as $provider_name => $provider_data}
        <div class="modal fade" id="unlink-{$provider_name}-Modal" tabindex="-1" aria-labelledby="unlink-{$provider_name}-Label" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="unlink-{$provider_name}-Label">{$UNLINK} {$provider_name|ucfirst}</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        {$OAUTH_MESSAGES[$provider_name]['unlink_confirm']}


                        <div class="d-flex flex-column justify-content-md-start flex-md-row-reverse mt-2">
                            <button class="btn btn-success rounded-5 px-4 ms-0 ms-md-2 mb-1 mb-md-0" onclick="$('#unlink-{$provider_name}-form').submit()">{$YES}</button>
                            <button class="btn btn-danger rounded-5 px-4" data-bs-dismiss="modal">{$NO}</button>
                        </div>

                        <form class="d-none" action="" method="post" id="unlink-{$provider_name}-form">
                            <input type="hidden" name="token" value="{$TOKEN}">
                            <input type="hidden" name="action" value="unlink">
                            <input type="hidden" name="provider" value="{$provider_name}">
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="link-{$provider_name}-Modal" tabindex="-1" aria-labelledby="link-{$provider_name}-Label" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="link-{$provider_name}-Label">{$LINK} {$provider_name|ucfirst}</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        {$OAUTH_MESSAGES[$provider_name]['link_confirm']}


                        <div class="d-flex flex-column justify-content-md-start flex-md-row-reverse mt-2">
                            <a class="btn btn-success rounded-5 px-4 ms-0 ms-md-2 mb-1 mb-md-0" href="{$provider_data.url}">{$CONFIRM}</a>    
                            <button class="btn btn-danger rounded-5 px-4" data-bs-dismiss="modal">{$NO}</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    {/foreach}
{/block}