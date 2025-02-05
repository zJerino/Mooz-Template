{extends file="base/empty.tpl"}

{assign var="minecraft_avatar_url" value='https://cravatar.eu/helmavatar/'}

{*
    Proximo:
    - Agregar:
    <div class="ui top right pointing dropdown small primary button">
        <span class="text">{$SHARE}</span>
        <i class="dropdown icon"></i>
        <div class="menu">
            <div class="header">{$SHARE}</div>
            <a class="item" href="{$SHARE_TWITTER_URL}">{$SHARE_TWITTER}</a>
            <a class="item" href="{$SHARE_FACEBOOK_URL}">{$SHARE_FACEBOOK}</a>
        </div>
    </div>
*}

{block name='content'}
    {if isset($SESSION_SUCCESS_POST)}
        <div class="align-items-center bg-body border-3 border-start border-success d-flex mb-3 p-2 rounded-3 shadow-sm">
            <i class="bi bi-check-circle-fill text-success fs-2"></i>
            <div class="ms-2">
                <div class="d-inline-flex fw-medium me-2 text-success-emphasis">{$SUCCESS}</div>
                {$SESSION_SUCCESS_POST}
            </div>
        </div>
    {/if}
    {if isset($SESSION_FAILURE_POST)}
        <div class="align-items-center bg-body border-3 border-danger border-start d-flex mb-3 p-2 rounded-3 shadow-sm">
            <i class="bi bi-x-circle-fill fs-2 text-danger"></i>
            <div class="ms-2">
                <div class="d-inline-flex fw-medium me-2 text-danger-emphasis">{$ERROR}</div>
                {$SESSION_FAILURE_POST}
            </div>
        </div>
    {/if}

    {if isset($ERRORS)}
        <div class="align-items-center bg-body border-3 border-danger border-start d-flex mb-3 p-2 rounded-3 shadow-sm">
            <i class="bi bi-x-circle-fill fs-2 text-danger"></i>
            <div class="d-flex flex-column ms-2">
                <div class="d-flex fw-medium me-2 text-danger-emphasis">{$ERROR_TITLE}</div>
                <ul class="list">
                    {foreach from=$ERRORS item=error}
                    <li>{$error}</li>
                    {/foreach}
                </ul>
            </div>
        </div>
    {/if}

    {if isset($TOPIC_LOCKED_NOTICE)}
        <div class="align-items-center bg-body border-3 border-warning border-start d-flex mb-3 p-2 rounded-3 shadow-sm">
            <i class="bi bi-exclamation-circle-fill fs-2 text-warning"></i>
            <div class="ms-2">
                <div class="d-inline-flex fw-medium me-2 text-warning-emphasis">{$TOPIC_LOCKED_NOTICE}</div>
            </div>
        </div>
    {elseif isset($TOPIC_LOCKED)}
        <div class="align-items-center bg-body border-3 border-warning border-start d-flex mb-3 p-2 rounded-3 shadow-sm">
            <i class="bi bi-lock fs-2 text-warning"></i>
            <div class="ms-2">
                <div class="d-inline-flex fw-medium me-2 text-warning-emphasis">{$TOPIC_LOCKED}</div>
            </div>
        </div>
    {/if}
    
    <div class="d-flex flex-column bg-body rounded-3 shadow-sm mb-3">
        <nav class="mx-3 my-2 p-2 rounded-3 bg-body-tertiary" style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='%236c757d'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb">
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
        <div class="d-flex align-items-center px-3 flex-column flex-md-row">
            <div class="d-flex flex-column">
                <div class="d-flex align-items-center">
                    {if count($TOPIC_LABELS)}
                        {foreach from=$TOPIC_LABELS item=label}{$label}{/foreach}
                    {/if}

                    <div class="fs-4 ms-1">
                        {$TOPIC_TITLE|capitalize}
                    </div>
                </div>
                <div class="text-body-secondary">
                    <i class="bi bi-person"></i> {$STARTED_BY}
                </div>
            </div>
            <div class="ms-auto d-flex">
                {if isset($UNFOLLOW)}
                    <form action="{$UNFOLLOW_URL}" method="post" style="display: inline">
                        <input type="hidden" value="{$TOKEN}" name="token" />
                        <button class="btn btn-dark dark-border"><i class="bi bi-bell"></i> <span class="d-none d-md-inline-block">{$UNFOLLOW}</span> </button>
                    </form>
                {elseif isset($FOLLOW)}
                    <form action="{$FOLLOW_URL}" method="post" style="display: inline">
                        <input type="hidden" value="{$TOKEN}" name="token" />
                        <button class="btn btn-dark dark-border"><i class="bi bi-bell"></i> <span class="d-none d-md-inline-block">{$FOLLOW}</span> </button>                
                    </form>
                {/if}

                {if isset($CAN_MODERATE) && $CAN_MODERATE}
                    <div class="dropdown ms-1">
                        <button class="btn btn-outline-danger dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                            {$MOD_ACTIONS}
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item cursor-pointer" data-bs-toggle="modal"  data-bs-target="#modal-delete">{$DELETE}</a></li>
                            <li><a class="dropdown-item cursor-pointer" onclick="document.getElementById('lockTopic').submit()">{$LOCK}</a></li>
                            <li><a class="dropdown-item cursor-pointer" onclick="document.getElementById('stickTopic').submit()">{$STICK}</a></li>
                            <li><a class="dropdown-item cursor-pointer" href="{$MERGE_URL}">{$MERGE}</a></li>
                            <li><a class="dropdown-item cursor-pointer" href="{$MOVE_URL}">{$MOVE}</a></li>
                        </ul>
                    </div>
                {/if}
            </div>
        </div>

        <div class="d-flex flex-column mb-2">
            {foreach from=$REPLIES item=reply}
                <div class="rounded-3 bg-body-tertiary shadow-sm d-flex flex-column mx-3 mt-3" id="topic-post" post-id="{$reply.id}">
                    <div class="row g-0">
                        <div class="col-12 col-md-3 border-end border-dark-subtle border-1 ASDdHSDgbb">
                            <div class="d-flex flex-column align-items-center m-3">
                                <a href="{$reply.profile}" class="mb-1 mx-auto">
                                    <img class="rounded-5" src="{$reply.avatar}" alt="{$reply.username}" style="width: 3rem;height: 3rem" />
                                </a>

                                <h6 class="d-flex flex-column mb-2">
                                    <a href="{$reply.profile}" class="mx-auto mb-1" style="text-decoration: none; {$reply.user_style}">{$reply.username}</a>
                                    {if isset($reply.user_title)}
                                        <div class="text-body-secondary mx-auto">{$reply.user_title}</div>
                                    {/if}
                                </h6>

                                <div class="d-flex flex-column w-100">
                                    {foreach from=$reply.user_groups item=group}
                                        <div class="d-flex flex-column mb-1">{$group}</div>
                                    {/foreach}
                                </div>

                                <div class="d-flex flex-column mt-2 w-100">
                                    <a class="p-2 text-center text-reset" type="button" data-bs-toggle="collapse" data-bs-target="#collapseMoreInfo-{$reply.id}" aria-expanded="false" aria-controls="collapseMoreInfo-{$reply.id}">
                                        <i class="bi bi-three-dots"></i>
                                    </a>
                                    <div class="collapse" id="collapseMoreInfo-{$reply.id}">
                                        <div class="d-flex flex-column">
                                            {if isset($reply.integrations.Minecraft)}
                                                <div class="border-1 border rounded-2 p-2 d-flex align-items-center mb-2">
                                                    <img src="{$minecraft_avatar_url}{$reply.integrations.Minecraft.identifier}" class="rounded-2" style="width: 1.25rem;height: 1.25rem" alt="{$reply.integrations.Minecraft.username}">
                                                    <small class="d-flex text-wrap fw-bold ms-2 w-100">
                                                        {$reply.integrations.Minecraft.username}
                                                    </small>
                                                </div>
                                            {/if}

                                            <div class="list-group list-group-flush rounded-3">
                                                <li class="list-group-item d-flex flex-xl-row flex-row align-items-center text-body-secondary" data-bs-toggle="tooltip" title="{$reply.user_registered}">
                                                    <i class="bi bi-person-plus me-2"></i>
                                                    <div class="d-flex flex-column ms-auto">
                                                        <small class="ms-auto fw-medium">{$reply.user_registered_full}</small>
                                                    </div>
                                                </li>
                                                <li class="list-group-item d-flex flex-xl-row flex-row align-items-center text-body-secondary">
                                                    <i class="bi bi-star me-2"></i>
                                                    <div class="d-flex flex-column ms-auto">
                                                        <small class="ms-auto fw-medium">{$reply.user_reputation}</small>
                                                    </div>
                                                </li>
                                                <li class="list-group-item d-flex flex-xl-row flex-row align-items-center text-body-secondary" data-bs-toggle="tooltip" title="{$reply.user_topics_count|capitalize}">
                                                    <i class="bi bi-chat-left-text me-2"></i>
                                                    <div class="d-flex flex-column ms-auto">
                                                        <small class="ms-auto fw-medium">{$reply.user_topics_count|regex_replace:'/[^0-9]+/':''}</small>
                                                    </div>
                                                </li>

                                                <li class="list-group-item d-flex flex-xl-row flex-row align-items-center text-body-secondary" data-bs-toggle="tooltip" title="{$reply.user_posts_count|capitalize}">
                                                    <i class="bi bi-chat-right-text me-2"></i>
                                                    <div class="d-flex flex-column ms-auto">
                                                        <small class="ms-auto fw-medium">{$reply.user_posts_count|regex_replace:'/[^0-9]+/':''}</small>
                                                    </div>
                                                </li>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 col-md-9 d-flex flex-column">
                            <div class="d-flex border-bottom border-1 border-dark-subtle p-2">
                                <div class="d-flex align-items-center" data-bs-toggle="tooltip" title="{$reply.post_date_rough}">
                                    <i class="bi bi-clock me-1"></i> <small class="text-body-secondary">{$reply.post_date}</small>
                                </div>
                                {if $reply.edited !== null}
                                    <span class="ms-2" data-bs-toggle="tooltip" title="{$reply.edited_full}">
                                        <i class="bi bi-pencil-square me-1"></i>
                                        <small class="text-body-secondary d-none d-md-inline-flex">{$reply.edited}</small>
                                    </span>
                                {/if}

                                <a class="d-flex align-items-center ms-auto text-body-secondary text-decoration-none" href="{$reply.url}">
                                    <small>#{$reply.id}</small>
                                </a>
                            </div>
                            <div class="d-flex flex-column flex-grow-1">
                                <div class="forum_post m-3">{$reply.content}</div>
                                {if !empty($reply.signature)}
                                    <div style="overflow: auto; max-height: 500px;">
                                        {$reply.signature}
                                    </div>
                                {/if}
                            </div>


                            {if (isset($LOGGED_IN_USER) || count($reply.post_reactions) > 0)}
                                <div class="d-flex border-top border-1 border-dark-subtle p-2">
                                    <div class="d-flex flex-column" data-toggle="modal" data-target="#modal-reactions-{$reply.id}">                            
                                        {if (isset($LOGGED_IN_USER) && $reply.user_id !== $USER_ID || count($reply.post_reactions))}
                                            <div class="d-flex" id="reactions">
                                                {if count($reply.post_reactions)}
                                                    {assign i 1}
                                                    {foreach from=$reply.post_reactions name=reactions key=key item=reaction}
                                                        <div class="border-1 border rounded-2 py-1 m-1 px-2 mx-1 align-items-center d-flex {if (isset($LOGGED_IN_USER) && $reply.user_id !== $USER_ID)}cursor-pointer{/if}" {if (isset($LOGGED_IN_USER) && $reply.user_id !== $USER_ID)}data-form-submit="#post-{$reply.id}-r-{$key}"{/if} data-bs-toggle="tooltip" title="{$reaction.name}">{$reaction.html} <span class="ms-1 text-body-secondary">{$reaction.count}</span></div>
                                                        {assign i $i+1}
                                                    {/foreach}
                                                {/if}
                                                {if (isset($LOGGED_IN_USER) && $reply.user_id !== $USER_ID)}
                                                    {if isset($REACTIONS) && count($REACTIONS)}
                                                        <a class="border-1 border rounded-2 py-1 px-2 m-1 cursor-pointer text-reset" data-bs-toggle="popover" data-bs-html="true" data-bs-title="{$REACTIONS_TEXT}" data-bs-content="..." data-element="#list-reactions-{$reply.id}"> 
                                                            <i class="bi bi-plus fs-5" data-bs-toggle="tooltip" title="{$REACTIONS_TEXT}"></i>
                                                        </a>
                                                        
                                                        <div class="d-none">
                                                            {foreach from=$REACTIONS item=reaction}
                                                                <form action="{$REACTIONS_URL}" method="post" class="d-inline-flex" id="post-{$reply.id}-r-{$reaction->id}" tabindex="1">
                                                                    <input type="hidden" name="token" value="{$TOKEN}">
                                                                    <input type="hidden" name="reaction" value="{$reaction->id}">
                                                                    <input type="hidden" name="post" value="{$reply.id}">
                                                                </form>
                                                            {/foreach}
                                                            <div class="d-flex flex-wrap" id="list-reactions-{$reply.id}">
                                                                {foreach from=$REACTIONS item=reaction}
                                                                    <a class="border-1 border rounded-2 py-2 px-2 m-1 cursor-pointer text-reset cursor-pointer text-decoration-none text-reset align-items-center d-flex" onclick="$('#post-{$reply.id}-r-{$reaction->id}').submit()">
                                                                        {$reaction->html}
                                                                    </a>
                                                                {/foreach}
                                                            </div>
                                                        </div>
                                                    {/if}
                                                {/if}
                                            </div>
                                        {/if}
                                    </div>

                                    <div class="ms-auto d-flex">
                                        {if isset($LOGGED_IN_USER)}
                                            <div class="dropdown">
                                                <button class="btn btn-outline-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                                                    <i class="bi bi-three-dots"></i>
                                                </button>
                                                <ul class="dropdown-menu">
                                                    {if isset($reply.buttons.spam)}
                                                        <li>
                                                            <a href="#" class="dropdown-item" data-bs-toggle="modal" data-bs-target="#modal-spam-{$reply.id}">{$reply.buttons.spam.TEXT}</a>
                                                        </li>
                                                    {/if}
                                                    {if isset($reply.buttons.edit)}
                                                        <li>
                                                            <a class="dropdown-item" href="{$reply.buttons.edit.URL}">{$reply.buttons.edit.TEXT}</a>
                                                        </li>
                                                    {/if}
                                                    {if isset($reply.buttons.delete)}
                                                        <li>
                                                            <a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#modal-delete-{$reply.id}">{$reply.buttons.delete.TEXT}</a>
                                                        </li>
                                                    {/if}
                                                    {if isset($reply.buttons.report)}
                                                        <li>
                                                            <a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#modal-report-{$reply.id}">{$reply.buttons.report.TEXT}</a>
                                                        </li>
                                                    {/if}
                                                    {if isset($reply.buttons.quote)}
                                                        <li>
                                                            <a class="dropdown-item" onclick="quote({$reply.id})">{$reply.buttons.quote.TEXT}</a>                                    
                                                        </li>
                                                    {/if}
                                                </ul>
                                            </div>
                                        {/if}
                                    </div>
                                </div>
                            {/if}
                        </div>
                    </div>
                    <div id="asd">
                        {* Modals *}
                        {if count($reply.post_reactions)}
                            <div class="modal fade" id="modal-reactions-{$reply.id}" tabindex="-1" aria-labelledby="modal-reactions-{$reply.id}-label" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="modal-reactions-{$reply.id}-label">{$REACTIONS_TEXT}</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            {foreach from=$reply.post_reactions name=reactions item=reaction}                        
                                                <strong>{$reaction.html} <span class="ms-2">{$reaction.count}</span></strong>

                                                <div class="list-group list-group-flush">
                                                    {foreach from=$reaction.users item=user}
                                                        <a href="{$user.profile}" class="list-group-item list-group-item-action">
                                                            <div class="d-flex align-items-center w-100">
                                                                <img class="rounded-5 me-2" style="width: 1.3rem;height: 1.3rem" src="{$user.avatar}">
                                                                <div class="d-flex">
                                                                    <a class="text-decoration-none" href="{$user.profile}" style="{$user.style}">{$user.nickname}</a>
                                                                </div>
                                                            </div>
                                                        </a>
                                                    {/foreach}
                                                </div>
                                            {/foreach}
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/if}
                        {if isset($reply.buttons.report)}
                            <div class="modal fade" id="modal-report-{$reply.id}" tabindex="-1" aria-labelledby="modal-report-{$reply.id}-label" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="modal-report-{$reply.id}-label">{$reply.buttons.report.TEXT}</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <form action="{$reply.buttons.report.URL}" method="post" id="form-report-{$reply.id}">
                                                <div class="d-flex flex-column">
                                                    <div class="mb-3">
                                                        <label class="form-label" for="InputReason">{$reply.buttons.report.REPORT_TEXT}</label>
                                                        <textarea class="form-control" id="InputReason" name="reason"></textarea>
                                                    </div>
                                                    <input type="hidden" name="post" value="{$reply.id}">
                                                    <input type="hidden" name="topic" value="{$TOPIC_ID}">
                                                    <input type="hidden" name="token" value="{$TOKEN}">

                                                    <div class="d-flex flex-column mx-auto">
                                                        <button type="submit" class="btn btn-primary rounded-5 w-100 mb-2 px-5">{$reply.buttons.report.TEXT}</button>
                                                        <a class="btn btn-danger rounded-5" data-bs-dismiss="modal" aria-label="Close">{$CANCEL}</a>
                                                    </div>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/if}
                        {if isset($CAN_MODERATE)}
                            <div class="modal fade" id="modal-spam-{$reply.id}" tabindex="-1" aria-labelledby="modal-spam-{$reply.id}-label" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="modal-spam-{$reply.id}-label">{$MARK_AS_SPAM}</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <span class="mb-3">{$CONFIRM_SPAM_POST}</span>
                                            <form action="{$reply.buttons.spam.URL}" method="post" id="form-spam-{$reply.id}">
                                                <input type="hidden" name="post" value="{$reply.id}">
                                                <input type="hidden" name="token" value="{$TOKEN}">

                                                <div class="d-flex flex-column mx-auto">
                                                    <button type="submit" class="btn btn-primary rounded-5 w-100 mb-2 px-5">{$MARK_AS_SPAM}</button>
                                                    <a class="btn btn-danger rounded-5" data-bs-dismiss="modal" aria-label="Close">{$CANCEL}</a>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="modal fade" id="modal-delete-{$reply.id}" tabindex="-1" aria-labelledby="modal-delete-{$reply.id}-label" aria-hidden="true">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="modal-delete-{$reply.id}-label">{$CONFIRM_DELETE_SHORT}</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <span class="mb-3">{$CONFIRM_DELETE_POST}</span>

                                            <form action="{$reply.buttons.delete.URL}" method="post" id="form-delete-{$reply.id}">
                                                <input type="hidden" name="tid" value="{$TOPIC_ID}">
                                                <input type="hidden" name="number" value="{$reply.buttons.delete.NUMBER}">
                                                <input type="hidden" name="pid" value="{$reply.id}">
                                                <input type="hidden" name="token" value="{$TOKEN}">


                                                <div class="d-flex flex-column mx-auto">
                                                    <button type="submit" class="btn btn-primary rounded-5 w-100 mb-2 px-5">{$reply.buttons.delete.TEXT}</button>
                                                    <a class="btn btn-danger rounded-5" data-bs-dismiss="modal" aria-label="Close">{$CANCEL}</a>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        {/if}

                        {* Moderacion *}
                        {if isset($CAN_MODERATE)}
                            <form action="{$LOCK_URL}" method="post" id="lockTopic" style="display: none">
                                <input type="hidden" value="{$TOKEN}" name="token" />
                            </form>
                            <form action="{$STICK_URL}" method="post" id="stickTopic" style="display: none">
                                <input type="hidden" value="{$TOKEN}" name="token" />
                            </form>
                        {/if}
                    </div>
                </div>

            {/foreach}
        </div>
    </div>

    {if isset($PAGINATION)}
        <div class="d-flex mb-3">
            <div class="mx-auto">{$PAGINATION}</div>
        </div>
    {/if}

    {if isset($CAN_REPLY)}
        <div class="bg-body rounded-3 shadow-sm p-3 d-flex flex-column" id="topic-reply">
            <div class="container">
                <h1 class="fs-5 mb-3 d-flex align-items-center justify-content-center">
                    <span class="mx-1 text-primary">&bull;</span>
                    {$NEW_REPLY}
                    <span class="mx-1 text-primary">&bull;</span>
                </h1>
                <div class="row justify-content-center">
                    <div class="col-12" id="reply-content">
                        <form class="d-flex flex-column" action="" method="post">
                            <div class="mb-2">
                                <textarea name="content" class="form-control" id="quickreply"></textarea>
                            </div>
                            <input type="hidden" name="token" value="{$TOKEN}">
                            <button class="btn btn-primary rounded-5 mx-auto px-5" type="submit">{$SUBMIT}</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    {/if}
{/block}

