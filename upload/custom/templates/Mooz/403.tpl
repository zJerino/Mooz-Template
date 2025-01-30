
{extends file="base/empty.tpl"}

{block name='content'}

    <div class="d-flex flex-column">
        <div class="mx-md-auto d-flex align-items-center px-3 flex-column p-2 bg-body rounded-3 shadow-sm">
            <div class="d-flex align-items-center mb-3">
                <h3 class="text-primary fs-1 m-0 mb-1">&bull;</h3>
                <h4 class="mx-2 m-0">{$403_TITLE}</h4>
                <h3 class="text-primary fs-1 m-0 mb-1">&bull;</h3>                
            </div>
            
            {if !isset($LOGGED_IN_USER)}
                <p class="text-body-secondary mb-2">{$CONTENT_LOGIN}</p>
            {/if}


            <p class="text-body-secondary mb-2">{$CONTENT}</p>


            <div class="btn-group btn-group-sm">
                <button class="btn btn-dark dark-border px-5 rounded-start-5" onclick="javascript:history.go(-1)">{$BACK}</button>            

                {if isset($LOGGED_IN_USER)}
                    <a class="btn btn-primary px-5 rounded-end-5" href="{$SITE_HOME}">{$HOME}</a>                
                {else}
                    <a class="btn btn-primary px-5 rounded-end-5" href="{$LOGIN_LINK}">{$LOGIN}</a>                
                {/if}
            </div>
        </div>
    </div>

{/block}
