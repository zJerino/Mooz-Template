{extends file="base/empty.tpl"}

{assign var="avatar_wh" value='8rem'}
{assign var="mc_integration_size" value='12rem'}

{block name=content}
    <div class="bg-body shadow-sm rounded-3 d-flex flex-column mb-3">
        <div class="rounded-top-3 p-3 profile-banner d-flex flex-column" style="background-image: url('{$BANNER}')"></div>
        <div id="profile-information" class="align-items-center d-flex flex-column flex-md-row p-3 position-relative" style="--mz-avatar-size: {$avatar_wh}">
            <img src="{$AVATAR}" alt="{$USERNAME}" class="mb-2 position-absolute rounded-4">
            <div class="ms-0 ms-md-2 ASDTYHyuT">
                <strong>
                    {if isset($NICKNAME)} {$NICKNAME} {else} {$USERNAME} {/if}
                </strong>
            </div>

            <div class="ms-md-auto btn-group">
                {if isset($LOGGED_IN)}
                    {if isset($SELF)}
                        <a class="btn btn-secondary" href="{$SETTINGS_LINK}"><i class="bi bi-person-fill-gear"></i></a>
                        <button type="button" class="btn btn-dark dark-border" onclick="showBannerSelect()">
                            <i class="bi bi-images"></i>
                        </button>
                    {else}
                        {if ($MOD_OR_ADMIN != true)}
                            <a class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#modal-block">
                                <i class="bi bi-ban"  data-bs-toggle="tooltip" title="{$BLOCK_USER}"></i>
                            </a>
                        {/if}

                        <a class="btn btn-dark dark-border" href="{$MESSAGE_LINK}"><i class="bi bi-chat-left-dots-fill"></i></a>

                        {if isset($RESET_PROFILE_BANNER)}
                            <button class="btn btn-danger" data-form-submit="#form-reset-profile-banner" data-bs-toggle="tooltip" title="{$RESET_PROFILE_BANNER}">
                                <i class="bi bi-image-fill"></i>
                            </button>
                        {/if}
                    {/if}
                {/if}
            </div>
        </div>
    </div>
    
    <div class="row justify-content-center">
        <div class="col-12 col-md-8">
            <div class="bg-body shadow-sm p-3 rounded-3 d-flex flex-column mb-3">
                <h5>{$FEED}</h5>

                {if $CAN_VIEW}
                    {if isset($LOGGED_IN)}
                        <div class="card mb-3">
                            <div class="card-body">
                                <form class="d-flex flex-column" action="" method="post" id="form-profile-post">
                                    <div class="mb-3">
                                        <textarea name="post" class="form-control" placeholder="{$POST_ON_WALL}"></textarea>
                                    </div>
                                    <input type="hidden" name="action" value="new_post">
                                    <input type="hidden" name="token" value="{$TOKEN}">
                                    <input type="submit" class="btn btn-primary rounded-5 ms-auto px-4" value="{$SUBMIT}">
                                </form>
                            </div>
                        </div>
                    {/if}


                    {foreach from=$WALL_POSTS item=post key=key}
                        <div class="card {if $post@last == false} mb-3 {/if}">
                            <div class="card-header d-flex flex-row border-0 align-items-center">
                                <img src="{$post.avatar}" alt="@{$post.username}" class="rounded-circle me-2" style="width: 2rem; height: 2rem">
                                <div class="d-flex flex-column">
                                    <a href="{$post.profile}" class="fw-bold" style="text-decoration: none; {$post.user_style}">{$post.username}</a>
                                    <small class="text-body-secondary" data-bs-toggle="tooltip" title="{$post.date}">{$post.date_rough}</small>
                                </div>
                                <div class="ms-auto">
                                    <i class="bi bi-three-dots cursor-pointer" data-bs-title=" " data-body-class="p-0" data-element="#post-menu-user-{$key}" data-bs-toggle="popover" data-bs-trigger="focus" tabindex="0" data-bs-html="true"></i>
                                </div>
                            </div>
                            <div class="card-body">
                                {$post.content}
                            </div>
                            <div class="card-footer border-0 d-flex flex-column">
                                <div class="d-flex">
                                    <a href="{if $post.reactions_link !== " #"}{$post.reactions_link}{else}#{/if}" data-bs-toggle="tooltip" title="{$LIKE}" class="btn btn-dark bg-transparent text-body">
                                        <i class="bi bi-hand-thumbs-up-fill"></i>
                                            {if ($post.reactions.count|regex_replace:'/[^0-9]+/':'' != 0)}{$post.reactions.count|regex_replace:'/[^0-9]+/':''}{/if}
                                    </a>
                                    <a data-bs-toggle="modal" data-bs-target="#modal-reply-{$post.id}" class="ms-auto btn btn-dark bg-transparent text-body">
                                        <i class="bi bi-chat-left-text-fill"></i> <span class="d-none d-md-inline-flex">{$post.replies.count|capitalize}</span>
                                    </a>
                                </div>
                            </div>
                        </div>

                        {* Menu *}
                        <div class="d-none">
                            <div id="post-menu-user-{$key}">
                                <div class="list-group list-group-flush rounded-3">
                                    {if isset($LOGGED_IN_USER)}
                                        {if (isset($CAN_MODERATE) && $CAN_MODERATE == 1) || $post.self == 1}
                                            <a class="list-group-item list-group-item-action" href="#" data-bs-toggle="modal" data-bs-target="#modal-edit-{$post.id}">{$EDIT}</a>
                                            <form action="" class="d-none" method="post" id="form-delete-post-{$post.id}">
                                                <input type="hidden" name="post_id" value="{$post.id}">
                                                <input type="hidden" name="action" value="delete">
                                                <input type="hidden" name="token" value="{$TOKEN}">
                                            </form>
                                            <a class="list-group-item list-group-item-action" href="#"  onclick="{literal}if(confirm(confirmDelete)){$('#form-delete-post-{/literal}{$post.id}{literal}').submit();}{/literal}">{$DELETE}</a>
                                        {/if}
                                    {/if}
                                </div>
                            </div>
                        </div>
                        
                    {foreachelse}
                        <div class="bg-body-tertiary border-3 border-start border-info d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
                            <div class="text-info text-center rounded-3 fv-small fw-bold me-3">
                                <i class="bi bi-exclamation-circle-fill fs-2"></i>
                            </div>
                            <div class="text-body-secondary">
                                <strong class="text-info">{$NO_WALL_POSTS}</strong>
                            </div>
                        </div>
                    {/foreach}

                    {if count($WALL_POSTS)}
                        <div class="d-flex">
                            <div class="mx-auto mt-3">{$PAGINATION}</div>
                        </div>
                    {/if}
                {else}
                    <div class="bg-body border-3 border-start border-danger d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
                        <div class="text-danger text-center rounded-3 fv-small fw-bold me-3">
                            <i class="bi bi-x-circle-fill fs-2"></i>
                        </div>
                        <div class="text-body-secondary">
                            <strong class="text-danger">{$PRIVATE_PROFILE}</strong>
                        </div>
                    </div>
                {/if}
            </div>
        </div>

        <div class="col">
            <div class="bg-body shadow-sm py-3 mb-3 rounded-3 d-flex flex-column">
                <div class="text-primary text-center rounded-top-3 px-3 fv-small mb-2 fw-bold">
                    {$ABOUT}
                </div>
                <ul class="list-group list-group-flush mb-0">
                    {foreach from=$ABOUT_FIELDS item=item key=key}
                        {if $item.type == 'text' && $item.title != 'Minecraft'}
                            <li class="list-group-item d-flex flex-column">
                                <strong class="me-2"><small>{$item.title}</small></strong>
                                <small class="text-body-secondary ms-1">{$item.value}</small>
                            </li>                            
                        {/if}
                    {/foreach}
                </ul>
            </div>

            {if (isset($INTEGRATIONS) && count($INTEGRATIONS) && isset($INTEGRATIONS.Minecraft))}
                <div class="bg-body shadow-sm py-3 rounded-3 d-flex flex-column mb-3">
                    <div class="text-primary text-center rounded-top-3 px-3 fv-small fw-bold mb-2">
                        {$mzlang.mc_account}
                    </div>
                    <img data-bs-toggle="tooltip" title="{$INTEGRATIONS.Minecraft.username}" src="https://mc-heads.net/body/{$INTEGRATIONS.Minecraft.identifier}/left" alt="" class="mx-auto" style="height: {$mc_integration_size};object-fit: contain;width: 100%;">
                </div>                
            {/if}


            {if (isset($INTEGRATIONS) && count($INTEGRATIONS))}
                <div class="bg-body shadow-sm p-3 rounded-3 d-flex flex-column mb-3">
                    <div class="text-primary text-center rounded-top-3 mb-2 fv-small fw-bold">
                        {$mzlang.integrations}
                    </div>
                    <div class="row">
                        {foreach from=$INTEGRATIONS item=item key=key}
                            <div class="col-6">
                                <div class="d-flex flex-row">
                                    <img src="{if ($key == 'Minecraft')}{$TEMPLATE.path}/img/mc-grass.jpg{/if}" alt="" class="rounded-2 me-2 object-fit-contain" width="32">
                                    <div class="d-flex flex-column">
                                        <strong>{$item.username}</strong>
                                        <small class="text-body-secondary">{$key}</small>
                                    </div>
                                </div>
                            </div>
                        {/foreach}
                    </div>
                </div>                
            {/if}

            {foreach from=$TABS key=key item=tab}
                <div class="ui bottom attached tab segment" data-tab="{$key}" id="profile-{$key}">
                    {include file=$tab.include}
                </div>
            {/foreach}
        </div>
    </div>

    {if isset($RESET_PROFILE_BANNER)}
        <form action="{$RESET_PROFILE_BANNER_LINK}" id="form-reset-profile-banner" method="post" style="display: inline">
            <input type="hidden" name="token" value="{$TOKEN}" />
        </form>
    {/if}


