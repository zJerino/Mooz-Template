
{extends file="base/empty.tpl"}

{block name='content'}

    <div class="d-flex flex-column">
        <div class="mx-md-auto d-flex align-items-center px-3 flex-column p-2 bg-body rounded-3 shadow-sm">
            <div class="d-flex align-items-center mb-3">
                <h3 class="text-primary fs-1 m-0 mb-1">&bull;</h3>
                <h4 class="mx-2 m-0">{$404_TITLE}</h4>
                <h3 class="text-primary fs-1 m-0 mb-1">&bull;</h3>                
            </div>
            
            <p class="text-body-secondary mb-2">{$CONTENT}</p>


            <div class="btn-group btn-group-sm">
                <button class="btn btn-dark dark-border px-5 rounded-start-5" onclick="javascript:history.go(-1)">{$BACK}</button>            
                <a class="btn btn-primary px-5 rounded-end-5" href="{$SITE_HOME}">{$HOME}</a>
            </div>

            <div class="d-flex mt-3">
                <i class="bi bi-exclamation-circle me-2 text-danger"></i>
                <p class="m-0 p-0 text-center">
                    {$ERROR}
                </p>
            </div>
        </div>
    </div>

{/block}