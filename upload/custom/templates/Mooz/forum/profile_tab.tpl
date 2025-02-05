<div class="bg-body shadow-sm py-3 mb-3 rounded-3 d-flex flex-column">
    <div class="text-primary text-center rounded-top-3 px-3 fv-small mb-2 fw-bold">
        {$PF_LATEST_POSTS_TITLE}
    </div>
    {if isset($NO_POSTS)}    
        <i class="text-body-secondary mx-auto">{$NO_POSTS}</i>
    {else}
        <div class="list-group list-group-flush mb-0">
            {foreach from=$PF_LATEST_POSTS item=item key=key}
                <a class="list-group-item d-flex flex-column text-decoration-none" href="{$item.link}" tabindex=0 data-bs-toggle="popover" data-bs-html="true" data-bs-trigger="hover focus" data-bs-title="{$item.title} - {$item.date_full}" data-bs-content="..." data-element="#fp-post-{$key}">
                    <strong>{$item.title}</strong>
                    <small class="text-body-secondary">{$item.date_friendly}</small>
                </a>
            {/foreach}
        </div>
        {foreach from=$PF_LATEST_POSTS item=item key=key}
            <div class="d-none" id="fp-post-{$key}">
                <div class="d-flex flex-column">
                    <small class="text-body-secondary">{$item.content}</small>
                </div>
            </div>
        {/foreach}        
    {/if}
</div>