{foreach from=$REPLIES item=reply}
<div class="ui segments" id="topic-post" post-id="{$reply.id}">
    <div class="ui attached padded segment">
        <div class="ui stackable grid">
            <div class="ui row">
                <div class="ui five wide tablet three wide computer column" id="post-sidebar">
                    <center>
                        <a href="{$reply.profile}"><img class="ui small circular image" src="{$reply.avatar}"
                                alt="{$reply.username}" /></a>
                        <h3 class="ui header">
                            <a href="{$reply.profile}" style="{$reply.user_style}">{$reply.username}</a>
                            {if isset($reply.user_title)}
                            <div class="sub header">{$reply.user_title}</div>
                            {/if}
                        </h3>
                    </center>
                    <div class="groups">
                        {foreach from=$reply.user_groups item=group}
                        {$group}
                        {/foreach}
                    </div>
                    <div class="ui list">
                        <div class="ui divider"></div>
                        <div class="item">
                            <div class="content">
                                <div class="header">{$reply.user_registered|regex_replace:'/[:].*/':''}</div>
                                <div class="res right floated description">{$reply.user_registered_full}</div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="content">
                                <div class="header">{$reply.last_seen|regex_replace:'/[:].*/':''}</div>
                                <div class="res right floated description">{$reply.last_seen_full}</div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="content">
                                <div class="header">{$reply.user_topics_count|regex_replace:'/[0-9]+/':''|capitalize}
                                </div>
                                <div class="res right floated description">
                                    {$reply.user_topics_count|regex_replace:'/[^0-9]+/':''}</div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="content">
                                <div class="header">{$reply.user_posts_count|regex_replace:'/[0-9]+/':''|capitalize}
                                </div>
                                <div class="res right floated description">
                                    {$reply.user_posts_count|regex_replace:'/[^0-9]+/':''}</div>
                            </div>
                        </div>
                    </div>
                    {if count($reply.fields)}
                    <div class="ui list">
                        <div class="ui divider"></div>
                        {foreach from=$reply.fields item=field}
                        {if !empty($field->value)}
                        <div class="item">
                            <div class="content">
                                <div class="header">{$field->name}</div>
                                <div class="res right floated description">{$field->value}</div>
                            </div>
                        </div>
                        {/if}
                        {/foreach}
                    </div>
                    {/if}
                </div>
                <div class="ui eleven wide tablet thirteen wide computer column" id="post-content">
                    <div class="forum_post">{$reply.content}</div>
                    
                </div>
            </div>
        </div>
    </div>
    <div class="ui bottom attached secondary segment" id="post-meta">
        <a href="{$reply.profile}" data-poload="{$USER_INFO_URL}{$reply.user_id}"
            style="{$reply.user_style}">{$reply.username}</a> &middot; <span data-toggle="tooltip"
            data-content="{$reply.post_date}">{$reply.post_date_rough}</span>
        
        <div class="res right floated">
            
        </div>
    </div>
