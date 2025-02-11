{include file='header.tpl'}
<div id="app-content">
{$CONTENT}
</div>
{foreach from=$TEMPLATE_JS item=script}
{$script}
{/foreach}
</div>
</body>

</html>