/**
 * 2007-2020 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License 3.0 (AFL-3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * https://opensource.org/licenses/AFL-3.0
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email
 * to license@prestashop.com so we can send you a copy immediately.
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade PrestaShop to newer
 * versions in the future. If you wish to customize PrestaShop for your
 * needs please refer to http://www.prestashop.com for more information.
 *
 * @author    PrestaShop SA <contact@prestashop.com>
 * @copyright 2007-2020 PrestaShop SA
 * @license   https://opensource.org/licenses/AFL-3.0 Academic Free License 3.0 (AFL-3.0)
 * International Registered Trademark & Property of PrestaShop SA
 */

export default class ProductCommons {
  constructor(el) {
    this.el = el;
  }

  productSpin(el) {
    const $quantityInput = $(el.find('#quantity_wanted'));

    $quantityInput.TouchSpin({
      verticalbuttons: true,
      verticalup: '',
      verticaldown: '',
      verticalupclass: 'linearicons-plus',
      verticaldownclass: 'linearicons-minus',
      buttondown_class: 'btn btn-link',
      buttonup_class: 'btn btn-link',
      min: parseInt($quantityInput.attr('min'), 10),
      max: 1000000
    });

    $quantityInput.on('change keyup', (e) => {
      $(e.currentTarget).trigger('touchspin.stopspin');
      prestashop.emit('updateProduct', {
        eventType: 'updatedProductQuantity',
        event: e
      });
    });
  }

  inputFile(el) {
    $(el.find('.js-file-input')).on('change', (event) => {
      let target, file;
      if ((target = $(event.currentTarget)[0]) && (file = target.files[0])) {
        $(target).prev().find('.js-file-name').text(file.name);
      }
    });
  }

  coverImage(el) {
    $(el.find('.js-thumb')).on(
      'click',
      (event) => {
        $(el.find('.selected')).removeClass('selected');
        $(event.target).addClass('selected');
        $(el.find('.js-qv-product-cover')).prop('src', $(event.currentTarget).data('image-large-src'));
      }
    );
  }

