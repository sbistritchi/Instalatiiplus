<script data-no-defer>
    window.lazySizesConfig =  {
        loadMode: 2,
        hFac: {$ab__ll.h_fac},
        expand: {$ab__ll.expand},
        expFactor: 1,
        preloadAfterLoad: false
    };
    document.addEventListener('lazybeforeunveil', function(e){
        let element = e.target;
        var bg = element.getAttribute('data-background-url');
        if(bg){
            var bgImg = $(new Image());
            bgImg.attr('src', bg);
            bgImg.on('load', function () {
                $(element).css({
                    'background-image': "url('" + bg + "')"
                }).removeAttr('data-background-url')
            });
        }
    });
</script>