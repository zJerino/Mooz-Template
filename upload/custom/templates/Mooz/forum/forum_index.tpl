{extends file="base/widgets.tpl"}

{block name='content'}
    {if isset($SPAM_INFO)}
        <div class="bg-body border-3 border-start border-warning d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-warning text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-exclamation-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                <strong class="text-warning me-2">{$FORUM_SPAM_WARNING_TITLE}</strong>
                {$SPAM_INFO}
            </div>
        </div>
    {/if}

    <div class="rounded-3 bg-body p-2 mb-3 d-flex">
        <nav style="--bs-breadcrumb-divider: url(&#34;data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='8' height='8'%3E%3Cpath d='M2.5 0L1 1.5 3.5 4 1 6.5 2.5 8l4-4-4-4z' fill='%236c757d'/%3E%3C/svg%3E&#34;);" aria-label="breadcrumb" class="me-2">
            <ol class="breadcrumb mb-0">
                <li class="breadcrumb-item active" aria-current="page">{$BREADCRUMB_TEXT}</li>
            </ol>
        </nav>
        <div class="ms-auto">
            <a href="{$SEARCH_URL}" class="p-2 text-reset" data-bs-toggle="tooltip" title="{$SEARCH}">
                <i class="bi bi-search"></i>
            </a>
        </div>
    </div>

    {foreach from=$FORUMS key=category item=forum}
        {if !empty($forum.subforums)}
            <div class="d-flex flex-column mb-3">
                <div class="rounded-4 text-bg-primary p-3 mb-1">
                    <a class="text-reset text-decoration-none fw-medium" href="{$forum.link}">{$forum.title}</a>
                </div>

                <div class="bg-body shadow-sm py-2 d-flex flex-column rounded-3">
                    <div class="list-group list-group-flush">
                        {foreach from=$forum.subforums item=subforum}                    
                            <div data-href="{$subforum->link}" class="list-group-item list-group-item-action d-flex">
                                <div class="row align-items-center w-100">
                                    <div class="fs-4 m-0 me-2 p-0 col-1 text-center">
                                        {if empty($subforum->icon)}
                                            {if $subforum->news == '1'}
                                                <i class="bi bi-megaphone-fill"></i>                                            
                                            {else}
                                                <i class="bi bi-chat"></i>
                                            {/if}
                                        {else}
                                            {$subforum->icon}
                                        {/if}
                                    </div>

                                    <strong class="col-4">{$subforum->forum_title}</strong>

                                    <div class="col d-md-flex d-none justify-content-end justify-content-xl-center">
                                        <div class="d-flex flex-column align-items-center px-2 text-body-secondary">
                                            <strong class="fv-petite">{$TOPICS|capitalize}</strong>
                                            <small>{$subforum->topics}</small>
                                        </div>
                                        <div class="d-flex flex-column align-items-center px-2 text-body-secondary">
                                            <strong class="fv-petite">{$POSTS|capitalize}</strong>
                                            <small>{$subforum->posts}</small>
                                        </div>
                                    </div>

                                    <div class="row d-none d-xl-flex ms-auto align-items-center col-4">
                                        {if isset($subforum->last_post)}
                                            <div class="col-2">
                                                <img class="rounded-5" src="{$subforum->last_post->avatar}" alt="{$subforum->last_post->username}" style="width: 2rem;height: 2rem;">
                                            </div>

                                            <div class="col d-flex flex-column">
                                                <a href="{$subforum->last_post->link}" class="text-decoration-none">{$subforum->last_post->title}</a>
                                                <div class="text-body-secondary">
                                                    <small>{$BY|capitalize}</small>
                                                    <a style="text-decoration: none; {$subforum->last_post->user_style}" href="{$subforum->last_post->profile}"><small>{$subforum->last_post->username}</small></a>
                                                    &bull;
                                                    <small class="text-body-secondary">
                                                        {$subforum->last_post->post_date}
                                                    </small>
                                                </div>
                                            </div>
                                        {else}
                                            <div class="text-body-secondary" style="padding: 8px 0">{$NO_TOPICS}</div>
                                        {/if}
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>
            </div>
        {/if}
    {/foreach}
{/block}

