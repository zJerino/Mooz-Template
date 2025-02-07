{extends file="base/user.tpl"}

{block name=content}
    {if isset($SUCCESS)}
        <div class="bg-body border-3 border-start border-success d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-success text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-check-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                <strong class="header">{$SUCCESS_TITLE}</strong> {$SUCCESS}
            </div>
        </div>
    {/if}

    {if isset($ERRORS)}
        <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-x-circle-fill fs-2"></i>
            </div>
            <ul class="list">
                {foreach from=$ERRORS item=error}
                    <li>{$error}</li>
                {/foreach}
            </ul>
        </div>
    {/if}

    <div class="bg-body shadow-sm rounded-3 py-3 d-flex flex-column mb-3">                
        <div class="mx-3 d-flex">
            <h5>{$CONNECTIONS}</h5>
        </div>
        <div class="row mx-3">
            {foreach from=$INTEGRATIONS item=integration}
                <div class="col-12 col-md-6">
                    <div class="bg-body shadow-sm rounded-3 d-flex flex-column">
                        <div class="d-flex flex-column">
                            <div class="d-flex p-2">
                                <strong class="me-2">{$integration.name}</strong>

                                {if $integration.connected && !$integration.verified}
                                    <div class="badge text-bg-warning">{$PENDING_VERIFICATION}</div>
                                    {if $integration.required}
                                        {* <div class="text-danger">{$REQUIRED}</div> *}
                                    {/if}
                                {else if !$integration.connected && $integration.required}
                                    <div class="badge text-bg-danger">{$REQUIRED}</div>
                                {/if}
                            </div>
                            
                            <div class="text-body-secondary p-2">
                                {if $integration.connected}
                                    {$integration.username}
                                {else}
                                    {$NOT_CONNECTED}
                                {/if}
                            </div>

                            {if $integration.connected}
                                <div class="d-flex flex-column w-100">
                                    {if $integration.connected && !$integration.verified}
                                        <form class="d-flex flex-column" action="" method="post">
                                            <input type="hidden" name="token" value="{$TOKEN}">
                                            <input type="hidden" name="action" value="verify">
                                            <input type="hidden" name="integration" value="{$integration.name}">
                                            <input type="submit" class="btn btn-warning m-1" value="{$VERIFY}">
                                        </form>
                                    {/if}

                                    {if $integration.can_unlink}
                                        <form class="d-flex flex-column" action="" method="post">
                                            <input type="hidden" name="token" value="{$TOKEN}">
                                            <input type="hidden" name="action" value="unlink">
                                            <input type="hidden" name="integration" value="{$integration.name}">
                                            <input type="submit" class="btn btn-danger m-1" value="{$UNLINK}">
                                        </form>
                                    {/if}
                                </div>
                            {else}
                                <form class="d-flex flex-column" action="" method="post">
                                    <input type="hidden" name="token" value="{$TOKEN}">
                                    <input type="hidden" name="action" value="link">
                                    <input type="hidden" name="integration" value="{$integration.name}">
                                    <input type="submit" class="btn btn-success m-1" value="{$CONNECT}">
                                </form>
                            {/if}
                        </div>
                    </div>
                </div>
            {/foreach}
        </div>
    </div>
{/block}
