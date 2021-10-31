<?php
/**
 * 2017-2019 Zemez
 *
 * JX Blog
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
 * @author    Zemez (Alexander Grosul)
 * @copyright 2017-2019 Zemez
 * @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
 */

class AdminJXBlogMainSettingsController extends AdminController
{
    public function __construct()
    {
        $this->bootstrap = true;
        parent::__construct();
        $this->fields_options = array(
            'general' => array(
                'title'  => $this->l('Comments settings '),
                'fields' => array(
                    'JXBLOG_IMAGES_AUTO_REGENERATION'      => array(
                        'title'      => $this->l('Image regeneration'),
                        'desc'       => $this->l('Regenerate images automatically after each changing?'),
                        'validation' => 'isBool',
                        'cast'       => 'intval',
                        'type'       => 'bool',
                        'default'    => '0'
                    ),
                    'JXBLOG_DISPLAY_BLOG_PAGE'             => array(
                        'title'      => $this->l('Display Blog main page'),
                        'desc'       => $this->l(
                            'Display Blog main page with all blog content listed instead of Blog category page'
                        ),
                        'validation' => 'isBool',
                        'cast'       => 'intval',
                        'type'       => 'bool',
                        'default'    => '0'
                    ),
                    'JXBLOG_DISPLAY_PRODUCTS_ON_BLOG_PAGE' => array(
                        'title'      => $this->l('Display Products on Blog main page'),
                        'desc'       => $this->l('Display products on Blog main page after all blog content listed'),
                        'validation' => 'isBool',
                        'cast'       => 'intval',
                        'type'       => 'bool',
                        'default'    => '0'
                    ),
                    'JXBLOG_DISPLAY_POST_AUTHOR'           => array(
                        'title'      => $this->l('Display author'),
                        'desc'       => $this->l('Display an author of the post on the front-end?'),
                        'validation' => 'isBool',
                        'cast'       => 'intval',
                        'type'       => 'bool',
                        'default'    => '0'
                    ),
                    'JXBLOG_DISPLAY_POST_VIEWS'            => array(
                        'title'      => $this->l('Display views'),
                        'desc'       => $this->l('Display on the front-end how many times the post has been viewed?'),
                        'validation' => 'isBool',
                        'cast'       => 'intval',
                        'type'       => 'bool',
                        'default'    => '0'
                    ),
                    'JXBLOG_POSTS_PER_PAGE'                => array(
                        'title'      => $this->l('Items per page'),
                        'desc'       => $this->l('How many items will be displayed in listings on the front page?'),
                        'validation' => 'isInt',
                        'type'       => 'text',
                        'default'    => '6'
                    )
                ),
                'submit' => array(
                    'title' => $this->l('Save')
                )
            )
        );
    }
}
