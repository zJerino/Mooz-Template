{extends file="base/widgets.tpl"}

{block name='content'}
    <div class="bg-body rounded-3 p-3 d-flex flex-column">
        <div class="d-flex align-items-center">
            <h3 class="text-primary me-2 fs-1 m-0 mb-1">&bull;</h3>
            <h4 class="m-0">{$TITLE}</h4>
        </div>

        <div class="d-block" id="content">
            {$CONTENT}
        </div>
    </div>
{/block}
