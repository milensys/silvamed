/**
 * 2017-2019 Zemez
 *
 * JX Blog Post Products
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the General Public License (GPL 2.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/GPL-2.0
 *
 * DISCLAIMER
 *
 * Do not edit or add to this file if you wish to upgrade the module to newer
 * versions in the future.
 *
 *  @author    Zemez (Alexander Grosul)
 *  @copyright 2017-2019 Zemez
 *  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
 */

$(document).ready(function() {
  jxblogpostproducts.autocompleteInit($('#products_autocomplete_input'), 'ajax_products_list.php?exclude_packs=0&excludeVirtuals=0&token='+token);
  $('#divproducts').delegate('.delproducts', 'click', function() {
    jxblogpostproducts.delProduct($(this).attr('name'));
  });
});

jxblogpostproducts = {
  autocompleteInit : function(block, url) {
    block.autocomplete(url, {
      minChars      : 3,
      autoFill      : true,
      max           : 20,
      matchContains : true,
      mustMatch     : false,
      scroll        : false,
      cacheLength   : 0,
      formatItem    : function(item) {
        if (typeof(item[1]) == 'undefined') {
          return 'no result found';
        }
        return item[1] + ' - ' + item[0];
      }
    }).result(this.addProduct);
    block.setOptions({
      extraParams : {
        excludeIds : this.getProductIds()
      }
    });
  },
  getProductIds    : function() {
    if (typeof($('#inputproducts').val()) !== 'undefined') {
      return $('#inputproducts').val().replace(/\-/g, ',');
    } else {
      return false;
    }
  },
  addProduct       : function(event, data, formatted) {
    if (data == null) {
      return false;
    }
    var productId      = data[1];
    var productName    = data[0];
    var $divProducts   = $('#divproducts');
    var $inputProducts = $('#inputproducts');
    var $nameProducts  = $('#nameproducts');
    $divProducts.html($divProducts.html() + '<div class="form-control-static"><button type="button" class="delproducts btn btn-default" name="' + productId + '"><i class="icon-remove text-danger"></i></button>&nbsp;' + productName + '</div>');
    $nameProducts.val($nameProducts.val() + productName + '¤');
    $inputProducts.val($inputProducts.val() + productId + '-');
    $('#products_autocomplete_input').val('');
    $('#products_autocomplete_input').setOptions({
      extraParams : {excludeIds : jxblogpostproducts.getProductIds()}
    });
  },
  delProduct       : function(id) {
    var div      = getE('divproducts');
    var input    = getE('inputproducts');
    var name     = getE('nameproducts');
    // Cut hidden fields in array
    var inputCut = input.value.split('-');
    var nameCut  = name.value.split('¤');
    if (inputCut.length != nameCut.length) {
      return jAlert('Bad size');
    }
    // Reset all hidden fields
    input.value   = '';
    name.value    = '';
    div.innerHTML = '';
    for (i in inputCut) {
      // If empty, error, next
      if (!inputCut[i] || !nameCut[i]) {
        continue;
      }
      // Add to hidden fields no selected products OR add to select field selected product
      console.log(id, inputCut[i]);
      if (inputCut[i] != id) {
        input.value += inputCut[i] + '-';
        name.value += nameCut[i] + '¤';
        div.innerHTML += '<div class="form-control-static"><button type="button" class="delproducts btn btn-default" name="' + inputCut[i] + '"><i class="icon-remove text-danger"></i></button>&nbsp;' + nameCut[i] + '</div>';
      }
      else {
        input.value += '-';
        name.value += '¤';
      }
    }
    $('#products_autocomplete_input').setOptions({
      extraParams : {excludeIds : jxblogpostproducts.getProductIds()}
    });
  }
};