</div>
{/foreach}

{if isset($TOPIC_LOCKED_NOTICE)}
<div class="ui tiny warning message">
    {$TOPIC_LOCKED_NOTICE}
</div>
{/if}

{$PAGINATION}

{if isset($CAN_REPLY)}
<div class="ui padded segment" id="topic-reply">
    <div class="ui stackable grid">
        <div class="ui row">
            <div class="ui five wide tablet three wide computer column" id="reply-sidebar">
                <center>
                    <img class="ui small circular image" src="{$LOGGED_IN_USER.avatar}" />
                    <h3 class="ui header">
                        <a href="{$LOGGED_IN_USER.profile}"
                            style="{$LOGGED_IN_USER.username_style}">{$LOGGED_IN_USER.username}</a>
                    </h3>
                </center>
            </div>
            <div class="ui eleven wide tablet thirteen wide computer column" id="reply-content">
                <form class="ui form" action="" method="post">
                    <div class="field">
                        <textarea name="content" id="quickreply"></textarea>
                    </div>
                    <input type="hidden" name="token" value="{$TOKEN}">
                    <button class="ui primary button" type="submit">{$SUBMIT}</button>
                </form>
            </div>
        </div>
    </div>
</div>
{/if}

{foreach from=$REPLIES item=reply}
{if count($reply.post_reactions)}
<div class="ui small modal" id="modal-reactions-{$reply.id}">
    <div class="header">
        {$REACTIONS_TEXT}
    </div>
    <div class="content">
        {foreach from=$reply.post_reactions name=reactions item=reaction}
        <strong>{$reaction.html} x {$reaction.count}:</strong>
        <br />
        <div class="ui middle aligned small list">
            {foreach from=$reaction.users item=user}
            <div class="item">
                <img class="ui avatar image" src="{$user.avatar}">
                <div class="content">
                    <a class="header" href="{$user.profile}">{$user.nickname}</a>
                </div>
            </div>
            {/foreach}
        </div>
        {/foreach}
    </div>
