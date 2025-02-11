// @license magnet:?xt=urn:btih:d3d9a9a6595521f9666a5e94cc830dab83b65699&dn=expat.txt Expat/MIT
if (page !== '') {
    if (page === 'status') {
        $("[data-server]").each(function () {
            let serverElement = $(this);
            let sconf = {
                id: ($(this).data("server")),
                bungee: ($(this).data("bungee") == 1 ? true : false),
                bedrock: ($(this).data("bedrock") == 1 ? true : false),
                playerlist: ($(this).data("players") == 1 ? true : false),
            };

            let sEls = {
                spinner: $(this).find('#status-server-spinner-' + sconf.id),
                counter: $(this).find('#server-counter-' + sconf.id),
                players: $(this).find('#server-players-' + sconf.id),
            };

            const paramChar = URLBuild('').includes('?') ? '&' : '?';
            
            setInterval(() => {
                if ($(sEls.spinner).hasClass('text-success')) $(sEls.spinner).removeClass("text-success");
                if ($(sEls.spinner).hasClass('text-danger')) $(sEls.spinner).removeClass("text-danger");
                if ($(sEls.spinner).hasClass('spinner-grow')) $(sEls.spinner).removeClass("spinner-grow");
                $(sEls.spinner).addClass("text-dark");
                $(sEls.spinner).addClass("spinner-border");

                $.getJSON(URLBuild('queries/server/' + paramChar + 'id=' +  sconf.id), function (data) {
                    if (data.status_value === 1) {
                        $(sEls.spinner).addClass("text-success");
                        $(sEls.counter).text(data.player_count + "/" + data.player_count_max);

                    } else {
                        $(sEls.spinner).addClass("text-danger");
                        $(sEls.counter).text(offline);
                    }
                    $(sEls.spinner).removeClass("text-dark");
                    $(sEls.spinner).addClass("spinner-grow");
                    $(sEls.spinner).removeClass("spinner-border");
                });
            }, 5000);
            return;

            // setInterval(function () {
            //     $(serverStatusSpinner).attr('style', 'animation-play-state: running;');
                                
            //     $.getJSON(URLBuild('queries/server/' + paramChar + 'id=' + serverID), function (data) {
            //         $(serverStatusSpinner).attr('style', 'animation-play-state: paused;');

            //         let content;
            //         let players = '';
            //         if (data.status_value === 1) {
            //             $(serverStatusSpinner).removeClass("text-danger");
            //             $(serverStatusSpinner).removeClass("text-dark");
            //             $(serverStatusSpinner).addClass("text-success");


            //             content = data.player_count + "/" + data.player_count_max;
            //             if (serverBungee === 1) {
            //                 players = bungeeInstance;
            //             } else if (serverBedrock === 1) {
            //                 players = '';
            //             } else {
            //                 if (serverPlayerList === 1) {
            //                     if (data.player_count > 0 && data.player_list.length <= 0) {
            //                         // Weird edge case where player list is empty but the player count is > 0
            //                         if (data.player_count > 1) {
            //                             players += xPlayersOnline.replace('{{count}}', data.player_count);
            //                         } else {
            //                             players += onePlayerOnline;
            //                         }
            //                     } else if (data.player_list.length > 0) {
            //                         for (const player of data.player_list) {
            //                             players += '' +
            //                                 '<a href="' + URLBuild('profile/' + player.name) + '" data-tooltip="' + player.name + '" data-variation="mini" data-inverted="" data-position="bottom center">' +
            //                                 '<img class="ui mini circular image" src="' + avatarSource.replace('{identifier}', player.id).replace('{size}', 64) + '" alt="' + player.name + '">' +
            //                                 '</a>';
            //                         }

            //                         if (data.player_list.length < data.player_count) {
            //                             players += '<span class="ui blue circular label">+' + (data.player_count - data.player_list.length) + '</span>';
            //                         }
            //                     } else {
            //                         players += noPlayersOnline;
            //                     }
            //                 }
            //             }
            //         } else {
            //             $(serverStatusSpinner).removeClass("text-success");
            //             $(serverStatusSpinner).removeClass("text-dark");
            //             $(serverStatusSpinner).addClass("text-danger");

            //             content = offline;
            //             players = noPlayersOnline;
            //         }

            //         $(serverElem).find('#server-status').html(content);
            //         $(serverElem).find('#server-players').html(players);
            //     });
            // }, 5000);
        });
    } else if (page === 'profile') {
        function showBannerSelect() {
            $('#imageModal').modal({
                onVisible: function () {
                    $("select").imagepicker();
                }
            }).modal('show');
        }
        $(function () {
            let postElem = window.location.hash;
            if (postElem) {
                postElem = $(postElem.slice(0, -1));
                setTimeout(function () {
                    $('html, body').animate({ scrollTop: postElem.offset().top - 15 }, 800);
                }, 100);
                postElem.delay(600).effect('highlight', {}, 800);
            }
        });
    } else if (page === 'cc_messaging') {
        $('.ui.search').dropdown({
            minCharacters: 3
        });
    } else if (page === 'portal'){

        $(document).ready(() => {
            let temp1 = document.querySelector('#btn-center-nav');
            let math33t = ((window.innerWidth / 2) - ((temp1.offsetLeft)));

            if (math33t >= 0) {
                console.log({
                    screend2: (window.innerWidth / 2),
                    offsetl: (temp1.offsetLeft),
                    total: (math33t),
                    total2: (math33t - (temp1.clientWidth / 2)),
                })
                temp1.parentElement.firstElementChild.style.marginLeft = ((math33t - (temp1.clientWidth / 2)) * 0.11428571428571428) + 'rem'
            } else {
                temp1.parentElement.firstElementChild.style.marginLeft = (math33t) + 'px'
            }
        })
    } else if (route.indexOf("/forum/topic/") != -1) {
        $(function () {
            const postId = window.location.hash.replace('#post-', '');
            const postElem = '#topic-post[post-id=\'' + postId + '\']';

            if (postId) {
                setTimeout(function () {
                    $('html, body').animate({ scrollTop: $(postElem).offset().top - 15 }, 800);
                    $('> .ui.segment', postElem).effect("highlight", {}, 800);
                }, 100);
            }
        });
    }
}
// @license-end
