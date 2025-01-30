{extends file="base/empty.tpl"}

{block name='content'}

    <div class="d-flex flex-column">
        <div class="mx-md-auto d-flex align-items-center px-3 flex-column p-2 bg-body rounded-3 shadow-sm">
            <div class="d-flex align-items-center mb-3">
                <h3 class="text-primary fs-1 m-0 mb-1">&bull;</h3>
                <h4 class="mx-2 m-0">{$MOVE_TOPIC}</h4>
                <h3 class="text-primary fs-1 m-0 mb-1">&bull;</h3>                
            </div>
            <form class="ui form" action="" method="post" id="form-move-topic">
                <div class="mb-3">
                    <label for="InputForum" class="form-label">{$MOVE_TO}</label>
                    <select name="forum" class="form-select" id="InputForum">
                        {foreach from=$FORUMS item=forum}
                            {if $forum->category}
                                <option disabled>{$forum->forum_title}</option>
                            {else}
                                <option value="{$forum->id}">{$forum->forum_title}</option>
                            {/if}
                        {/foreach}
                    </select>
                </div>
                <input type="hidden" name="token" value="{$TOKEN}">
                <div class="d-flex flex-md-row flex-column mx-md-0 mx-auto">
                    <input type="submit" class="btn btn-primary px-5 rounded-5 m-1" value="{$SUBMIT}">
                    <a class="btn btn-dark dark-border px-5 rounded-5 m-1" href="{$CANCEL_LINK}" onclick="return confirm('{$CONFIRM_CANCEL}')">{$CANCEL}</a>
                </div>
            </form>
        </div>
    </div>

{/block}