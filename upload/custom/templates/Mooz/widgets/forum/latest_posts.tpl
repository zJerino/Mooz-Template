<div class="bg-body rounded-3 shadow-sm d-flex flex-column py-2 mb-3" id="widget-latest-posts">
    <div class="text-primary text-center rounded-top-3 px-3 fv-petite fw-bold">
        {$LATEST_POSTS}
    </div>
    <div class="list-group list-group-flush">
        {foreach from=$LATEST_POSTS_ARRAY name=latest_posts item=post}
            <div class="list-group-item list-group-item-action" data-href="{$post.last_reply_link}" >
                <div class="d-flex align-items-center">
                    <img class="rounded-circle" src="{$post.last_reply_avatar}" alt="{$post.last_reply_username}" style="width: 2rem;height: 2rem;">
                    <div class="ms-2 d-flex flex-column">
                        <a class="fw-bold text-decoration-none">{$post.topic_title}</a>
                        <div class="d-block">
                            <a href="{$post.last_reply_profile_link}" style="{$post.last_reply_style}" data-poload="{$USER_INFO_URL}{$post.last_reply_user_id}">{$post.last_reply_username}</a>
                            &middot;
                            <span data-bs-toggle="tooltip" title="{$post.last_reply}">{$post.last_reply_rough}</span>
                        </div>
                    </div>
                </div>
            </div>
        {foreachelse}
            <div class="list-group-item text-body-tertiary">
                {$NO_POSTS_FOUND}
            </div>
        {/foreach}
    </div>
</div>