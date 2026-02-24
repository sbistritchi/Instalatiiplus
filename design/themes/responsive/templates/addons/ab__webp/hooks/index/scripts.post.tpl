{*
{if "AB__WEBP_LAZY"|defined}
    <script async>
        (function (_, $) {
            $(_.doc).ready(function () {
                $.ceAjax('request',
                    fn_url('ab__webp.run_queue'),
                    {
                        hidden: true
                    }
                );
            })
        })(Tygh, Tygh.$);
    </script>
{/if}*}
