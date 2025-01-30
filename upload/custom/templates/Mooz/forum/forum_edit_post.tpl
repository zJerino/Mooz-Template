{extends file="base/empty.tpl"}

{block name='content'}
    <div class="d-flex flex-column">
        <div class="d-flex px-3 flex-column p-2 bg-body rounded-3 shadow-sm">
            <div class="d-flex align-items-center mb-3 mx-auto">
                <h3 class="text-primary fs-1 m-0 mb-1">&bull;</h3>
                <h4 class="mx-2 m-0">{$EDITING_POST}</h4>
                <h3 class="text-primary fs-1 m-0 mb-1">&bull;</h3>                
            </div>

            
            <form action="" method="post">
                {if isset($EDITING_TOPIC)}
                    <div class="mb-2">
                        <label for="title" class="form-label">{$TOPIC_TITLE}</label>
                        <input type="text" id="title" class="form-control" name="title" value="{$TOPIC_TITLE_VALUE}">
                    </div>

                    {if count($LABELS)}
                        <div class="d-flex flex-column mb-2">
                            <label class="form-label">{$LABELS_TEXT}</label>
                            <div class="d-flex flex-row overflow-auto">
                                {foreach from=$LABELS item=label key=key}
                                    <div class="mx-1">
                                        <input type="checkbox" name="topic_label[]" id="label-{$label.id}" class="btn-check" value="{$label.id}" {if $label.active} checked="checked" {/if} hidden autocomplete="off">
                                        <label class="btn" for="label-{$label.id}">{$label.html}</label>
                                    </div>
                                {/foreach}
                            </div>
                        </div>
                    {/if}
                {/if}
                
                <div class="d-flex flex-column mb-2">
                    <label for="editor" class="form-label">{$CONTENT_LABEL}</label>
                    <textarea name="content" id="editor" class="form-label"></textarea>
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

{if isset($ERRORS)}
<div class="ui error icon message">
    <i class="x icon"></i>
    <div class="content">
        <div class="header">{$ERROR_TITLE}</div>
        <ul class="list">
            {foreach from=$ERRORS item=error}
            <li>{$error}</li>
            {/foreach}
        </ul>
    </div>
</div>
{/if}

<div class="ui padded segment" id="post-edit">
    <div class="ui stackable grid">
        <div class="ui centered row">
            <div class="ui sixteen wide tablet twelve wide computer column">
                <form class="ui form" action="" method="post" id="form-post-edit">
                </form>
            </div>
        </div>
    </div>
</div>
