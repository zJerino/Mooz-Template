{include file='header.tpl'}
{include file='navbar.tpl'}

<div class="container">
    {if count($ERROR)}
        <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-x-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                <strong class="text-danger me-2">{$ERROR_TITLE}</strong>
                <ul class="list">
                    {foreach from=$ERROR item=error}
                        <li>{$error}</li>
                    {/foreach}
                </ul>
            </div>
        </div>
    {/if}
    <div class="row justify-content-center">
        <div class="col-12 col-md-6">
            <div class="bg-body rounded-3 shadow-sm d-flex flex-column">
                <div class="p-4 d-flex flex-column">
                    <h5 class="mb-3 mx-auto">
                        <span class="text-primary">•</span>
                        <span class="mx-1">{$SIGN_IN}</span>
                        <span class="text-primary">•</span>
                    </h5>
                    <form action="" method="post">
                        {if isset($EMAIL)}                    
                            <div class="mb-3">
                                <label for="email" class="form-label">{$EMAIL}</label>
                                <input type="email" name="email" id="email" value="{$USERNAME_INPUT}" placeholder="{$EMAIL}" tabindex="1" class="form-control">
                            </div>
                        {else}
                            <div class="mb-3">
                                <label for="email" class="form-label">{$USERNAME}</label>
                                <input type="text" name="username" id="username" value="{$USERNAME_INPUT}" placeholder="{$USERNAME}" tabindex="1" class="form-control">
                            </div>
                        {/if}
                        <div class="mb-3">
                            <label for="password" class="form-label">{$PASSWORD}</label>
                            <input type="password" name="password" id="password" placeholder="{$PASSWORD}" tabindex="2" class="form-control"  aria-describedby="passwordHelpBlock">
                            <small id="passwordHelpBlock" class="form-text">
                                <a href="{$FORGOT_PASSWORD_URL}" class="text-decoration-none">{$FORGOT_PASSWORD}</a>                            
                            </small>
                        </div>

                        <div class="mb-3">
                            <div class="form-check">
                                <input  class="form-check-input" type="checkbox" name="remember" id="remember" value="1" tabindex="3">
                                <label class="form-check-label" for="remember">{$REMEMBER_ME}</label>
                            </div>
                        </div>

                        {if $CAPTCHA}
                            <div class="mb-3">
                                {$CAPTCHA}
                            </div>
                        {/if}

                        <input type="hidden" name="token" value="{$FORM_TOKEN}">
                        <input type="submit" class="btn btn-primary rounded-5 w-100" value="{$SIGN_IN}" tabindex="5">
                    </form>


                    {if $OAUTH_AVAILABLE}
                        <div class="d-flex align-items-center text-body-secondary">
                            <hr class="w-100">
                            <span class="w-auto text-nowrap px-2">{$OR}</span>
                            <hr class="w-100">
                        </div>

                        <div class="row">
                            {foreach $OAUTH_PROVIDERS as $name => $meta}
                                <div class="col-12 col-md-3">
                                    <a href="{$meta.url}" class="btn btn-secondary w-100" {if $meta.button_css}style="{$meta.button_css}"{/if}>
                                        {if $meta.logo_url}
                                            <img src="{$meta.logo_url}" {if $meta.logo_css}style="{$meta.logo_css}"{/if} alt="{$name|ucfirst}">
                                        {elseif $meta.icon}
                                            <i class="{$meta.icon} fa-lg"></i>
                                        {/if}
                                        <span {if $meta.text_css}style="{$meta.text_css}"{/if}>{$meta.log_in_with}</span>
                                    </a>
                                </div>
                            {/foreach}
                        </div>
                    {/if}

                    <div class="d-flex align-items-center text-body-secondary ">
                        <hr class="w-100">
                        <span class="w-auto text-nowrap px-2">{$NOT_REGISTERED_YET}</span>
                        <hr class="w-100">
                    </div>

                    <a class="btn btn-dark dark-border rounded-5 w-100" href="{$REGISTER_URL}">{$REGISTER}</a>
                </div>
            </div>
        </div>
    </div>
</div>

{include file='footer.tpl'}
