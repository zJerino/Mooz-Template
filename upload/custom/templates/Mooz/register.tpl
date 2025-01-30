{include file='header.tpl'}
{include file='navbar.tpl'}

{if isset($REGISTRATION_ERROR)}
    <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
        <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
            <i class="bi bi-x-circle-fill fs-2"></i>
        </div>
        <div class="text-body-secondary">
            <strong class="text-danger me-2">{$ERROR_TITLE}</strong>
            <ul class="list">
                {foreach from=$REGISTRATION_ERROR item=error}
                    <li>{$error}</li>
                {/foreach}
            </ul>
        </div>
    </div>
{/if}

<div class="container">
    <div class="row justify-content-center">
        <div class="col-12 col-md-6">
            <div class="bg-body rounded-3 shadow-sm d-flex flex-column">
                <div class="p-4 d-flex flex-column">
                    <h5 class="mb-3 mx-auto">
                        <span class="text-primary">•</span>
                        <span class="mx-1">{$CREATE_AN_ACCOUNT}</span>
                        <span class="text-primary">•</span>
                    </h5>

                    {if $OAUTH_FLOW}
                        <p class="text-body-secondary mb-3">
                            {$OAUTH_MESSAGE_CONTINUE}
                        </p>
                    {/if}

                    <form action="" method="post">
                        {assign var=counter value=1}
                        {foreach $FIELDS as $field_key => $field}
                            <div class="mb-3">
                                <label for="{$field_key}" class="form-label">{$field.name}</label>
                                {if $field.type eq 1}
                                    <input type="text" name="{$field_key}" id="{$field_key}" value="{$field.value}" placeholder="{$field.placeholder}" tabindex="{$counter++}" {if $field.required} required{/if} class="form-control">
                                {else if $field.type eq 2}
                                    <textarea class="form-control" name="{$field_key}" id="{$field_key}" placeholder="{$field.placeholder}" tabindex="{$counter++}"></textarea>
                                {else if $field.type eq 3}
                                    <input class="form-control" type="date" name="{$field_key}" id="{$field_key}" value="{$field.value}" tabindex="{$counter++}">
                                {else if $field.type eq 4}
                                    <input class="form-control" type="password" name="{$field_key}" id="{$field_key}" value="{$field.value}" placeholder="{$field.placeholder}" tabindex="{$counter++}" {if $field.required} required{/if}>
                                {else if $field.type eq 5}
                                    <select class="form-select" name="{$field_key}" id="{$field_key}" {if $field.required}required{/if}>
                                        {foreach from=$field.options item=option}
                                            <option value="{$option.value}" {if $option.value eq $field.value} selected{/if}>
                                                {$option.option}
                                            </option>
                                        {/foreach}
                                    </select>
                                {else if $field.type eq 6}
                                    <input class="form-control" type="number" name="{$field_key}" id="{$field_key}" value="{$field.value}" placeholder="{$field.name}" tabindex="{$counter++}" {if $field.required}required{/if}>
                                {else if $field.type eq 7}
                                    <input class="form-control" type="email" name="{$field_key}" id="{$field_key}" value="{$field.value}" placeholder="{$field.placeholder}" tabindex="{$counter++}" {if $field.required}required{/if}>
                                {else if $field.type eq 8}
                                    {foreach from=$field.options item=option}
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="{$field_key}" value="{$option.value}" {if $field.value eq $option.value}checked{/if} {if $field.required}required{/if} tabindex="{$counter++}">
                                            <label class="form-check-label">{$option.option}</label>
                                        </div>
                                    {/foreach}
                                {else if $field.type eq 9}
                                    {* {foreach from=$field.options item=option}
                                    <div class="field">
                                        <div class="ui checkbox">
                                            <input type="checkbox" name="{$field_key}[]" value="{$option.value}" {if
                                                is_array($field.value) && in_array($option.value, $field.value)}checked{/if}
                                                tabindex="{$counter++}">
                                            <label>{$option.option}</label>
                                        </div>
                                    </div>
                                    {/foreach} *}
                                    <p class="text-danger">¡Unsoported!</p>
                                {/if}
                            </div>
                        {/foreach}
                        <div class="mb-3">
                            <div class="form-check">
                                <input  class="form-check-input" type="checkbox" name="t_and_c" id="t_and_c" value="1" tabindex="7">
                                <label class="form-check-label" for="t_and_c">{$AGREE_TO_TERMS}</label>
                            </div>
                        </div>

                        {if $CAPTCHA}
                            <div class="mb-3">
                                {$CAPTCHA}
                            </div>
                        {/if}


                        <input type="hidden" name="token" value="{$TOKEN}">
                        <input id="timezone" type="hidden" name="timezone" value="">
                        <input type="submit" class="btn btn-primary rounded-5 w-100" value="{$REGISTER}" tabindex="8">
                        {if $OAUTH_FLOW}
                            <a class="btn btn-danger rounded-5 w-100" href="{$OAUTH_CANCEL_REGISTER_URL}">{$CANCEL}</a>
                        {/if}
                    </form>
                    
                    {if $OAUTH_AVAILABLE and !$OAUTH_FLOW}
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
                                        <span {if $meta.text_css}style="{$meta.text_css}"{/if}>{$meta.continue_with}</span>
                                    </a>
                                </div>
                            {/foreach}
                        </div>
                    {/if}

                    {if !$OAUTH_FLOW}
                        <div class="d-flex align-items-center text-body-secondary ">
                            <hr class="w-100">
                            <span class="w-auto text-nowrap px-2">{$ALREADY_REGISTERED}</span>
                            <hr class="w-100">
                        </div>

                        <a class="btn btn-dark dark-border rounded-5 w-100" href="{$LOGIN_URL}">{$LOG_IN}</a>
                    {/if}
                </div>
            </div>
        </div>
    </div>
</div>

{if $OAUTH_FLOW && $OAUTH_EMAIL_VERIFIED}
    <script>
        document.getElementById('email').addEventListener('keyup', (e) => {
            checkEmailValidity(e.target.value);
        });

        const checkEmailValidity = (email) => {
            if ('{$OAUTH_EMAIL_VERIFIED}' && email !== '{$OAUTH_EMAIL_ORIGINAL}') {
                addEmailCaption('{$OAUTH_EMAIL_NOT_VERIFIED_MESSAGE}', 'orange');
            } else {
                addEmailCaption('{$OAUTH_EMAIL_VERIFIED_MESSAGE}', 'green');
            }
        }

        const addEmailCaption = (text, colour) => {
            const email = document.getElementById('email');
            document.getElementById('email-caption')?.remove();
            email.parentElement.insertAdjacentHTML('beforeend', '<div id="email-caption" style="margin-top: 5px;" class="ui basic ' + colour + ' label">' + text + '</div>');
        };

        window.onload = () => checkEmailValidity('{$EMAIL_INPUT}');
    </script>
{/if}

{include file='footer.tpl'}
