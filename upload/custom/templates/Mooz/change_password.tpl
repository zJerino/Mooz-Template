{extends file="base/empty.tpl"}

{block name=content}
<div class="row justify-content-center">
        <div class="col-12 col-md-7">
          {if isset($ERROR)}
              <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2 mb-2" id="status-message">
                  <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                      <i class="bi bi-x-circle-fill fs-2"></i>
                  </div>
                  <div class="text-body-secondary">
                      <strong class="text-danger me-2">{$ERROR_TITLE}</strong>
                      <ul class="mb-0">
                        {foreach from=$ERROR item=error}
                        <li>{$error}</li>
                        {/foreach}
                    </ul>
                  </div>
              </div>
          {/if}
          
            <div class="bg-body shadow-sm p-3 rounded-3 d-flex flex-column">
                <h4 class="d-flex flex-row mx-auto">
                    <span class="text-primary">&bull;</span>
                    <span class="mx-2">{$FORGOT_PASSWORD}</span>
                    <span class="text-primary">&bull;</span>                    
                </h4>

                <p class="text-body-secondary">
                    {$ENTER_NEW_PASSWORD}
                </p>

                <form class="d-flex flex-column" action="" method="post" id="form-forgot-password">
                    <div class="mb-3">
                        <label class="form-label" for="inputEmail">{$EMAIL_ADDRESS}</label>
                        <input class="form-control" type="email" id="inputEmail" name="email" placeholder="{$EMAIL_ADDRESS}" tabindex="1">
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="inputPassword">{$PASSWORD}</label>
                        <input class="form-control" type="password" name="password" id="inputPassword" placeholder="{$PASSWORD}" autocomplete="off" tabindex="2">
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="inputPasswordAgain">{$CONFIRM_PASSWORD}</label>
                        <input class="form-control" type="password" name="password_again" id="inputPasswordAgain" placeholder="{$CONFIRM_PASSWORD}" autocomplete="off" tabindex="3">
                    </div>
                  <div class="d-flex flex-column">
                    <input type="hidden" name="token" value="{$TOKEN}">
                    <input type="submit" class="btn btn-primary rounded-5 px-5 mx-auto" value="{$SUBMIT}" tabindex="4">
                  </div>
                </form>
            </div>
        </div>
    </div>
{/block}
