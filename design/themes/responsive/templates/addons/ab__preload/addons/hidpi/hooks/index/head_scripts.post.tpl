{if !$smarty.cookies.ab__p_dpr}
    <script>
        (function (_, $) {
            $(_.doc).ready(function () {
                let pr = 1;
                if ('devicePixelRatio' in window) {
                     pr = window.devicePixelRatio;
                }
                $.cookie.set('ab__p_dpr', pr, '', '/');
            })
        }(Tygh, Tygh.$));
    </script>
{/if}
