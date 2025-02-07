{extends file="base/user.tpl"}

{block name=content}
    {if isset($ERROR)}
        <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-x-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                <strong class="text-danger">{$ERROR_TITLE}</strong> {$ERROR}
            </div>
        </div>
    {/if}
    {if isset($ERRORS)}
        <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-x-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                <ul class="list">
                    {foreach from=$ERRORS item=error}
                    <li>{$error}</li>
                    {/foreach}
                </ul>
            </div>
        </div>
    {/if}

    <div class="bg-body shadow-sm rounded-3 py-3 d-flex flex-column mb-3">                
        <div class="mx-3 mb-3 d-flex align-items-center">
            <h5 class="me-auto">{$TWO_FACTOR_AUTH}</h5>
        </div>

        {if isset($TFA_SCAN_CODE_TEXT)}
            <div class="d-flex mx-3 mb-1">
                <p class="text-body-secondary">{$TFA_SCAN_CODE_TEXT}</p>
            </div>

            <div class="mx-auto d-flex">
                <img src="{$IMG_SRC}" style="width: 10rem; width: 10rem">
            </div>

            <div class="bg-body shadow-sm rounded-3 p-3 border-3 border-info border-start text-body-secondary mb-2 mx-3 mb-3">
                {$TFA_CODE_TEXT} <strong class="text-body">{$TFA_CODE}</strong>
            </div>
            
            <form class="mx-3" action="{$CANCEL_LINK}" method="post">
                <input type="hidden" name="token" value="{$TOKEN}">
                <div class="d-flex mx-auto mx-md-0 flex-column flex-md-row">
                    <a class="btn btn-primary rounded-5" href="{$LINK}">{$NEXT}</a>                
                    <input type="submit" value="{$CANCEL}" class="btn btn-danger rounded-5 ms-0 ms-md-2 mt-2 mt-md-0">
                </div>
            </form>
        {else}
            <form class="mx-3" action="" method="post" id="form-tfa-code">
                <div class="mb-3">
                    <label for="tfa-code" class="form-label">{$TFA_ENTER_CODE}</label>
                    <input type="text" name="tfa_code" id="tfa-code" class="form-control">
                </div>

                <input type="hidden" name="token" value="{$TOKEN}">

                <div class="d-flex mx-auto mx-md-0 flex-column flex-md-row">
                    <input type="submit" class="btn btn-primary rounded-5" value="{$SUBMIT}">
                    <button class="btn btn-danger rounded-5 ms-0 ms-md-2 mt-2 mt-md-0" type="botton" onclick="$('#form-cancel').submit();">{$CANCEL}</button>
                </div>
            </form>
            <form action="{$CANCEL_LINK}" method="post" id="form-cancel">
                <input type="hidden" name="token" value="{$TOKEN}">
            </form>
        {/if}

    </div>
{/block}