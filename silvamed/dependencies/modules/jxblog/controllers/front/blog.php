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
 *  @author    Zemez (Alexander Grosul)
 *  @copyright 2017-2019 Zemez
 *  @license   http://opensource.org/licenses/GPL-2.0 General Public License (GPL 2.0)
 */

class JxblogBlogModuleFrontController extends ModuleFrontController
{
    public $pagename = 'blog';
    public $itemPerPage = 1;
    public $page = 1;
    public function __construct()
    {
        // if this page is terned off redirect to default page
        if (!Configuration::get('JXBLOG_DISPLAY_BLOG_PAGE')) {
            $link = new Link();
            Tools::redirect($link->getModuleLink('jxblog', 'categories'));
        }
        if (Tools::getIsset('page') && $page = Tools::getValue('page')) {
            $this->page = $page;
        }
        parent::__construct();
        $this->itemPerPage = Configuration::get('JXBLOG_POSTS_PER_PAGE');
    }

    public function initContent()
    {
        parent::initContent();
        $pagination = false;
        $categories = JXBlogCategory::getAllFrontCategories(
            2,
            $this->context->language->id,
            $this->context->shop->id,
            $this->context->customer->id_default_group,
            1,
            1000
        );
        $posts = JXBlogPost::getAllPosts($this->context->language->id, $this->context->shop->id, $this->context->customer->id_default_group, $this->page, $this->itemPerPage);
        if ($posts) {
            $pagination = $this->module->buildPagination(
                'bpagination',
                JXBlogPost::countAllPosts(
                    2,
                    $this->context->shop->id,
                    $this->context->customer->id_default_group
                ),
                $this->page,
                $this->itemPerPage
            );
        }
        $this->context->smarty->assign(
            array(
                'categories' => $categories,
                'posts' => $posts,
                'pagination' => $pagination
            )
        );
        $this->setTemplate('module:jxblog/views/templates/front/blog.tpl');
    }

    public function getBreadcrumbLinks()
    {
        $link = new Link();
        $breadcrumb = parent::getBreadcrumbLinks();
        $breadcrumb['links'][] = array('title' => $this->module->translator('blog'), 'url' => $link->getModuleLink('jxblog', 'blog'));

        return $breadcrumb;
    }
}
