{extends file="base/empty.tpl"}

{assign var="avatar_wh" value='8rem'}

{block name=content}
    <div class="row justify-content-center">
        <div class="col">
            <div class="bg-body shadow-sm p-3 mb-3 rounded-3 d-flex flex-column">
                <div class="text-primary text-center rounded-top-3 px-3 fv-small mb-2 fw-bold">
                    {$FIND_MEMBER}
                </div>
                <select class="form-select" type="text" id="searchMemberInput" minlength="2" required placeholder="{$NAME}" autocomplete="off"></select>
            </div>

            <div class="bg-body shadow-sm py-3 mb-3 rounded-3 d-flex flex-column">
                <div class="list-group list-group-flush mb-0">
                    <a class="list-group-item list-group-item-action {if $VIEWING_LIST eq "overview"}active{/if}" href="{$MEMBER_LIST_URL}">
                        {$OVERVIEW}
                    </a>
                    {foreach from=$SIDEBAR_MEMBER_LISTS item=list}
                        <a class="list-group-item list-group-item-action {if $VIEWING_LIST eq $list->getName()}active{/if}" href="{$list->url()}">
                            {$list->getFriendlyName()}
                        </a>
                    {/foreach}
                </div>
            </div>

            {if $GROUPS|count}
                <div class="bg-body shadow-sm p-3 mb-3 rounded-3 d-flex flex-column">
                    <div class="text-primary text-center rounded-top-3 px-3 fv-small mb-2 fw-bold">
                        {$VIEW_GROUP}
                    </div>
                    <select class="form-select" data-toggle='select2' onchange="viewGroup(this)">
                        <option value="" selected disabled>{$GROUP}</option>
                        {foreach from=$GROUPS item=group}
                            <option value="{$group.id}" {if $VIEWING_GROUP.id == $group.id} selected {/if}>{$group.name}</option>
                        {/foreach}
                    </select>
                </div>
            {/if}
        </div>
        <div class="col-12 col-md-8">
            {if $VIEWING_LIST != "overview"}
                <div class="bg-body shadow-sm py-3 rounded-3 d-flex flex-column mb-3">
                    {if $VIEWING_LIST == "group" || $MEMBER_LISTS_VIEWING|count}
                        {if $VIEWING_LIST == "group"}
                            <h5 class="mx-3">{$VIEWING_GROUP.name}</h5>                    
                            <ul id="member_list_group_{$VIEWING_GROUP.id}" class="list-group list-group-flush"></ul>
                        {else}
                            {foreach from=$MEMBER_LISTS_VIEWING item=list}
                                <div class="d-flex flex-column {if $list@last != true}mb-3{/if}">
                                    <h5 class="mx-3">{$list->getFriendlyName()}</h5>
                                    <ul id="member_list_{$list->getName()}" class="list-group list-group-flush"></ul>
                                    
                                    <div class="mx-auto mt-2">{$PAGINATION}</div>
                                </div>
                            {/foreach}
                        {/if}
                    {/if}
                </div>
            {else}
                {if $MEMBER_LISTS_VIEWING|count == false}
                    <div class="bg-body border-3 border-start border-warning d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
                        <div class="text-warning text-center rounded-3 fv-small fw-bold me-3">
                            <i class="bi bi-exclamation-circle-fill fs-2"></i>
                        </div>
                        <div class="text-body-secondary">
                            {$NO_OVERVIEW_LISTS_ENABLED}
                        </div>
                    </div>
                {else}
                    <div class="row">
                        {foreach from=$MEMBER_LISTS_VIEWING item=list}
                            <div class="col-12 col-md-6">
                                <div class="bg-body shadow-sm rounded-3 d-flex flex-column mb-3">                
                                    <h5 class="mx-3 mt-3">{$list->getFriendlyName()}</h5>
                                        
                                    <ul id="member_list_{$list->getName()}" class="list-group list-group-flush"></ul>

                                    <a class="btn btn-dark dark-border w-100 rounded-top-0" href="{$list->url()}">{$VIEW_ALL}</a>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                {/if}
            {/if}
        </div>
    </div>
{/block}


