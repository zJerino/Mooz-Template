{extends file="base/empty.tpl"}

{block name='content'}
    <div class="d-flex align-items-center mb-3">
        <h3 class="text-primary me-2 fs-1 m-0 mb-1">&bull;</h3>
        <h4 class="m-0 text-body">{$SEARCH_RESULTS}</h4>
    </div>
    

    {if empty($RESULTS)}
        <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-x-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                {$NO_RESULTS}
            </div>
        </div>
    {else}
        {foreach from=$RESULTS item=result}
            <div class="bg-body rounded-3 shadow-sm mb-3 d-flex flex-column" data-href="{$result.post_url }">
                <div class="d-flex align-items-center p-2 px-md-3 bg-body-tertiary rounded-top-3">
                    <img src="{$result.post_author_avatar}" alt="{$result.post_author}" class="rounded-5 me-2" style="width: 2rem;height: 2rem;">
                    <div class="d-flex flex-column">
                        <a href="{$result.post_url}" class="text-decoration-none fw-semibold">{$result.topic_title}</a>
                        <small class="text-body-secondary">
                            <a href="{$result.post_author_profile}" style="text-decoration: none;{$result.post_author_style}">{$result.post_author}</a>
                            &bull;
                            <span data-bs-toggle="tooltip" title="{$result.post_date_friendly}">{$result.post_date_full}</span>
                        </small>
                    </div>
                </div>
                <div class="d-block px-2">
                    {$result.content}
                </div>
            </div>
        {/foreach}
    {/if}    

    {if isset($PAGINATION)}
        <div class="d-flex">
            <div class="mx-auto">{$PAGINATION}</div>
        </div>
    {/if}
{/block}

<div class="res right floated">
    <a href="{$NEW_SEARCH_URL}" class="ui primary button">{$NEW_SEARCH}</a>
</div>

{if empty($RESULTS)}
<div class="ui error message">
    {$NO_RESULTS}
</div>
{else}
{foreach from=$RESULTS item=result}
<div class="ui segments" id="forum-search-result">
    <div class="ui padded attached segment">
        <h3 class="ui header">
            <a href="{$result.post_url}" data-toggle="popup">{$result.topic_title}</a>
            <div class="ui wide popup">
                <h4 class="ui header">{$result.topic_title}</h4>
                <a href="{$result.post_author_profile}" style="{$result.post_author_style}">{$result.post_author}</a> |
                {$result.post_date_full}
            </div>
            <div class="sub header">
                <a href="{$result.post_author_profile}" style="{$result.post_author_style}"
                    data-poload="{$USER_INFO_URL}{$result.post_author_id}">{$result.post_author}</a> &middot; <span
                    data-toggle="tooltip" data-content="{$result.post_date_full}">{$result.post_date_friendly}</span>
            </div>
        </h3>
        {$result.content}
    </div>
    <div class="ui bottom attached secondary segment">
        <div class="right aligned">
            <a class="ui mini primary button" href="{$result.post_url}">{$READ_FULL_POST}</a>
        </div>
    </div>
</div>
{/foreach}
{/if}

{if isset($PAGINATION)}
{$PAGINATION}
{/if}
