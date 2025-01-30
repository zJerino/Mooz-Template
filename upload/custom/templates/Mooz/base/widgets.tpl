{include file='header.tpl'}
{include file='navbar.tpl'}

<div id="content-container" class="container">
    <div class="row justify-content-center">
        {if isset($WIDGETS_LEFT) && count($WIDGETS_LEFT)}
            <div class="col">
                {foreach from=$WIDGETS_LEFT item=widget}
                    {$widget}
                {/foreach}
            </div>
        {/if}
        <div class="col-12 {if count($WIDGETS_LEFT) && count($WIDGETS_RIGHT) }col-md-6{else}col-md-8{/if}">
            {block name='content'}{/block}
        </div>

        {if isset($WIDGETS_RIGHT) && count($WIDGETS_RIGHT)}
            <div class="col">
                {foreach from=$WIDGETS_RIGHT item=widget}
                    {$widget}
                {/foreach}
            </div>
        {/if}
    </div>
</div>

{include file='footer.tpl'}