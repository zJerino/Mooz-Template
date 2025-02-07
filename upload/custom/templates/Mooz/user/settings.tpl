{extends file="base/user.tpl"}

{block name=content}
    {if !empty($SUCCESS)}
        <div class="bg-body border-3 border-start border-success d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-success text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-check-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                <strong class="text-success">{$SUCCESS_TITLE}</strong> {$SUCCESS}
            </div>
        </div>
    {/if}

    {if (isset($ERRORS) || isset($ERROR))}
        <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-x-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                <ul class="list">
                    {foreach from=$ERRORS item=error}
                    <li>{$error}</li>
                    {/foreach}
                    {if isset($ERROR)}
                    <li>{$ERROR}</li>
                    {/if}
                </ul>
            </div>
        </div>
    {/if}

    <div class="bg-body shadow-sm rounded-3 py-3 d-flex flex-column mb-3">                
        <div class="mx-3 mb-3 d-flex">
            <h5>{$SETTINGS}</h5>
        </div>
        
        <form class="mx-3" action="" method="post" id="form-user-settings">
            {nocache}
                {foreach from=$PROFILE_FIELDS key=name item=field}
                    <div class="mb-3">
                        {if !isset($field.disabled)}
                            <label for="input{$field.id}" class="form-label"> {$field.name} {if $field.required} <super style="color: red;">*</super> {/if} </label>
                            {if $field.type == "text"}
                                <input class="form-control" type="text" name="{if $name == 'nickname'}nickname{else}profile_fields[{$field.id}]{/if}" id="input{$field.id}" value="{$field.value}" placeholder="{$field.description}">
                            {elseif $field.type == "textarea"}
                                <textarea  class="form-control" name="profile_fields[{$field.id}]" id="input{$field.id}" placeholder="{$field.description}">{$field.value}</textarea>
                            {elseif $field.type == "date"}
                                <input class="form-control" type="date" name="profile_fields[{$field.id}]" id="input{$field.id}" value="{$field.value}">
                            {/if}
                        {/if}
                    </div>
                {/foreach}
                
                {if isset($TOPIC_UPDATES)}
                    <div class="mb-3">
                        <label class="form-label" for="inputTopicUpdates">{$TOPIC_UPDATES}</label>
                        <select class="form-select" name="topicUpdates" id="inputTopicUpdates">
                            <option value="1" {if ($TOPIC_UPDATES_ENABLED==true)} selected {/if}>{$ENABLED}</option>
                            <option value="0" {if ($TOPIC_UPDATES_ENABLED==false)} selected {/if}>{$DISABLED}</option>
                        </select>
                    </div>
                {/if}
                {if isset($AUTHME_SYNC_PASSWORD)}
                    <div class="mb-3">
                        <label class="form-label" for="inputAuthmeSync">{$AUTHME_SYNC_PASSWORD}
                            <div class="ui icon label mini" data-tooltip="{$AUTHME_SYNC_PASSWORD_INFO}">
                                <i class="question icon"></i>
                            </div>
                        </label>
                        <select class="form-select" name="authmeSync" id="inputAuthmeSync">
                            <option value="1" {if ($AUTHME_SYNC_PASSWORD_ENABLED == true)} selected {/if}>{$ENABLED}</option>
                            <option value="0" {if ($AUTHME_SYNC_PASSWORD_ENABLED == false)} selected {/if}>{$DISABLED}</option>
                        </select>
                    </div>
                {/if}
                {if isset($PRIVATE_PROFILE)}
                    <div class="mb-3">
                        <label class="form-label" for="inputPrivateProfile">{$PRIVATE_PROFILE}</label>
                        <select class="form-select" name="privateProfile" id="inputPrivateProfile">
                            <option value="1" {if ($PRIVATE_PROFILE_ENABLED==true)} selected {/if}>{$ENABLED}</option>
                            <option value="0" {if ($PRIVATE_PROFILE_ENABLED==false)} selected {/if}>{$DISABLED}</option>
                        </select>
                    </div>
                {/if}
                {if isset($CUSTOM_AVATARS)}
                    <div class="mb-3">
                        <label class="form-label" for="inputGravatar">{$GRAVATAR}</label>
                        <select class="form-select" name="gravatar" id="inputGravatar">
                            <option value="0" {if ($GRAVATAR_VALUE=='0' )} selected {/if}>{$DISABLED}</option>
                            <option value="1" {if ($GRAVATAR_VALUE=='1' )} selected {/if}>{$ENABLED}</option>
                        </select>
                    </div>
                {/if}
                <div class="mb-3">
                    <label class="form-label" for="inputLanguage">{$ACTIVE_LANGUAGE}</label>
                    <select class="form-select" name="language" id="inputLanguage">
                        {foreach from=$LANGUAGES item=language}
                            <option value="{$language.name}" {if $language.active} selected{/if}>
                                {$language.name}
                            </option>
                        {/foreach}
                    </select>
                </div>
                {if count($TEMPLATES) > 2}
                    <div class="mb-3">
                        <label class="form-label" for="inputTemplate">{$ACTIVE_TEMPLATE}</label>
                        <select class="form-select" name="template" id="inputTemplate">
                            {foreach from=$TEMPLATES item=template}
                                <option value="{$template.id}" {if $template.active==true} selected{/if}>{$template.name}</option>
                            {/foreach}
                        </select>
                    </div>
                {/if}
                <div class="mb-3">
                    <label class="form-label" for="inputTimezone">{$TIMEZONE}</label>
                    <select class="form-control" name="timezone" id="inputTimezone">
                        {foreach from=$TIMEZONES key=KEY item=ITEM}
                            <option value="{$KEY}" {if $SELECTED_TIMEZONE eq $KEY} selected{/if}> ({$ITEM.offset}) {$ITEM.name} &middot; ({$ITEM.time}) </option>
                        {/foreach}
                    </select>
                </div>
                {if isset($SIGNATURE)}
                    <div class="mb-3">
                        <label class="form-label" for="inputSignature">{$SIGNATURE}</label>
                        <textarea class="form-control" name="signature" id="inputSignature">{$SIGNATURE_VALUE}</textarea>
                    </div>
                {/if}
            {/nocache}
            <input type="hidden" name="action" value="settings">
            <input type="hidden" name="token" value="{$TOKEN}">
            <input type="submit" class="btn btn-primary rounded-5 w-100" value="{$SUBMIT}">
        </form>


        <div class="d-flex align-items-center text-body-secondary mt-4">
            <hr class="w-100">
            <span class="w-auto text-nowrap px-2">{$CHANGE_EMAIL_ADDRESS}</span>
            <hr class="w-100">
        </div>
        
        <form class="mx-3" action="" method="post" id="form-user-email">
            <div class="mb-3">
                <label class="form-label" for="inputPassword">{$CURRENT_PASSWORD}</label>
                <input class="form-control" type="password" name="password" id="inputPassword">
            </div>
            <div class="mb-3">
                <label class="form-label" for="inputEmail">{$EMAIL_ADDRESS}</label>
                <input class="form-control" type="email" name="email" id="inputEmail" value="{$CURRENT_EMAIL}">
            </div>
            <input type="hidden" name="action" value="email">
            <input type="hidden" name="token" value="{$TOKEN}">
            <input type="submit" value="{$SUBMIT}" class="btn btn-primary rounded-5 w-100">
        </form>

        <div class="d-flex align-items-center text-body-secondary mt-4">
            <hr class="w-100">
            <span class="w-auto text-nowrap px-2">{$CHANGE_PASSWORD}</span>
            <hr class="w-100">
        </div>
        
        <form class="mx-3" action="" method="post" id="form-user-password">
            <div class="mb-3">
                <label class="form-label" for="inputOldPassword">{$CURRENT_PASSWORD}</label>
                <input class="form-control" type="password" name="old_password" id="inputOldPassword">
            </div>
            <div class="mb-3">
                <label class="form-label" for="inputNewPassword">{$NEW_PASSWORD}</label>
                <input class="form-control" type="password" name="new_password" id="inputNewPassword">
            </div>
            <div class="mb-3">
                <label class="form-label" for="inputNewPasswordAgain">{$CONFIRM_NEW_PASSWORD}</label>
                <input class="form-control" type="password" name="new_password_again" id="inputNewPasswordAgain">
            </div>
            <input type="hidden" name="action" value="password">
            <input type="hidden" name="token" value="{$TOKEN}">
            <input type="submit" value="{$SUBMIT}" class="btn btn-primary rounded-5 w-100">
        </form>


        <div class="d-flex align-items-center text-body-secondary mt-4">
            <hr class="w-100">
            <span class="w-auto text-nowrap px-2">{$TWO_FACTOR_AUTH}</span>
            <hr class="w-100">
        </div>
        
        <div class="mx-3">
            {if isset($ENABLE)}
                <a class="btn btn-success rounded-5 w-100" href="{$ENABLE_LINK}">{$ENABLE}</a>
            {elseif isset($FORCED)}
                <button class="btn btn-danger rounded-5 w-100" disabled>{$DISABLE}</button>
            {else}
                <form class="ui form" action="{$DISABLE_LINK}" method="post">
                    <input type="hidden" name="token" value="{$TOKEN}">
                    <input type="submit" value="{$DISABLE}" class="btn btn-danger rounded-5 w-100">
                </form>
            {/if}
        </div>

        {if isset($CUSTOM_AVATARS)}
            <div class="mx-3">
                <div class="d-flex align-items-center text-body-secondary mt-4">
                    <hr class="w-100">
                    <span class="w-auto text-nowrap px-2">{$UPLOAD_NEW_PROFILE_IMAGE}</span>
                    <hr class="w-100">
                </div>
                <form action="{$CUSTOM_AVATARS_SCRIPT}" method="post" enctype="multipart/form-data" id="form-user-avatar">
                    <div class="input-group">
                        <input type="file" name="file" class="form-control" id="file_avatar" aria-label="{$BROWSE}">
                        <button class="btn btn-primary" id="fileavatar_label" type="submit">{$SUBMIT}</button>
                    </div>
                    <input type="hidden" name="type" value="avatar">
                    <input type="hidden" name="token" value="{$TOKEN}">
                </form>
            </div>
            {if $HAS_CUSTOM_AVATAR}
                <div class="mx-3">
                    <div class="d-flex align-items-center text-body-secondary mt-4">
                        <hr class="w-100">
                        <span class="w-auto text-nowrap px-2">{$REMOVE_AVATAR}</span>
                        <hr class="w-100">
                    </div>
                    
                    <form class="ui form" action="" method="post" id="form-reset-avatar">
                        <input type="hidden" name="action" value="reset_avatar">
                        <input type="hidden" name="token" value="{$TOKEN}">
                        <input type="submit" value="{$REMOVE}" class="btn btn-danger rounded-5 w-100">
                    </form>
                </div>
            {/if}
        {/if}
    </div>
{/block}