</div>
{/if}

{if isset($reply.buttons.report)}
<div class="ui small modal" id="modal-report-{$reply.id}">
    <div class="header">
        {$reply.buttons.report.TEXT}
    </div>
    <div class="content">
        <form action="{$reply.buttons.report.URL}" method="post" id="form-report-{$reply.id}">
            <div class="ui form">
                <div class="field">
                    <label for="InputReason">{$reply.buttons.report.REPORT_TEXT}</label>
                    <textarea id="InputReason" name="reason"></textarea>
                </div>
                <input type="hidden" name="post" value="{$reply.id}">
                <input type="hidden" name="topic" value="{$TOPIC_ID}">
                <input type="hidden" name="token" value="{$TOKEN}">
            </div>
        </form>
    </div>
    <div class="actions">
        <a class="ui negative button">{$CANCEL}</a>
        <a class="ui positive button" onclick="$('#form-report-{$reply.id}').submit();">{$reply.buttons.report.TEXT}</a>
    </div>
</div>
{/if}
{if isset($CAN_MODERATE)}
<div class="ui small modal" id="modal-spam-{$reply.id}">
    <div class="header">
        {$MARK_AS_SPAM}
    </div>
    <div class="content">
        {$CONFIRM_SPAM_POST}
        <form action="{$reply.buttons.spam.URL}" method="post" id="form-spam-{$reply.id}">
            <input type="hidden" name="post" value="{$reply.id}">
            <input type="hidden" name="token" value="{$TOKEN}">
        </form>
    </div>
    <div class="actions">
        <a class="ui negative button">{$CANCEL}</a>
        <a class="ui positive button" onclick="$('#form-spam-{$reply.id}').submit();">{$MARK_AS_SPAM}</a>
    </div>
