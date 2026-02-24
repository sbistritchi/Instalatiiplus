{if $is_bottom_panel_available}
    {script src="js/addons/ab__preload/bottom_panel.js"}
    <script>
        Tygh.tr({
            ab__p_wrong_preload_images: '{__("ab__p.wrong_preload_images")|escape:"javascript"}',
            ab__p_image_must_be_preloaded: '{__("ab__p.image_must_be_preloaded")|escape:"javascript"}',
            ab__p_image_is_preloaded: '{__("ab__p.image_is_preloaded")|escape:"javascript"}',
            ab__p_image_is_not_preloaded: '{__("ab__p.image_is_not_preloaded")|escape:"javascript"}',
            ab__p_fact_pov: '{__("ab__p.fact_pov")|escape:"javascript"}',
            ab__p_settings_pov: '{__("ab__p.settings_pov")|escape:"javascript"}',
            ab__p_lcp_element_missing: '{__("ab__p.lcp_element_missing")|escape:"javascript"}'
        });
    </script>
{/if}