{* Modals *}
{if isset($LOGGED_IN_USER)}
    {if !isset($SELF)}
        {if $MOD_OR_ADMIN != true}
            <div class="modal fade" id="modal-block" tabindex="-1" aria-labelledby="modal-blockLabel" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="modal-blockLabel">{if isset($BLOCK_USER)}{$BLOCK_USER}{else}{$UNBLOCK_USER}{/if}</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            {if isset($CONFIRM_BLOCK_USER)}{$CONFIRM_BLOCK_USER}{else}{$CONFIRM_UNBLOCK_USER}{/if}
                            <form class="ui form" action="" method="post" id="form-block">
                                <input type="hidden" name="token" value="{$TOKEN}">
                                <input type="hidden" name="action" value="block">
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">{$CANCEL}</button>
                            <button type="button" class="btn btn-primary"  onclick="$('#form-block').submit();">{$SUBMIT}</button>
                        </div>
                    </div>
                </div>
            </div>
        {/if}
    {else}
        <div class="modal fade" id="imageModal" tabindex="-1" aria-labelledby="imageModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="imageModalLabel">{$CHANGE_BANNER}</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="" name="updateBanner" method="post" style="display:block;">
                            <div name="banner" class="mb-3 row">
                                {foreach from=$BANNERS item=banner key=key}
                                    <div class="col-12 col-md-4">
                                        <input type="radio" class="btn-check" value="{$banner.name}" {if $banner.active==true} checked{/if} name="banner" id="banner-select-{$key}" autocomplete="off" checked>
                                        <label class="btn" for="banner-select-{$key}">
                                            <img src="{$banner.src}" alt="{$banner.name}" style="width: 100%">
                                        </label>
                                    </div>
                                {/foreach}
                            </div>
                            <input type="hidden" name="token" value="{$TOKEN}">
                            <input type="hidden" name="action" value="banner">
                        </form>

                        {if isset($PROFILE_BANNER)}
                            <div class="d-flex align-items-center text-body-secondary ">
                                <hr class="w-100">
                                <span class="w-auto text-nowrap px-2">{$UPLOAD_PROFILE_BANNER}</span>
                                <hr class="w-100">
                            </div>
                            <form class="ui form" action="{$UPLOAD_BANNER_URL}" method="post" enctype="multipart/form-data" id="form-banner">
                                <div class="mb-3">
                                    <label for="uploadBannerInput" class="form-label">{$BROWSE}</label>
                                    <div class="input-group">
                                        <input type="file" class="form-control" name="file" id="uploadBannerInput">
                                        <button class="btn btn-outline-secondary" type="submit">{$UPLOAD}</button>
                                    </div>
                                </div>
                                <input type="hidden" name="token" value="{$TOKEN}">
                                <input type="hidden" name="type" value="profile_banner">
                            </form>
                        {/if}
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary border-0" data-bs-dismiss="modal">{$CANCEL}</button>
                        <button type="button" class="btn btn-primary" onclick="document.updateBanner.submit()">{$SUBMIT}</button>
                    </div>
                </div>
            </div>
        </div>
    {/if}
{/if}

