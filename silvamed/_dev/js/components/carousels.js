export default class universalCarousel {
  constructor(el) {
    this.el = el;
  }

  /**
   * Description. Add the navigation to carousel.
   */
  addNavigation(ucWrapper) {
    if ($(ucWrapper).hasClass('uc-nav')) {
      $(ucWrapper)
        .find('.swiper-container')
        .append(
          '<div class="swiper-button-prev"></div><div class="swiper-button-next"></div>'
        );
    }
  }

  /**
   * Description. Add the pagination to carousel.
   */
  addPagination(ucWrapper) {
    if ($(ucWrapper).hasClass('uc-pag')) {
      if ($(ucWrapper).find('.products-section-title').length) {
        $(ucWrapper)
          .find('.products-section-title')
          .append(
            '<div class="swiper-pagination"></div>'
          );
      } else {
        $(ucWrapper)
          .find('.swiper-container')
          .append(
            '<div class="swiper-pagination"></div>'
          );
      }
    }
  }

  /**
   * Description. Checking condition of controls.
   * @listens init
   */
  checkCondition() {
    if (this.params.direction === 'vertical') {
      $(this.slides).css('min-height', 0);
      let verticalHeightArray = $(this.slides).map(function () {
        return $(this).height();
      }).get();
      let maxVerticalHeigh = Math.max.apply(null, verticalHeightArray);
      $(this.$wrapperEl).css('height', maxVerticalHeigh * this.params.slidesPerView);
      $(this.slides).css('min-height', maxVerticalHeigh);
    }

    this.update();

    if (this.params.pagination.el.length) {
      this.params.slidesPerGroup = $(this.$el).find('.swiper-slide-visible').length;
      this.update();
    }

    if (this.isBeginning && this.isEnd) {
      this.allowTouchMove = false;
      this.$el.addClass('hidden-controls');
    } else {
      this.allowTouchMove = true;
      this.$el.removeClass('hidden-controls');
    }
  }

  /**
   * Description. Creating structure for carousel.
   */
  buildStructure(ucWrapper) {
    this.el.direction = 'horizontal'; //default value
    this.el.slidesPerView = 'auto'; //default value

    $(ucWrapper)
      .find('.' + $(ucWrapper).attr('class').match(/uc-el-(\S+)/i)[1])
      .addClass('swiper-slide')
      .wrapAll('<div class="swiper-container"><div class="swiper-wrapper">');

    if ($(ucWrapper).attr('class').indexOf('u-carousel-vertical-') != -1) {
      this.el.direction = 'vertical';
      this.el.slidesPerView = $(ucWrapper).attr('class').match(/u-carousel-vertical-(\d+)/i)[1];
    }
  }

  /**
   * Description. Init all carousels.
   */
  init() {
    let self = this;
    this.el.each(function () {
      self.buildStructure(this);
      self.addNavigation(this);
      self.addPagination(this);

      let ucCarousel = new Swiper($(this).find('.swiper-container'), {
        direction: self.el.direction,
        slidesPerView: self.el.slidesPerView,
        watchSlidesProgress: true,
        watchSlidesVisibility: true,
        navigation: {
          nextEl: $(this).find('.swiper-button-next'),
          prevEl: $(this).find('.swiper-button-prev')
        },
        pagination: {
          el: $(this).find('.swiper-pagination'),
          clickable: true
        },
        on: {
          init: function () {
            self.checkCondition.call(this);
          },
          resize: function () {
            self.checkCondition.call(this);
          }
        }
      });
    });
  }
}