<div class="ui stackable padded grid" id="forum-index">
    <div class="ui centered row">
        <div
            class="ui {if count($WIDGETS_LEFT) && count($WIDGETS_RIGHT) }four wide tablet eight wide computer{elseif count($WIDGETS_LEFT) || count($WIDGETS_RIGHT)}ten wide tablet twelve wide computer{else}sixteen wide{/if} column">

            {foreach from=$FORUMS key=category item=forum}
            {if !empty($forum.subforums)}
            <div class="ui padded segment" id="forum-node">
                <h3 class="ui header"><a href="{$forum.link}">{$forum.title}</a></h3>
                <div class="ui divider"></div>
                <div class="ui middle aligned stackable grid">
                    {foreach from=$forum.subforums item=subforum}
                    {if $subforum->redirect_forum neq 1}
                    <div class="centered row">
                        <div class="one wide column mobile hidden">{if empty($subforum->icon)}
                            <i class="ui large comment icon middle aligned"></i>
                            {else}{$subforum->icon}{/if}
                        </div>
                        <div class="nine wide column">
                            <a class="header" href="{$subforum->link}" data-toggle="popup">{$subforum->forum_title}</a>
                            <div class="ui wide popup">
                                <h4 class="ui header">{$subforum->forum_title}</h4>
                                {if !empty($subforum->forum_description)}
                                <br />
                                {$subforum->forum_description}
                                {/if}
                                <br />{$TOPICS|capitalize} <b>{$subforum->topics}</b>
                                &middot; {$POSTS|capitalize} <b>{$subforum->posts}</b>
                                {if isset($subforum->subforums)}
                                <br />
                                {$SUBFORUMS}:
                                {assign i 1}
                                {foreach from=$subforum->subforums item=sub_subforum}
                                {if $i != 1}&middot; {/if}<a href="{$sub_subforum->link}">{$sub_subforum->title}</a>
                                {assign i $i+1}
                                {/foreach}
                                {/if}
                            </div>
                            <div class="description">
                                {$TOPICS|capitalize}: <b>{$subforum->topics}</b>
                                &middot; {$POSTS|capitalize}: <b>{$subforum->posts}</b>
                                {if isset($subforum->subforums)}
                                <div class="ui top right pointing inline dropdown">
                                    &middot; {$SUBFORUMS} <i class="dropdown icon"></i>
                                    <div class="menu">
                                        <div class="header">{$SUBFORUMS}</div>
                                        {foreach from=$subforum->subforums item=sub_subforum}
                                        <a class="item" href="{$sub_subforum->link}">
                                            {if empty($sub_subforum->icon)}
                                            <i class="comment icon"></i>
                                            {else}{$sub_subforum->icon}{/if} {$sub_subforum->title}
                                        </a>
                                        {/foreach}
                                    </div>
                                </div>
                                {/if}
                            </div>
                        </div>
                        <div class="six wide column mobile hidden">
                            {if isset($subforum->last_post)}
                            <img class="ui avatar image left floated" src="{$subforum->last_post->avatar}"
                                alt="{$subforum->last_post->username}">
                            <a class="header" href="{$subforum->last_post->link}"
                                data-toggle="popup">{$subforum->last_post->title}</a>
                            <div class="ui wide popup">
                                <h4 class="ui header">{$subforum->last_post->title}</h4>
                                <br />{$BY|capitalize} <a style="{$subforum->last_post->user_style}"
                                    href="{$subforum->last_post->profile}">{$subforum->last_post->username}</a>
                                | {$subforum->last_post->post_date}
                            </div>
                            <div class="description">
                                <a style="{$subforum->last_post->user_style}" href="{$subforum->last_post->profile}"
                                    data-poload="{$USER_INFO_URL}{$subforum->last_post->post_creator}">{$subforum->last_post->username}</a>
                                &middot; <span data-toggle="tooltip"
                                    data-content="{$subforum->last_post->post_date}">{$subforum->last_post->date_friendly}</span>
                            </div>
                            {else}
                            <div class="description" style="padding: 8px 0">{$NO_TOPICS}</div>
                            {/if}
                        </div>
                    </div>
                    {else}
                    <div class="centered row">
                        <div class="one wide column mobile hidden">{if empty($subforum->icon)}<i
                                class="ui large comment icon middle aligned"></i>{else}{$subforum->icon}{/if}</div>
                        <div class="fifteen wide column">
                            <a class="header" data-toggle="modal" {if isset($subforum->redirect_confirm)}
                                href="#"
                                data-target="#modal-redirect-{$subforum->id}"
                                {else}
                                href="{$subforum->redirect_url}"
                                {/if}>{$subforum->forum_title}</a>
                        </div>
                    </div>
                    <div class="ui mini modal" id="modal-redirect-{$subforum->id}">
                        <div class="content">
                            {$subforum->redirect_confirm}
                        </div>
                        <div class="actions">
                            <a class="ui negative button">{$NO}</a>
                            <a class="ui positive button" href="{$subforum->redirect_url}" target="_blank"
                                rel="noopener nofollow">{$YES}</a>
                        </div>
                    </div>
                    {/if}
                    {/foreach}
                </div>
            </div>
            {/if}
            {/foreach}
        </div>
        <div class="ui five wide tablet four wide computer column">
            {if count($WIDGETS_RIGHT)}
            {foreach from=$WIDGETS_RIGHT item=widget}
            {$widget}
            {/foreach}
            {/if}
        </div>
    </div>
</div>