  slider(el) {
    let slider = new Swiper(el.find('.swiper-container'), {
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev'
      },
      on: {
        init: function () {
          this.slideTo($('.js-thumb.selected').data('index'), 0);
          if (this.isBeginning && this.isEnd) {
            this.allowTouchMove = false;
            $(this.$el.children('.swiper-pagination, .swiper-button-next, .swiper-button-prev')).hide();
          }
        },
        resize: function () {
          if (this.isBeginning && this.isEnd) {
            this.allowTouchMove = false;
            $(this.$el.children('.swiper-pagination, .swiper-button-next, .swiper-button-prev')).hide();
          } else {
            this.allowTouchMove = true;
            $(this.$el.children('.swiper-pagination, .swiper-button-next, .swiper-button-prev')).show();
          }
        },
        slideChange: function () {
          this.$el.find('.js-thumb.selected').removeClass('selected');
          $(this.slides[this.activeIndex]).find('.js-thumb').addClass('selected');
        }
      }
    });
  }

  gallery(el, createGallery, observer) {
    let count = createGallery.match(/[0-9]/g);
    let gallery = new Swiper(el.find('.swiper-container'), {
      slidesPerView: count[0],
      spaceBetween: 10,
      observer: observer,
      observeParents: observer,
      slideToClickedSlide: true,
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev'
      },
      on: {
        init: function () {
          this.slideTo($('.js-thumb.selected').data('index'), 0);
          $(this.slides[$('.js-thumb.selected').data('index')]).find('img').click();

          if (this.isBeginning && this.isEnd) {
            this.allowTouchMove = false;
            $(this.$el.children('.swiper-pagination, .swiper-button-next, .swiper-button-prev')).hide();
          }

          el.find('[class*="product-cover"] [class*="swiper-button"]').on('click', (e) => {
            let selectedIndex = $(this.$el.find('.selected')).data('index');
            if ($(e.target).hasClass('swiper-button-prev')) {
              $(this.slides[selectedIndex !== 0 ? selectedIndex - 1 : this.slides.length - 1]).find('img').click();
              this.slideTo(selectedIndex !== 0 ? selectedIndex - 1 : this.slides.length - 1);
            } else {
              $(this.slides[selectedIndex !== this.slides.length - 1 ? selectedIndex + 1 : 0]).find('img').click();
              this.slideTo(selectedIndex !== this.slides.length - 1 ? selectedIndex + 1 : 0);
            }
          })
        },
        resize: function () {
          this.update();
          if (this.isBeginning && this.isEnd) {
            this.allowTouchMove = false;
            $(this.$el.children('.swiper-pagination, .swiper-button-next, .swiper-button-prev')).hide();
          } else {
            this.allowTouchMove = true;
            $(this.$el.children('.swiper-pagination, .swiper-button-next, .swiper-button-prev')).show();
          }
        }
      },
      breakpoints: {
        991: {
          slidesPerView: eval(count[2])
        },
        1640: {
          slidesPerView: eval(count[1])
        }
      }
    });
  }

  calcVerticalThumbsSize(el, spaceBetween, spaceRight, imgContainerK, slidesPerView) {
    let imgContainerWidth = el.parent().innerWidth();
    let swiperWidth = (imgContainerK * (imgContainerWidth - spaceRight)) / (imgContainerK * (slidesPerView + 1)) - ((((spaceBetween * (slidesPerView - 1))) * imgContainerK) / (slidesPerView + 1));
    let swiperHeight = swiperWidth / imgContainerK * slidesPerView + (spaceBetween * (slidesPerView - 1));
    el.parent().attr('style', 'padding-left: ' + spaceRight + 'px;');
    el.attr('style', 'flex-basis: ' + swiperWidth + 'px; height: ' + swiperHeight + 'px;');
    el.find('.swiper-container').attr('style', 'margin-left: -' + spaceRight + 'px; margin-right: ' + spaceRight + 'px;');
    el.find('.swiper-button-prev.out-container, .swiper-button-next.out-container').attr('style', 'transform: translateX(-' + spaceRight + 'px);');
    el.css('opacity', 1);
  }

  verticalGallery(el, createVerticalGallery) {
    let self = this;
    let count = createVerticalGallery.match(/[0-9]/g);
    let productThumbnailsSwiper = new Swiper(el.find('.swiper-container'), {
      direction: 'vertical',
      slidesPerView: eval(count[0]),
      spaceBetween: 30,
      slideToClickedSlide: true,
      navigation: {
        nextEl: el.find('.product-images .swiper-button-next'),
        prevEl: el.find('.product-images .swiper-button-prev')
      },
      preloadImages: false,
      on: {
        init: function () {
          if (this.isBeginning && this.isEnd) {
            this.allowTouchMove = false;
            $(this.$el.children('.swiper-pagination, .swiper-button-next, .swiper-button-prev')).hide();
          }
          el.find('[class*="product-cover"] [class*="swiper-button"]').on('click', (e) => {
            let selectedIndex = $(this.$el.find('.selected')).data('index');
            if ($(e.target).hasClass('swiper-button-prev')) {
              $(this.slides[selectedIndex !== 0 ? selectedIndex - 1 : this.slides.length - 1]).find('img').click();
              this.slideTo(selectedIndex !== 0 ? selectedIndex - 1 : this.slides.length - 1);
            } else {
              $(this.slides[selectedIndex !== this.slides.length - 1 ? selectedIndex + 1 : 0]).find('img').click();
              this.slideTo(selectedIndex !== this.slides.length - 1 ? selectedIndex + 1 : 0);
            }
          })
        },
        resize: function () {
          self.calcVerticalThumbsSize($('.product-images'), productThumbnailsSwiper.params.spaceBetween, productThumbnailsSwiper.params.spaceBetween, productThumbnailsSwiper.slides[0].attributes['data-k'].value, productThumbnailsSwiper.params.slidesPerView);
          this.update();
          if (this.isBeginning && this.isEnd) {
            this.allowTouchMove = false;
            $(this.$el.children('.swiper-pagination, .swiper-button-next, .swiper-button-prev')).hide();
          } else {
            this.allowTouchMove = true;
            $(this.$el.children('.swiper-pagination, .swiper-button-next, .swiper-button-prev')).show();
          }
        }
      },
      breakpoints: {
        991: {
          spaceBetween: 6,
          slidesPerView: eval(count[2])
        },
        1789: {
          spaceBetween: 20,
          slidesPerView: eval(count[1])
        }
      }
    });
    self.calcVerticalThumbsSize(el.find('.product-images'), productThumbnailsSwiper.params.spaceBetween, productThumbnailsSwiper.params.spaceBetween, productThumbnailsSwiper.slides[0].attributes['data-k'].value, productThumbnailsSwiper.params.slidesPerView);
    productThumbnailsSwiper.update();
  }

  calcModalWidth(fluidWrapper, maxWidth, modalK, thumbHeight) {
    let modalWidth = (window.innerHeight - thumbHeight) * modalK;
    if (modalWidth > window.innerWidth && modalWidth < maxWidth) {
      modalWidth = window.innerWidth;
    } else if (modalWidth >= maxWidth) {
      modalWidth = maxWidth;
    }
    fluidWrapper.attr('style', 'max-width: ' + modalWidth + 'px !important;');
  }

  modalZoom(el) {
    let self = this;
    let thumbs = document.getElementById('modalThumb');
    let fluidWrapper = el.find('.modal-dialog');
    let maxWidth = el.find('.swiper-slide:first').attr('data-modal-width');
    let modalK = el.find('.swiper-slide:first').attr('data-modal-k');
    self.calcModalWidth(fluidWrapper, maxWidth, modalK, 0);

    el.on('shown.bs.modal', function () {
      self.coverImage(el);
      self.gallery(el, '7-5-4', true);
      new ResizeSensor(thumbs, function() {
        self.calcModalWidth(fluidWrapper, maxWidth, modalK, thumbs.clientHeight);
      });
    });

    $(window).on('resize', function() {
      self.calcModalWidth(fluidWrapper, maxWidth, modalK, thumbs.clientHeight);
    });
  }

  init(createCoverImage, createInputFile, createProductSpin, createZoom, createSlider, createGallery, createVerticalGallery) {
    createCoverImage ? this.coverImage(this.el) : false;
    createInputFile ? this.inputFile(this.el) : false;
    createProductSpin ? this.productSpin(this.el) : false;
    createZoom ? this.modalZoom($('#product-modal')) : false;
    createSlider ? this.slider(this.el) : false;
    createGallery ? this.gallery(this.el, createGallery, false) : false;
    createVerticalGallery ? this.verticalGallery(this.el, createVerticalGallery) : false;
  }
}
