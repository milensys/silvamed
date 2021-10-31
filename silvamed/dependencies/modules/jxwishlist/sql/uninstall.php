<?php
/**
* 2017-2018 Zemez
*
* JX Wishlist
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
*  @author    Zemez
*  @copyright 2017-2018 Zemez
*  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
*/

$sql = array();
$sql[] = 'DROP TABLE IF EXISTS `'._DB_PREFIX_.'jxwishlist`';
$sql[] = 'DROP TABLE IF EXISTS `'._DB_PREFIX_.'jxwishlist_product`';

foreach ($sql as $query) {
    if (Db::getInstance()->execute($query) == false) {
        return false;
    }
}
