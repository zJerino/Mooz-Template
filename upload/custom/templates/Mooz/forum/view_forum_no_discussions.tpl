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
                    {foreach from=$SUBFORUMS item=subforum}
                        <div class="list-group-item list-group-item-action d-flex">
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
                                                    <img class="rounded-5" src="{$subforum.latest_post.last_user_avatar}" alt="{$subforum.latest_post.last_user}" style="width: 2rem;height: 2rem;">
                                                </div>

                                                <div class="col d-flex flex-column">
                                                    <a href="{$subforum.latest_post.link}" class="text-decoration-none">{$subforum.latest_post.title}</a>
                                                    <div class="text-body-secondary">
                                                        <small>{$BY|capitalize}</small>
                                                        <a style="text-decoration: none; {$subforum.latest_post.last_user_style}" href="{$subforum.latest_post.last_user_link}"><small>{$subforum.latest_post.last_user}</small></a>
                                                        &bull;
                                                        <small class="text-body-secondary" data-bs-toggle="tooltip" title="{$subforum.latest_post.timeago}">
                                                            {$subforum.latest_post.time}
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
                        </div>
                    {/foreach}
                </div>
            </div>
        {/if}
        <div class="d-flex align-items-center me-2">
            <h3 class="text-primary me-2 fs-1 m-0 mb-1">&bull;</h3>
            <h6 class="m-0 text-body">{$TOPICS|capitalize}</h6>
        </div>
        <div class="bg-body border-3 border-start border-info d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-info text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-exclamation-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                {$NO_TOPICS_FULL}
            </div>
        </div>
    </div>
{/block}
