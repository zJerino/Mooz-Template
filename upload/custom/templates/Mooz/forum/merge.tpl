{extends file="base/empty.tpl"}

{block name='content'}
    <div class="d-flex flex-column">
        <div class="mx-md-auto d-flex align-items-center px-3 flex-column p-2 bg-body rounded-3 shadow-sm">
            <div class="d-flex align-items-center mb-3">
                <h3 class="text-primary fs-1 m-0 mb-1">&bull;</h3>
                <h4 class="mx-2 m-0">{$MERGE_TOPICS}</h4>
                <h3 class="text-primary fs-1 m-0 mb-1">&bull;</h3>                
            </div>
            <form class="ui form" action="" method="post" id="form-move-topic">
                <div class="mb-3">
                    <p for="merge" class="mb-2">{$MERGE_INSTRUCTIONS}</p>
                    
                    <select name="merge" class="form-select" id="merge">
                        {foreach from=$TOPICS item=topic}
                            <option value="{$topic->id}">{$topic->topic_title|escape}</option>
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