{if count($WALL_POSTS)}
    {foreach from=$WALL_POSTS item=post}
        {if (isset($CAN_MODERATE) && $CAN_MODERATE eq 1) || $post.self eq 1}
            <div class="modal fade" id="modal-edit-{$post.id}" tabindex="-1" aria-labelledby="modal-edit-{$post.id}Label" aria-hidden="true">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="modal-edit-{$post.id}Label">{$EDIT_POST}</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form class="ui form" action="" method="post" id="form-edit-{$post.id}">
                                <div class="field">
                                    <textarea name="content" class="form-control">{$post.content}</textarea>
                                </div>
                                <input type="hidden" name="token" value="{$TOKEN}">
                                <input type="hidden" name="post_id" value="{$post.id}">
                                <input type="hidden" name="action" value="edit">
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary border-0" data-bs-dismiss="modal">{$CANCEL}</button>
                            <button type="button" class="btn btn-primary"  onclick="$('#form-edit-{$post.id}').submit();">{$SUBMIT}</button>
                        </div>
                    </div>
                </div>
            </div>
        {/if}

        <div class="modal fade" id="modal-reply-{$post.id}" tabindex="-1" aria-labelledby="modal-reply-{$post.id}Label" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="modal-reply-{$post.id}Label">{$REPLIES_TITLE}</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body  overflow-y-auto" style="max-height: 55vh">
                        {if isset($post.replies.replies)}
                            <ul class="list-group">                        
                                <div class="list-group mt-1">
                                    {foreach from=$post.replies.replies item=item key=key}
                                        <div class="list-group-item d-flex flex-column">
                                            <div class="d-flex align-items-center">
                                                <img src="{$item.avatar}" alt="{$item.nickname}" class="rounded-circle me-2" style="width: 1.25rem; height: 1.25rem">
                                                <small class="d-flex flex-column me-2" style="font-size: .75rem">
                                                    <a class="fw-bold" href="{$item.profile}" style="text-decoration: none; {$item.style}">{$item.nickname}</a>
                                                    <small class="text-body-secondary" data-bs-toggle="tooltip" title="{$item.time_full}">{$item.time_friendly}</small>
                                                </small>
                                                <div class="ms-auto">
                                                    {if (isset($CAN_MODERATE) && $CAN_MODERATE eq 1) || $post.self eq 1}
                                                        <form class="d-none" action="" method="post" id="form-delete-{$item.id}">
                                                            <input type="hidden" name="action" value="deleteReply">
                                                            <input type="hidden" name="token" value="{$TOKEN}">
                                                            <input type="hidden" name="post_id" value="{$item.id}">
                                                        </form>
                                                        <a class="cursor-pointer text-body" onclick="{literal}if(confirm(confirmDelete)){$('#form-delete-{/literal}{$item.id}{literal}').submit();}{/literal}" data-bs-toggle="tooltip" title="{$DELETE}">
                                                            <i class="bi bi-trash"></i>
                                                        </a>
                                                    {/if}
                                                </div>
                                            </div>
                                            <div class="ms-1">
                                                {$item.content}                                                
                                            </div>
                                        </div>
                                    {/foreach}
                                </div>
                            </ul>                        
                        {else}
                            <div class="text-body-secondary">
                                {$NO_REPLIES}
                            </div>
                        {/if}
                    </div>
                    
                    {if isset($LOGGED_IN_USER)}                    
                        <div class="modal-footer d-flex flex-column">
                            <form class="d-flex flex-column w-100" action="" method="post" id="form-reply-{$post.id}">
                                <div class="input-group w-100">
                                    <input type="text" name="reply" class="form-control" placeholder="{$NEW_REPLY}">
                                    <button class="btn btn-outline-secondary" type="submit" id="button-addon2">{$SUBMIT}</button>
                                </div>
                                <input type="hidden" name="token" value="{$TOKEN}">
                                <input type="hidden" name="post" value="{$post.id}">
                                <input type="hidden" name="action" value="reply">
                            </form>
                        </div>
                    {/if}                        
                </div>
            </div>
        </div>
    {/foreach}
{/if}

<style>
    .pagination {
        margin-bottom: 0
    }
</style>
{/block}
