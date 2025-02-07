{extends file="base/user.tpl"}

{block name=content}
    {if isset($ERROR)}
        <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-x-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary"> <strong class="text-danger">{$ERROR_TITLE}</strong> {$ERROR}</div>
        </div>
    {/if}

    <div class="bg-body shadow-sm rounded-3 py-3 d-flex flex-column mb-3">                
        <div class="mx-3 d-flex">
            <h5>{$NEW_MESSAGE}</h5>
        </div>

        <form action="" method="post" id="form-new-message">
            <div class="mb-3 mx-3">
                <label for="inputTitle" class="form-label">{$MESSAGE_TITLE}</label>
                <input type="text" class="form-control" name="title" id="inputTitle" placeholder="{$MESSAGE_TITLE}" value="{$MESSAGE_TITLE_VALUE}">
            </div>

            <div class="mb-3 mx-3">
                <label for="InputTo" class="form-label">{$TO}</label>

                <select name="to" id="InputTo" class="form-select" multiple>
                    {if count($ALL_USERS) > 0}
                        {foreach from=$ALL_USERS item="username"}
                            <option value="{$username}">{$username}</option>
                        {/foreach}
                    {/if}
                </select>
            </div>

            <div class="mb-3 mx-3">
                <textarea name="content" id="reply" class="form-control"></textarea>
            </div>
            <input type="hidden" name="token" value="{$TOKEN}">
            <input type="submit" class="btn btn-primary rounded-5 px-5 mx-3" value="{$SUBMIT}">
        </form>
    </div>
{/block}