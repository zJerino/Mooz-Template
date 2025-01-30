{extends file="base/widgets.tpl"}

{block name='content'}
    <div class="rounded-3 bg-body p-2 mb-3 d-flex">
        <nav class="me-2" style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='%236c757d'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
            <ol class="breadcrumb mb-0">
                {assign i 1}
                {foreach from=$BREADCRUMBS item=breadcrumb}
                    <li class="breadcrumb-item{if isset($breadcrumb.active)} active{/if}"{if isset($breadcrumb.active)} aria-current="page"{/if}>
                        <a class="text-decoration-none" href="{$breadcrumb.link}">{$breadcrumb.forum_title}</a>
                    </li>
                    {assign i $i+1}
                {/foreach}
            </ol>
        </nav>
        <div class="ms-auto">
            <a href="{$SEARCH_URL}" class="p-2 text-reset" data-bs-toggle="tooltip" title="{$SEARCH}">
                <i class="bi bi-search"></i>
            </a>
        </div>
    </div>
    
    <div class="d-flex  align-items-center">
        <div class="d-flex align-items-center me-2">
            <h3 class="text-primary me-2 fs-1 m-0 mb-1">&bull;</h3>
            <h4 class="m-0 text-body">{$FORUM_TITLE}</h4>
        </div>

        {if $NEW_TOPIC_BUTTON}
            <div class="ms-auto">
                <a class="btn btn-primary rounded-5 px-4 d-flex" href="{$NEW_TOPIC_BUTTON}" data-bs-toggle="tooltip" title="{$NEW_TOPIC}">
                    <i class="bi bi-plus me-2"></i>
                    <span class="d-none d-md-block">{$NEW_TOPIC}</span>
                </a>
            </div>
        {/if}
    </div>
    
    <div class="d-flex flex-column mb-3">
        {if count($SUBFORUMS)}
            <div class="d-flex align-items-center me-2">
                <h3 class="text-primary me-2 fs-1 m-0 mb-1">&bull;</h3>
                <h6 class="m-0 text-body">{$SUBFORUM_LANGUAGE|capitalize}</h6>
            </div>
            <div class="bg-body shadow-sm py-2 d-flex flex-column rounded-3 mb-3">
                <div class="list-group list-group-flush">
                    <div class="list-group-item list-group-item-action d-flex">
                        {foreach from=$SUBFORUMS item=subforum}
                            <div class="row w-100 align-items-center">
                                <div class="fs-4 col-1 text-center">
                                    {if empty($subforum.icon)}<i class="bi bi-chat"></i>{else}{$subforum.icon}{/if}
                                </div>
                                <div class="col-5 d-flex flex-column">
                                    <a class="fs-6 text-reset text-decoration-none" href="{$subforum.link}">{$subforum.title}</a>
                                    {if !$subforum.redirect}<small class="text-body-secondary">{$TOPICS|capitalize}: {$subforum.topics}</small>{/if}
                                </div>
                                <div class="col-6">
                                    {if !$subforum.redirect}    
                                        <div class="row align-items-center w-100">                                
                                            {if !empty($subforum.latest_post)}
                                                <div class="col-2">
                                                    <img class="rounded-5" src="{$subforum.latest_post.avatar}" alt="{$subforum.latest_post.username}" style="width: 2rem;height: 2rem;">
                                                </div>

                                                <div class="col d-flex flex-column">
                                                    <a href="{$subforum.latest_post.link}" class="text-decoration-none">{$subforum.latest_post.title}</a>
                                                    <div class="text-body-secondary">
                                                        <small>{$BY|capitalize}</small>
                                                        <a style="text-decoration: none; {$subforum.latest_post.user_style}" href="{$subforum.latest_post.profile}"><small>{$subforum.latest_post.username}</small></a>
                                                        &bull;
                                                        <small class="text-body-secondary">
                                                            {$subforum.latest_post.post_date}
                                                        </small>
                                                    </div>
                                                </div>
                                            {else}
                                                <div class="col text-body-secondary">
                                                    {$NO_TOPICS}                                            
                                                </div>
                                            {/if}
                                        </div>                                    
                                    {/if}
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            </div>
        {/if}

        {if count($STICKY_DISCUSSIONS)}
            <div class="d-flex align-items-center me-2">
                <h3 class="text-primary me-2 fs-1 m-0 mb-1">&bull;</h3>
                <h6 class="m-0 text-body">{$STICKY_TOPICS|capitalize}</h6>
            </div>
            
            {foreach from=$STICKY_DISCUSSIONS item=discussion}
                <div class="bg-body rounded-3 shadow-sm p-2 mb-3">
                    <div class="container-fluid">
                        <div class="row align-items-center">
                            <div class="col-1 d-flex"><i class="bi bi-chat fs-4 mx-auto"></i></div>
                            <div class="col-5">
                                <div class="d-flex flex-column">
                                    <div class="d-flex">
                                            {if isset($discussion.labels) && count($discussion.labels)}
                                            {foreach from=$discussion.labels item=label}
                                                {$label}
                                            {/foreach}
                                        {/if}
                                        <a href="{$discussion.link}" class="text-reset text-decoration-none fw-semibold">{$discussion.topic_title}</a>
                                    </div>
                                    <div class="d-flex align-items-center">
                                        <small class="text-body-secondary" data-bs-toggle="tooltip" title="{$discussion.last_reply}">{$discussion.last_reply_rough}</small>
                                    </div>
                                </div>
                            </div>
                            <div class="col-6 d-flex">
                                <div class="d-flex align-items-center ms-auto">
                                    <img class="rounded-5 me-2" src="{$discussion.last_reply_avatar}" style="width: 1.5em;height: 1.5em">
                                    <div class="d-flex flex-column w-100">
                                        <a href="{$discussion.last_reply_link}" data-poload="{$USER_INFO_URL}{$discussion.last_reply_user_id}" style="text-decoration: none; {$discussion.last_reply_style}">{$discussion.last_reply_username}</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {/foreach}
        {/if}

        <div class="d-flex align-items-center me-2">
            <h3 class="text-primary me-2 fs-1 m-0 mb-1">&bull;</h3>
            <h6 class="m-0 text-body">{$TOPICS|capitalize}</h6>
        </div>
        
        {foreach from=$LATEST_DISCUSSIONS item=discussion}
            <div class="bg-body rounded-3 shadow-sm p-2 mb-3">
                <div class="container-fluid">
                    <div class="row align-items-center">
                        <div class="col-1 d-flex"><i class="bi bi-chat fs-4 mx-auto"></i></div>
                        <div class="col-5">
                            <div class="d-flex flex-column">
                                <div class="d-flex">
                                        {if isset($discussion.labels) && count($discussion.labels)}
                                        {foreach from=$discussion.labels item=label}
                                            {$label}
                                        {/foreach}
                                    {/if}
                                    <a href="{$discussion.link}" class="text-reset text-decoration-none fw-semibold">{$discussion.topic_title}</a>
                                </div>
                                <div class="d-flex align-items-center">
                                    <small class="text-body-secondary" data-bs-toggle="tooltip" title="{$discussion.last_reply}">{$discussion.last_reply_rough}</small>
                                </div>
                            </div>
                        </div>
                        <div class="col-6 d-flex">
                            <div class="d-flex align-items-center ms-auto">
                                <img class="rounded-5 me-2" src="{$discussion.last_reply_avatar}" style="width: 1.5em;height: 1.5em">
                                <div class="d-flex flex-column w-100">
                                    <a href="{$discussion.last_reply_link}" data-poload="{$USER_INFO_URL}{$discussion.last_reply_user_id}" style="text-decoration: none; {$discussion.last_reply_style}">{$discussion.last_reply_username}</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                    {* <tr>
                        <td>
                            <h5 class="ui header">
                                <i class="comment icon"></i>
                                <div class="content">
                                    {if isset($discussion.labels) && count($discussion.labels)}
                                    {foreach from=$discussion.labels item=label}
                                    {$label}
                                    {/foreach}
                                    {/if}
                                    <div class="ui wide popup">
                                        <h4 class="ui header">{$discussion.topic_title}</h4>
                                        {$VIEWS|capitalize}: <b>{$discussion.views}</b> &middot; {$POSTS|capitalize}:
                                        <b>{$discussion.posts}</b><br />
                                        {$BY|capitalize} <a href="{$discussion.author_link}"
                                            style="{$discussion.topic_created_style}">{$discussion.topic_created_username}</a>
                                        |
                                        {$discussion.topic_created}
                                    </div>
                                    <div class="sub header">
                                        <a href="{$discussion.author_link}"
                                            data-poload="{$USER_INFO_URL}{$discussion.topic_created_user_id}"
                                            style="{$discussion.topic_created_style}">{$discussion.topic_created_username}</a>
                                        &middot; <span data-toggle="tooltip"
                                            data-content="{$discussion.topic_created}">{$discussion.topic_created_rough}</span>
                                    </div>
                                </div>
                            </h5>
                        </td>
                        <td>
                            {$VIEWS|capitalize}: <span class="right floated"><b>{$discussion.views}</b></span><br />
                            {$POSTS|capitalize}: <span class="right floated"><b>{$discussion.posts}</b></span>
                        </td>
                        <td>
                            <h5 class="ui image header">
                                <img class="ui mini circular image" src="{$discussion.last_reply_avatar}">
                                <div class="content">
                                    <a href="{$discussion.last_reply_link}" data-toggle="popup"
                                        data-poload="{$USER_INFO_URL}{$discussion.last_reply_user_id}"
                                        style="{$discussion.last_reply_style}">{$discussion.last_reply_username}</a>
                                    <div class="sub header" data-toggle="tooltip"
                                        data-content="{$discussion.last_reply}">
                                        {$discussion.last_reply_rough}</div>
                                </div>
                            </h5>
                        </td>
                    </tr> *}
        {/foreach}

        <div class="mx-auto">
        {$PAGINATION}
        </div>
    </div>
{/block}