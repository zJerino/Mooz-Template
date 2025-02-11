
{include file='header.tpl'}
<div id="app-content">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-12 col-md-8">
                <div class="bg-body rounded-3 shadow-sm p-3 d-flex flex-column">
                    <div class="d-flex align-items-center justify-content-center mb-3">
                        <h3 class="text-primary me-2 fs-1 m-0 mb-1">&bull;</h3>
                        <h4 class="m-0">{$MAINTENANCE_TITLE}</h4>
                        <h3 class="text-primary me-2 fs-1 m-0 mb-1">&bull;</h3>                        
                    </div>


                    <div class="text-body-secondary mb-3">
                        {$MAINTENANCE_MESSAGE}
                    </div>

                    
                    <div class="btn-group mx-auto">
                        <button class="btn btn-dark dark-border" onclick="window.location.reload()">{$RETRY}</button>
                        {if isset($LOGIN)}
                            <a href="{$LOGIN_LINK}" class="btn btn-secondary">{$LOGIN}</a>
                        {/if}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
{foreach from=$TEMPLATE_JS item=script}
{$script}
{/foreach}
</div>
</body>
</html>