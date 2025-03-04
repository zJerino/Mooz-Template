<div class="bg-body rounded-3 shadow-sm d-flex flex-column mb-3" id="widget-statistics">
    <div class="text-primary text-center rounded-top-3 px-3 py-2 fv-petite fw-bold">
        {$STATISTICS}
    </div>
    <div class="px-3 pb-2 d-flex flex-column flex-wrap">
        {if isset($FORUM_STATISTICS)}
            <div class="d-flex">
                <span class="me-2">{$TOTAL_THREADS}</span>
                <div class="ms-auto text-body-secondary"><b>{$TOTAL_THREADS_VALUE}</b></div>
            </div>
            <div class="d-flex">
                <span class="me-2">{$TOTAL_POSTS}</span>
                <div class="ms-auto text-body-secondary"><b>{$TOTAL_POSTS_VALUE}</b></div>
            </div>
        {/if}
        <div class="d-flex">
            <span class="me-2">{$USERS_REGISTERED}</span>
            <div class="ms-auto text-body-secondary"><b>{$USERS_REGISTERED_VALUE}</b></div>
        </div>
        <div class="d-flex">
            <span class="text" style="width: 100%;">{$LATEST_MEMBER}</span>
            <div class="description right floated">
                <a href="{$LATEST_MEMBER_VALUE.profile}" data-poload="{$USER_INFO_URL}{$LATEST_MEMBER_VALUE.id}" style="text-decoration: none;{$LATEST_MEMBER_VALUE.style}"><b>{$LATEST_MEMBER_VALUE.nickname}</b></a>
            </div>
        </div>
    </div>
</div>