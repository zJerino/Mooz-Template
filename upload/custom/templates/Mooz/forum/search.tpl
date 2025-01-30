{extends file="base/empty.tpl"}

{block name='content'}
    {if isset($ERROR)}
        <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-x-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                <strong class="text-danger me-2">{$ERROR_TITLE}</strong>
                {$ERROR}
            </div>
        </div>
    {/if}

    <div class="bg-body rounded-3 p-2 shadow-sm">

        <div class="d-flex align-items-center me-2">
            <h3 class="text-primary me-2 fs-1 m-0 mb-1">&bull;</h3>
            <h4 class="m-0 text-body">{$FORUM_SEARCH}</h4>
        </div>
        <form class="ui form" action="" method="post" id="form-forum-search">
            <div class="d-flex flex-column">
                <div class="input-group mb-3">
                    <input type="text" class="form-control" type="text" name="forum_search" placeholder="{$SEARCH}">
                    <button class="btn btn-outline-secondary" type="submit"><i class="bi bi-search"></i></button>
                </div>
                
                <input type="hidden" name="token" value="{$TOKEN}">                
            </div>
        </form>
    </div>    
{/block}

<div class="ui padded segment" id="forum-search">
    <div class="ui stackable grid">
        <div class="ui centered row">
            <div class="ui sixteen wide tablet ten wide computer column">
                
            </div>
        </div>
    </div>
</div>
