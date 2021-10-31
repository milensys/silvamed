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

class HelperBlog
{
    protected $breadCrumbs = array();

    public function buildTree($id_category = 1)
    {
        $rootCategories = array();
        $rootCategories[$id_category] = JXBlogCategory::getChildrenCategories($id_category);
        $tree = $this->fillTree($rootCategories, $id_category);
        return $tree;
    }

    public function buildFrontTree($id_category, $group, $active = false)
    {
        if (!JXBlogCategory::getCategory($id_category, Context::getContext()->language->id, Context::getContext()->shop->id, $group)) {
            return array();
        }
        $rootCategories = array();
        $tree = array();
        $rootCategories[$id_category] = JXBlogCategory::getChildrenCategories($id_category, $group, $active);
        $category = JXBlogCategory::getCategoryShortInfo($id_category, Context::getContext()->language->id);
        // at first add top category and then create its children tree
        $tree[$id_category] = array(
            'id_category' => $category['id_jxblog_category'],
            'name' => $category['name'],
            'link_rewrite' => $category['link_rewrite']
        );
        $tree[$id_category]['children'] = $this->fillTree($rootCategories, $id_category, $group, $active);
        return $tree;
    }

    private function fillTree(&$categories, $rootCategoryId, $group = false, $active = false)
    {
        $tree = array();
        $rootCategoryId = (int) $rootCategoryId;
        foreach ($categories[$rootCategoryId] as $category) {
            $categoryId = (int)$category['id_category'];
            $tree[$categoryId] = $category;

            if ($categoryChildren = JXBlogCategory::getChildrenCategories($categoryId, $group, $active)) {
                foreach ($categoryChildren as $child) {
                    $childId = (int) $child['id_category'];

                    if (!array_key_exists('children', $tree[$categoryId])) {
                        $tree[$categoryId]['children'] = array($childId => $child);
                    } else {
                        $tree[$categoryId]['children'][$childId] = $child;
                    }

                    $categories[$childId] = array($child);
                }

                foreach ($tree[$categoryId]['children'] as $childId => $child) {
                    $subtree = $this->fillTree($categories, $childId, $group, $active);

                    foreach ($subtree as $subcategoryId => $subcategory) {
                        $tree[$categoryId]['children'][$subcategoryId] = $subcategory;
                    }
                }
            }
        }

        return $tree;
    }

    public function buildBreadCrumbs($id_category, $id_category_min = 1)
    {
        $category = JXBlogCategory::getCategoryShortInfo($id_category, Context::getContext()->language->id);
        $this->breadCrumbs[$category['id_jxblog_category']] = $category;
        if ($category['id_parent_category'] > $id_category_min) {
            $this->buildBreadCrumbs($category['id_parent_category'], $id_category_min);
        }
    }

    public function getBreadCrumbs()
    {
        return array_reverse($this->breadCrumbs);
    }
}