{block name=beforeJS}
    <script>
        $(document).ready(() => {
            let selects2 = document.querySelectorAll("[data-toggle='select2']");

            [...selects2].map(s2el => {
                $(s2el).select2({
                    theme: 'bootstrap-5',                    
                });
            })


            {if $VIEWING_LIST == "group"}
                renderList('group_{$VIEWING_GROUP.id}');
            {else}
                {foreach from=$MEMBER_LISTS_VIEWING item=list}
                    renderList('{$list->getName()}');
                {/foreach}
            {/if}
        });

        $('#searchMemberInput').select2({
            placeholder: '{$NAME}',
            selectionCssClass: 'search-select2-bg',
            theme: 'bootstrap-5',
            ajax: {
                url: '{$SEARCH_URL}',
                delay: 500,
                minimumInputLength: 2,
                data: function (params) {
                    var query = {
                        search: params.term,
                        limit: 5
                    }
                    return query;
                },
                processResults: function (data) {
                    if (data.error == undefined && data.results != undefined) {
                        return data;
                    }

                    return {
                        results: []
                    };
                }
            },
            templateSelection: function (user) {
                if (user.profile_url != undefined){
                    window.location.href = user.profile_url;
                    return user.username;
                }

                return user.text;
            },
            templateResult: function select2Template(user) {
                if (!user.id) {
                    return user.text;
                }
                var $user = $(
                    '<div class="align-items-center d-flex text-decoration-none text-reset"><img src="'+user.avatar_url+'" class="img-flag me-2 object-fit-contain rounded-circle" style="width: 2rem;height: 2rem;"> <span class="d-flex flex-column"><span>'+user.username+'</span><small class="text-body-secondary" style="font-size: .5rem;">'+user.nickname+'</small></span></div>'
                );
                return $user;
            }
        });

        const viewGroup = (e) => {
            window.location.href = '{$VIEW_GROUP_URL}' + e.value;
        }


    const renderList = (name) => {
        const list = document.getElementById('member_list_' + name);
        list.innerHTML = '<div class="spinner-border mx-auto my-3" role="status"><span class="visually-hidden">Loading...</span></div>';

        fetch('{$QUERIES_URL}'.replace({literal}'{{list}}'{/literal}, name).replace({literal}'{{page}}'{/literal}, new URLSearchParams(window.location.search).get('p') ?? 1))
            .then(async response => {
                const data = await response.json();
                if (data.length === 0) {
                    list.innerHTML = '<div class="bg-body border-3 mx-3 border-start border-danger d-flex flex-row rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message"><div class="text-danger text-center rounded-3 fv-small fw-bold me-3"><i class="bi bi-x-circle-fill fs-2"></i> </div> <div class="text-body-secondary">{$NO_MEMBERS_FOUND}</div></div>';
                    return;
                }

                list.innerHTML = '';

                for (const member of data) {
                    const mainDiv = document.createElement('div');
                    mainDiv.classList.add('list-group-item', 'list-group-item-action', 'd-flex', 'flex-row', 'align-items-center');
                    mainDiv.onclick = () => window.location.href = member.profile_url;
                    mainDiv.style.cursor = 'pointer';

                    const countDiv = document.createElement('div');
                    countDiv.classList.add('order-last', 'ms-auto');

                    if (member.count !== null) {
                        const countHeader = document.createElement('h3');
                        countHeader.classList.add('mb-0');
                        countHeader.innerText = member.count;
                        countDiv.appendChild(countHeader);
                        mainDiv.appendChild(countDiv);
                    }

                    const contentDiv = document.createElement('div');
                    contentDiv.classList.add('d-flex', 'flex-column', 'flex-nowrap');
                    contentDiv.style.overflow = 'hidden';
                    contentDiv.style.textOverflow = 'ellipsis';

                    const avatarDiv = document.createElement('img');
                    avatarDiv.classList.add('rounded-circle', 'me-2');
                    avatarDiv.setAttribute('src', member.avatar_url);
                    avatarDiv.setAttribute('style', 'width: 2.5rem;height: 2.5rem;');
                    
                    mainDiv.appendChild(avatarDiv);

                    const nameDiv = document.createElement('span');
                    nameDiv.style = member.group_style?.replace('&#039;', "'")?.replace('&quot;', '"');

                    nameDiv.innerText = member.username;
                    
                    contentDiv.appendChild(nameDiv);

                    {if $VIEWING_LIST != "overview"}
                        const metaDiv = document.createElement('small');
                        metaDiv.classList.add('text-body-secondary');

                        const metaSpan = document.createElement('span');
                        const memberMeta = member.metadata;
                        metaSpan.innerHTML = Object.keys(memberMeta).map(key => key + ': ' + memberMeta[key]).join(' &middot; ');

                        metaDiv.appendChild(metaSpan);
                        contentDiv.appendChild(metaDiv);
                    {/if}
                    mainDiv.appendChild(contentDiv);
                    list.appendChild(mainDiv)
                }
        });
    }
    </script>
{/block}



{include file='header.tpl'}
{include file='navbar.tpl'}

<h2 class="ui header">
    {$MEMBERS}
</h2>

<br />

{if isset($ERROR)}
<div class="ui error icon message">
    <i class="x icon"></i>
    <div class="content">
        <div class="header">{$ERROR_TITLE}</div>
        {$ERROR}
    </div>
</div>
{/if}

<div class="ui stackable equal width grid">
    <div class="ui centered row">
        <div class="ui four wide column">
            <div class="ui fluid vertical menu pointing">
                
            </div>
            <div class="ui fluid card">
                <div class="content">
                    
                </div>
            </div>
            <div class="ui fluid card">
                <div class="content">
                    <h4 class="ui header">{$NEW_MEMBERS}</h4>
                    <div class="description">
                        <div class="ui four column grid" id="new-members-grid">
                            {foreach from=$NEW_MEMBERS_VALUE item=member}
                                <div class="column">
                                    <a href="{$member->getProfileUrl()}" data-toggle="popup" data-poload="{$USER_INFO_URL}{$member->data()->id}">
                                        <img class="ui circular image" src="{$member->getAvatar()}" alt="{$member->getDisplayname()}">
                                    </a>
                                </div>
                            {/foreach}
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="ui column">
            
        </div>
    </div>
</div>

<script type="text/javascript">

    window.onload = () => {
        {if $VIEWING_LIST == "group"}
            renderList('group_{$VIEWING_GROUP.id}');
        {else}
            {foreach from=$MEMBER_LISTS_VIEWING item=list}
                renderList('{$list->getName()}');
            {/foreach}
        {/if}
    }
</script>

{include file='footer.tpl'}
