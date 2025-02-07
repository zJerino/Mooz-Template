{extends file="base/empty.tpl"}

{block name=content}
    <div class="row justify-content-center">
        <div class="col-12 col-md-8">
            {if isset($ERROR) && !empty($ERROR)}
                <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
                    <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                        <i class="bi bi-x-circle-fill fs-2"></i>
                    </div>
                    <div class="text-body-secondary">
                        <strong class="text-danger">{$ERROR_TITLE}</strong> {$ERROR}
                    </div>
                </div>
            {/if}

            <div class="bg-body shadow-sm rounded-3 py-3 d-flex flex-column mb-3">                
                <div class="mx-3 mb-3 d-flex">
                    <h5>{$TWO_FACTOR_AUTH}</h5>
                </div>

                <form class="mx-3" action="" method="post" id="form-tfa">
                    <div class="mb-3">
                        <label for="inputEmail" class="form-label">{$TFA_ENTER_CODE}</label>
                        <input type="text" name="tfa_code" class="form-control">
                    </div>
                    <input type="hidden" name="tfa" value="true">
                    <input type="hidden" name="token" value="{$TOKEN}">
                    <input type="submit" class="btn btn-primary rounded-5 w-100" value="{$SUBMIT}">
                </form>
            </div>
        </div>
    </div>
{/block}
