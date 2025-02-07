{extends file="base/user.tpl"}

{block name=content}
    {if isset($ERROR)}
        <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-x-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary"><strong class="text-danger me-2">{$ERROR_TITLE}</strong> {$ERROR} </div>
        </div>
    {/if}

    {if isset($MESSAGE_SENT)}
        <div class="bg-body border-3 border-start border-success d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-success text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-check-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary"><strong class="text-success me-2">{$SUCCESS_TITLE}</strong> {$MESSAGE_SENT} </div>
        </div>
        
    {/if}

    <div class="bg-body shadow-sm rounded-3 py-3 d-flex flex-column mb-3">                
        <div class="d-flex mx-3 mb-3  align-items-center">
            <div class="d-flex flex-column me-1">
                <h5>{$MESSAGE_TITLE}</h5>
                <div class="text-body-secondary">{$PARTICIPANTS_TEXT}: {$PARTICIPANTS}</div>
            </div>
            <button type="button" class="btn btn-dark rounded-circle dark-border ms-auto my-auto btn-sm" data-bs-toggle="modal" data-bs-target="#modal-leave">
                <i class="bi bi-box-arrow-right" data-bs-toggle="tooltip" title="{$LEAVE_CONVERSATION}"></i>
            </button>
        </div>
        

        <div class="bg-body-tertiary rounded-3 mx-3 p-2 mb-2 d-flex flex-column overflow-auto">
            {foreach from=$MESSAGES item=message}
                {if $LOGGED_IN_USER.profile === $message.author_profile}
                    <div class="d-flex {if !$message@last}mb-2{/if} justify-content-end" id="message">
                        <div class="d-flex flex-column text-bg-primary bg-opacity-75 rounded-3" style="max-width: calc(100% - 5rem);min-width: calc(35%);">
                            <div class="forum_post px-2 mt-1">
                                {$message.content}
                            </div>

                            <div class="text-body-secondary px-2"> 
                                <small style="font-size: .6rem" class="me-auto" data-bs-toggle="tooltip" title="{$message.message_date_full}">{$message.message_date}</small>
                            </div>
                        </div>
                    </div>
                {else}
                    <div class="d-flex {if !$message@last}mb-2{/if}" id="message">
                        <img class="rounded-circle me-1" style="width: 2rem;height: 2rem" src="{$message.author_avatar}">
                        <div class="d-flex flex-column text-bg-secondary bg-opacity-75 rounded-3" style="max-width: calc(100% - 5rem);min-width: calc(35%);">
                            <a href="{$message.author_profile}" class="py-1 px-2" data-poload="{$USER_INFO_URL}{$message.author_id}" style="text-decoration: none;{$message.author_style}">{$message.author_username}</a>

                            <div class="forum_post px-2 mt-1">
                                {$message.content}
                            </div>

                            <div class="text-body-secondary px-2"> 
                                <small style="font-size: .6rem" class="ms-auto" data-bs-toggle="tooltip" title="{$message.message_date_full}">{$message.message_date}</small>
                            </div>
                        </div>
                    </div>
                {/if}
            {/foreach}
        </div>
        <div class="mx-3 my-2 d-flex justify-content-center">
            {$PAGINATION}
        </div>
        <form action="" method="post" class="mx-3">
            <div class="d-flex flex-column mb-3">
                <label for="reply" class="form-label">{$NEW_REPLY}</label>
                <textarea name="content" id="reply"></textarea>
            </div>
            <input type="hidden" name="token" value="{$TOKEN}">
            <div class="d-flex flex-column flex-md-row">
                <input type="submit" class="btn btn-primary rounded-5 px-4 me-md-2 mb-2 mb-md-0" value="{$SUBMIT}">
                <a class="btn btn-dark dark-border  rounded-5 px-4 me-md-2 mb-2 mb-md-0" href="{$BACK_LINK}">{$BACK}</a>            
            </div>
        </form>
    </div>

    <div class="modal fade" id="modal-leave" tabindex="-1" aria-labelledby="modal-leaveLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h1 class="modal-title fs-5" id="modal-leaveLabel">{$LEAVE_CONVERSATION}</h1>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <p>{$CONFIRM_LEAVE}</p>
                    <form action="{$LEAVE_CONVERSATION_LINK}" method="post" id="leave-form" class="d-flex">
                        <input type="hidden" name="token" value="{$TOKEN}">
                        <div class="d-flex flex-column flex-md-row mx-md-auto">
                            <a class="btn btn-dark dark-border rounded-5 px-4 me-md-2 mb-2 mb-md-0" href="#" data-bs-dismiss="modal">{$NO}</a>
                            <input type="submit" class="btn btn-primary rounded-5 px-4 mb-2 mb-md-0" value="{$YES}">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
{/block}
