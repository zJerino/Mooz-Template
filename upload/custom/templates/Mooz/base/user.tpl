{include file='header.tpl'}
{include file='navbar.tpl'}

<div class="container">
    <div class="row justify-content-center">
        <div class="col">
            {include file='user/navigation.tpl'}            
        </div>
        <div class="col-12 col-md-8">
            {block name='content'}{/block}            
        </div>
    </div>
</div>


{include file='footer.tpl'}