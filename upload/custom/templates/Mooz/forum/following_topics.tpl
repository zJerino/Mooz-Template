{extends file="base/user.tpl"}

{block name=content}
    {if isset($SUCCESS_MESSAGE)}
        <div class="bg-body border-3 border-start border-success d-flex flex-row mb-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
            <div class="text-success text-center rounded-3 fv-small fw-bold me-3">
                <i class="bi bi-check-circle-fill fs-2"></i>
            </div>
            <div class="text-body-secondary">
                <strong class="text-success">{$SUCCESS}</strong> {$SUCCESS_MESSAGE}
            </div>
        </div>
    {/if}

    <div class="bg-body shadow-sm rounded-3 py-3 d-flex flex-column mb-3">                
        <div class="mx-3 mb-3 d-flex align-items-center">
            <h5 class="me-auto">{$FOLLOWING_TOPICS}</h5>
            
            {if count($TOPICS_LIST)}
                <a class="btn btn-danger" href="#" data-bs-toggle="modal" data-bs-target="#modal-delete"><i data-bs-toggle="tooltip" title="{$UNFOLLOW_ALL}" class="bi bi-trash"></i></a>
            {/if}
        </div>
        
        {nocache}
            {if count($TOPICS_LIST)}
                <ul class="list-group list-group-flush">
                    {foreach from=$TOPICS_LIST item=topic}
                        <li data-href="{$topic.last_post_link}" class="list-group-item list-group-item-action d-flex align-items-center">
                            {if $topic.unread}
                                <i class="bi bi-bell"></i>
                            {/if}
                            <div class="d-flex flex-column me-auto">
                                <strong>{$topic.topic_title}</strong>                            
                                <div class="d-flex">
                                    <img class="rounded-circle me-2" src="{$topic.reply_author_avatar}" style="width: 1rem; height: 1rem">
                                    <small class="d-flex">
                                        <a href="{$topic.reply_author_link}" data-toggle="popup" data-poload="{$USER_INFO_URL}{$topic.reply_author_id}" style="text-decoration:none;{$topic.reply_author_style}">{$topic.reply_author_nickname}</a>
                                        <span class="text-body-secondary mx-1">&bull;</span>
                                        <div class="text-body-secondary" data-bs-toggle="tooltip" title="{$topic.reply_date_full}">
                                            {$topic.reply_date}
                                        </div>
                                    </small>
                                </div>
                            </div>
                            <div class="ms-2">
                                <form action="{$topic.unfollow_link}" method="post" style="display: inline">
                                    <input type="hidden" value="{$TOKEN}" name="token" />
                                    <button class="btn btn-danger">{$UNFOLLOW_TOPIC}</button>
                                </form>
                            </div>
                        </li>
                    {/foreach}
                </ul>

                <div class="mt-2 mx-auto">
                    {$PAGINATION}
                </div>


                <div class="modal fade" id="modal-delete" tabindex="-1" aria-labelledby="modal-deleteLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h1 class="modal-title fs-5" id="modal-deleteLabel">{$UNFOLLOW_ALL}</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                {$CONFIRM_UNFOLLOW}


                                <form class="ui form" action="" method="post" style="display: inline" id="deleteall-form">
                                    <input type="hidden" name="token" value="{$TOKEN}">
                                    <input type="hidden" name="action" value="purge">
                                </form>
                                <div class="d-flex flex-column justify-content-md-start flex-md-row-reverse mt-2">
                                    <a class="btn btn-success rounded-5 px-4 ms-0 ms-md-2 mb-1 mb-md-0" onclick="$('#deleteall-form').submit()">{$YES}</a>
                                    <button class="btn btn-danger rounded-5 px-4" data-bs-dismiss="modal">{$NO}</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            {else}
                <div class="bg-body border-3 border-start border-info d-flex flex-row mx-3 rounded-3 shadow-sm align-items-center px-3 py-2" id="status-message">
                    <div class="text-info text-center rounded-3 fv-small fw-bold me-3">
                        <i class="bi bi-check-circle-fill fs-2"></i>
                    </div>
                    <div class="text-body-secondary">
                        {$NO_TOPICS}
                    </div>
                </div>
            {/if}
        {/nocache}


    </div>
{/block}
