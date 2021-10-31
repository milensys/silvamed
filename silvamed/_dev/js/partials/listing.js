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
import $ from 'jquery';


$(document).ready(() => {
  updateProductsView(localStorage['productViewType'], false);
  $('#grid-list-buttons a').on('click', function (event) {
    event.preventDefault();
    updateProductsView($(this).attr('id'), true);
  });

  const parseSearchUrl = function (event) {
    if (event.target.dataset.searchUrl !== undefined) {
      return event.target.dataset.searchUrl;
    }

    if ($(event.target).parent()[0].dataset.searchUrl === undefined) {
      throw new Error('Can not parse search URL');
    }

    return $(event.target).parent()[0].dataset.searchUrl;
  };

  $('body').on('change', '#search_filters input[data-search-url]', function (event) {
    $('#products-wrapper').fadeTo("fast", 0);
    prestashop.emit('updateFacets', parseSearchUrl(event));
  });

  $('body').on('click', '.js-search-filters-clear-all', function (event) {
    $('#products-wrapper').fadeTo("fast", 0);
    prestashop.emit('updateFacets', parseSearchUrl(event));
  });

  $('body').on('click', '.js-search-link', function (event) {
    event.preventDefault();
    $('#products-wrapper').fadeTo("fast", 0);
    prestashop.emit('updateFacets', $(event.target).closest('a').get(0).href);
  });

  $('body').on('change', '#search_filters select', function (event) {
    $('#products-wrapper').fadeTo("fast", 0);
    const form = $(event.target).closest('form');
    prestashop.emit('updateFacets', '?' + form.serialize());
  });

  prestashop.on('updateProductList', (data) => {
    updateProductListDOM(data);
  });

  if ($('#price-slider').length) {
    updateFilterSlider();
  }
});

function updateProductsView(view, withAnimate) {
  if (view && view != 'undefined') {
    $('#grid-list-buttons a').removeClass('active');
    $(`#${view}`).addClass('active');
    if (withAnimate) {
      $('#products-wrapper').fadeTo("fast", 0, function () {
        $(this).attr('class', view);
      }).fadeTo("fast", 1);
    } else {
      $('#products-wrapper').attr('class', view);
    }
    localStorage["productViewType"] = view;
  }
}

function updateProductListDOM(data) {
  $('#search_filters').replaceWith(data.rendered_facets);
  $('#js-active-search-filters').replaceWith(data.rendered_active_filters);
  $('#js-product-list-top').replaceWith(data.rendered_products_top);
  $('#js-product-list').replaceWith(data.rendered_products);
  $('#js-product-list-bottom').replaceWith(data.rendered_products_bottom);

  if (data.rendered_products_header) {
    $('#js-product-list-header').replaceWith(data.rendered_products_header);
  }

  $('#products-wrapper').fadeTo("fast", 1);

  updateProductsView(localStorage['productViewType'], false);
  $('#grid-list-buttons a').on('click', function (event) {
    event.preventDefault();
    updateProductsView($(this).attr('id'), true);
  });

  if ($('#price-slider').length) {
    updateFilterSlider();
  }
}


function updateFilterSlider() {
  let priceSlider = $('#price-slider'),
      searchFiltersWrapper = $('#search_filters_wrapper');
  if (searchFiltersWrapper.hasClass('is-default-filter')) {
    localStorage["productPriceMin"] = priceSlider.data('slidermin');
    localStorage["productPriceMax"] = priceSlider.data('slidermax');
    searchFiltersWrapper.removeClass('is-default-filter');
  } else if (!searchFiltersWrapper.hasClass('is-default-filter') && priceSlider.hasClass('active')) {
    priceSlider.attr('value', localStorage["productPriceRange"]);
  } else {
    localStorage["productPriceMin"] = priceSlider.data('slidermin');
    localStorage["productPriceMax"] = priceSlider.data('slidermax');
  }

  setTimeout(function() {
    priceSlider.jRange({
      from: localStorage["productPriceMin"],
      to: localStorage["productPriceMax"],
      step: 1,
      theme: "theme-pink",
      format: priceSlider.data('format'),
      width: searchFiltersWrapper.find('.facet:visible').length ? searchFiltersWrapper.find('.facet:first').outerWidth() - 8 : 200,
      showLabels: true,
      showScale: false,
      isRange : false,
      onstatechange: function (e) {
        $('#price-slider-label span').html(priceSlider.attr('value').replace(',', ' - '));
      },
      ondragend: function (e) {
        updateFilterSliderPrice(e);
      },
      onbarclicked: function (e) {
        updateFilterSliderPrice(e);
      }
    });
  }, 500);
  $( window ).resize(function() {
    $('#price-slider + .slider-container:visible').width($('#search_filters_wrapper .facet:first').outerWidth() - 8);
  });
}

function updateFilterSliderPrice(e) {
  localStorage["productPriceRange"] = e;
  let currencyPrefix = $('#price-slider-link').attr('data-currency');
  let rangePrice = e.replace(',', '-');
  let priceLink = $('#price-slider-link').attr('href').replace(currencyPrefix, '%temp');
  let priceLinkOld = priceLink.match(/%temp(\S+)/i)[0];
  let priceLinkNew = priceLink.replace(priceLinkOld, currencyPrefix + '-' + rangePrice);
  $('#price-slider-link').attr('href', priceLinkNew);
  setTimeout(function() {
    $('#price-slider-link').click();
  }, 1000);
}