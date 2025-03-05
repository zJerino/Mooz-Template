{extends file="base/empty.tpl"}

{block name='content'}
    <div class="bg-body rounded-3 p-3 d-flex flex-column">
        <div class="d-flex align-items-center justify-content-center mb-3">
            <h3 class="text-primary me-2 fs-1 m-0 mb-1">•</h3>
            <h4 class="m-0">{$TERMS}</h4>
            <h3 class="text-primary ms-2 fs-1 m-0 mb-1">•</h3>
        </div>


        <div class="d-block" id="terms">
            {$SITE_TERMS}        
        </div>
    </div>
{/block}
