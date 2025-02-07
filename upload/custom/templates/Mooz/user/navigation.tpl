<div class="bg-body shadow-sm rounded-3 py-3 d-flex flex-column mb-3">
    <h6 class="fv-petite text-primary fw-bold mb-3 mx-3">{$TITLE}</h6>
    <div class="list-group list-group-flush">
        {foreach from=$CC_NAV_LINKS key=name item=item}
            <a class="list-group-item list-group-item-action{if isset($item.active)} active{/if}" href="{$item.link}" target="{$item.target}">{$item.title}</a>
        {/foreach}
    </div>
</div>