</div>
<div class="ui small modal" id="modal-delete-{$reply.id}">
    <div class="header">
        {$CONFIRM_DELETE_SHORT}
    </div>
    <div class="content">
        {$CONFIRM_DELETE_POST}
        <form action="{$reply.buttons.delete.URL}" method="post" id="form-delete-{$reply.id}">
            <input type="hidden" name="tid" value="{$TOPIC_ID}">
            <input type="hidden" name="number" value="{$reply.buttons.delete.NUMBER}">
            <input type="hidden" name="pid" value="{$reply.id}">
            <input type="hidden" name="token" value="{$TOKEN}">
        </form>
    </div>
    <div class="actions">
        <a class="ui negative button">{$CANCEL}</a>
        <a class="ui positive button" onclick="$('#form-delete-{$reply.id}').submit();">{$reply.buttons.delete.TEXT}</a>
    </div>
</div>
{/if}
{/foreach}

{if isset($CAN_MODERATE)}
<div class="ui small modal" id="modal-delete">
    <div class="header">
        {$CONFIRM_DELETE_SHORT}
    </div>
    <div class="content">
        {$CONFIRM_DELETE}
    </div>
    <div class="actions">
        <a class="ui negative button">{$CANCEL}</a>

        <form action="{$DELETE_URL}" method="post" id="deleteTopic" style="display: none">
            <input type="hidden" value="{$TOKEN}" name="token" />
        </form>
        <a type="submit" class="ui positive button"
            onclick="document.getElementById('deleteTopic').submit()">{$DELETE}</a>
    </div>
</div>
{/if}
