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

class JxblogCategoryModuleFrontController extends ModuleFrontController
{
    public $pagename = 'category';
    public $category;
    public $page = 1;
    public $itemPerPage = 6;
    public $helper;

    public function __construct()
    {
        if (Tools::getIsset('page') && $page = Tools::getValue('page')) {
            $this->page = $page;
        }
        parent::__construct();
        $this->itemPerPage = Configuration::get('JXBLOG_POSTS_PER_PAGE');
        $this->category = new JXBlogCategory(Tools::getValue('id_jxblog_category'), $this->context->language->id);
        $this->helper = new HelperBlog();
        $this->helper->buildBreadCrumbs($this->category->id_jxblog_category, 2);
    }

    public function initContent()
    {
        parent::initContent();
        $pagination = false;
        $posts = false;
        $category = JXBlogCategory::getCategory($this->category->id, $this->context->language->id, $this->context->shop->id, $this->context->customer->id_default_group)[0];
        $subCategories = JXBlogCategory::getSubCategories(
            $this->category->id,
            $this->context->language->id,
            $this->context->shop->id,
            $this->context->customer->id_default_group
        );
        if ($category) {
            $posts = JXBlogPost::getPostsByCategory($this->category->id, $this->context->language->id, $this->page, $this->itemPerPage);
            $pagination = $this->module->buildPagination(
                'pagination',
                JXBlogPost::countPostsByCategory($this->category->id),
                $this->page,
                $this->itemPerPage,
                $this->category->id,
                $this->category->link_rewrite
            );
        }
        $this->context->smarty->assign(
            array(
                'category' => $category,
                'sub_categories' => $subCategories,
                'posts' => $posts,
                'pagination' => $pagination,
                'displayViews' => Configuration::get('JXBLOG_DISPLAY_POST_VIEWS'),
                'displayAuthor' => Configuration::get('JXBLOG_DISPLAY_POST_AUTHOR')
            )
        );

        $this->setTemplate('module:jxblog/views/templates/front/category.tpl');
    }

    public function getBreadcrumbLinks()
    {
        $link = new Link();
        $breadcrumb = parent::getBreadcrumbLinks();
        $breadcrumb['links'][] = array('title' => $this->module->translator('all_categories'), 'url' => $link->getModuleLink('jxblog', 'categories'));
        foreach ($this->helper->getBreadCrumbs() as $item) {
            // exclude home and root categories
            $breadcrumb['links'][] = array(
                'title' => $item['name'],
                'url' => $link->getModuleLink(
                    'jxblog',
                    'category',
                    array(
                        'id_jxblog_category' => $item['id_jxblog_category'],
                        'rewrite' => $item['link_rewrite']
                    )
                )
            );
        }
        return $breadcrumb;
    }
}
