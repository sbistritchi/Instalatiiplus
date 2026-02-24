<script>
    (function(_, $) {

        $.ceEvent('on', 'ce.commoninit', function(context) {
            var slider = context.find('#{$block_id}');
            var elementsScroll = {$elements_to_scroll};

            if (slider.length) {

                const bannerObserver = new ResizeObserver($.debounce((entries) => {
                    checkScroll();
                }, 100));

                bannerObserver.observe(slider.get(0));

                const isRTL = $('html').attr('dir') === 'rtl'; // Check if RTL is used
                const $scrollContainer = $('.ut2-scroll-content', slider);
                const $scrollLeft = $('.ut2-scroll-left', slider);
                const $scrollRight = $('.ut2-scroll-right', slider);
                let itemWidth = 0;

                const getItemWidth = () => {
                    if (itemWidth) return itemWidth;
                    itemWidth = $('.ut2-scroll-item', slider).outerWidth(true); // element width taking into account margin
                    return itemWidth;
                }

                function checkScroll() {
                    const scrollLeftVal = $scrollContainer.scrollLeft();
                    const maxScrollLeft = $scrollContainer[0].scrollWidth - $scrollContainer[0].clientWidth;

                    if (isRTL) {
                        $scrollLeft.toggle(scrollLeftVal < 0 && Math.abs(scrollLeftVal) <= maxScrollLeft);
                        $scrollRight.toggle(Math.abs(scrollLeftVal) >= 0  && Math.abs(scrollLeftVal) < maxScrollLeft);
                    } else {
                        $scrollLeft.toggle(scrollLeftVal > 0);
                        $scrollRight.toggle(scrollLeftVal < maxScrollLeft);
                    }
                }

                $scrollRight.click(function() {
                    if (isRTL) {
                        $scrollContainer.animate({ scrollLeft: $scrollContainer.scrollLeft() - getItemWidth() * elementsScroll }, 300, checkScroll);
                    } else {
                        $scrollContainer.animate({ scrollLeft: $scrollContainer.scrollLeft() + getItemWidth() * elementsScroll }, 300, checkScroll);
                    }
                });

                $scrollLeft.click(function() {
                    if (isRTL) {
                        $scrollContainer.animate({ scrollLeft: $scrollContainer.scrollLeft() + getItemWidth() * elementsScroll }, 300, checkScroll);
                    } else {
                        $scrollContainer.animate({ scrollLeft: $scrollContainer.scrollLeft() - getItemWidth() * elementsScroll }, 300, checkScroll);
                    }
                });

                $scrollContainer.on('scroll', checkScroll);
            }
        });

    }(Tygh, Tygh.$));
</script>
