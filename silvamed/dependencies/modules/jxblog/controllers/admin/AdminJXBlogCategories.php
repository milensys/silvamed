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

class AdminJXBlogCategoriesController extends ModuleAdminController
{
    public $_category = null;
    protected $position_identifier = 'id_jxblog_category_to_move';
    public $imageManager;
    public $breadCrumbs = array();
    protected $helper;
    public function __construct()
    {
        $this->table = 'jxblog_category';
        $this->list_id = $this->table;
        $this->identifier = 'id_jxblog_category';
        $this->className = 'JXBlogCategory';
        $this->module = $this;
        $this->lang = true;
        $this->bootstrap = true;
        $this->languages = Language::getLanguages(false);
        $this->default_language = Configuration::get('PS_LANG_DEFAULT');
        $this->context = Context::getContext();
        $this->translator = Context::getContext()->getTranslator();
        if (Shop::isFeatureActive()) {
            Shop::addTableAssociation($this->table, array('type' => 'shop'));
        }
        $id_category = (int)Tools::getValue('id_jxblog_category');
        if (!$id_category && !Tools::getIsset('add'.$this->table)) {
            $id_category = 2;
        }
        $this->_category = new JXBlogCategory($id_category);
        $this->_join = 'LEFT JOIN '._DB_PREFIX_.$this->table.'_shop jxs ON a.id_jxblog_category=jxs.id_jxblog_category && jxs.id_shop IN('.implode(',', Shop::getContextListShopID()).')';
        $this->_filter = 'AND a.`id_parent_category` = '.$id_category.' AND a.id_jxblog_category > 2';
        $this->_select = 'jxs.id_shop';
        $this->_defaultOrderBy = 'a.position';
        $this->_defaultOrderWay = 'ASC';
        $this->_default_pagination = 10;
        $this->_pagination = array(10, 20, 50, 100);
        $this->_orderBy = Tools::getValue($this->table.'Orderby');
        $this->_orderWay = Tools::getValue($this->table.'Orderway');
        $this->orderBy = 'position';
        $this->bulk_actions = array(
            'delete' => array(
                'text' => $this->l('Delete selected'),
                'icon' => 'icon-trash',
                'confirm' => $this->l('Delete selected items?')
            )
        );
        if (Shop::isFeatureActive() && Shop::getContext() != Shop::CONTEXT_SHOP) {
            $this->_group = 'GROUP BY a.id_jxblog_category';
        }
        $this->fields_list = array(
            'id_jxblog_category' => array(
                'title'   => $this->l('ID Category'),
                'width'   => 100,
                'type'    => 'text',
                'search'  => true,
                'orderby' => true
            ),
            'name'        => array(
                'title'   => $this->l('Name'),
                'width'   => 440,
                'type'    => 'text',
                'search'  => true,
                'orderby' => true,
                'lang'    => true
            ),
            'position' => array(
                'title' => $this->l('Position'),
                'filter_key' => 'a!position',
                'position' => 'position',
                'align' => 'center'
            ),
            'active' => array(
                'title' => $this->l('Displayed'),
                'active' => 'status',
                'type' => 'bool',
                'class' => 'fixed-width-xs',
                'align' => 'center',
                'ajax' => true,
                'orderby' => false
            )
        );
        parent::__construct();
        $this->imageManager = new JXBlogImageManager($this->module);
        if (!$this->module->active) {
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminHome'));
        }
    }

    public function setMedia($isNewTheme = false)
    {
        $this->context->controller->addCss($this->module->modulePath.'views/css/jxblog_admin.css');

        parent::setMedia($isNewTheme);
    }

    public function init()
    {
        parent::init();
    }

    public function renderView()
    {
        return $this->renderList();
    }

    public function initToolbar()
    {
        // add button "New" to each categories listing
        if ($this->display == 'view') {
            $this->toolbar_btn['new'] = array(
                'href' => self::$currentIndex . '&add' . $this->table . '&id_parent=' . (int) Tools::getValue('id_jxblog_category') . '&token=' . $this->token,
                'desc' => $this->l('Add New'),
            );
        }

        parent::initToolbar();
        // add different back buttons to each category listing
        if (!$this->lite_display
            && isset($this->toolbar_btn['back']['href'])
            && !empty($this->_category)
            && $this->_category->id_parent_category
            && $this->_category->id_parent_category != 2
        ) {
            $this->toolbar_btn['back']['href'] .= '&viewjxblog_category&id_jxblog_category=' . (int) $this->_category->id_parent_category;
        }
    }

    public function renderList()
    {
        $this->addRowAction('view');
        $this->addRowAction('edit');
        $this->addRowAction('delete');
        $this->helper = new HelperBlog();
        // create categories breadcrumb
        $this->helper->buildBreadCrumbs($this->_category->id_jxblog_category);
        $categories_tree = $this->helper->getBreadCrumbs();

        // add edit link to breadcrumb
        if (!empty($categories_tree)) {
            $link = Context::getContext()->link;
            foreach ($categories_tree as $k => $tree) {
                $categories_tree[$k]['edit_link'] = $link->getAdminLink('AdminJXBlogCategories', true) . '&id_jxblog_category=' . (int) $tree['id_jxblog_category'] . '&updatejxblog_category';
            }
        }

        $this->tpl_list_vars['categories_tree'] = $categories_tree;
        $this->tpl_list_vars['categories_tree_current_id'] = $this->_category->id;

        return parent::renderList();
    }

    public function getList($id_lang, $order_by = null, $order_way = null, $start = 0, $limit = null, $id_lang_shop = false)
    {
        parent::getList($id_lang);
        // add view button to category if it has children
        if ($this->_list && count($this->_list)) {
            foreach ($this->_list as $item) {
                if (!JXBlogCategory::getChildrenCategories($item['id_jxblog_category'])) {
                    $this->addRowActionSkipList('view', array($item['id_jxblog_category']));
                }
            }
        }
    }

    public function initContent()
    {
        if ($this->errors) {
            $this->content = $this->renderForm();
            $this->context->smarty->assign('content', $this->content);
        } elseif (Tools::getIsset('delete'.$this->table)) {
            $this->content = $this->confirmDeleteForm();
            parent::initContent();
        } else {
            parent::initContent();
        }
    }

    /**
     * Confirm delete form. Used to determine what to do with the category data(posts, children categories)
     * when you delete the category
     *
     * @return string
     */
    public function confirmDeleteForm()
    {
        $availableCategories = JXBlogCategory::getAllCategoriesWithInfo();
        $options = array();
        foreach ($availableCategories as $key => $category) {
            if ($category['id_jxblog_category'] > 1 &&$category['id_jxblog_category'] != Tools::getValue('id_jxblog_category')) {
                $options[$key]['id'] = $category['id_jxblog_category'];
                $options[$key]['type'] = $category['name'];
            }
        }
        $this->fields_form = array(
            'legend' => array(
                'title' => $this->l('What do you want to do with products and categories that are related to the category?')
            ),
            'input' => array(
                array(
                    'type' => 'hidden',
                    'name' => 'id_jxblog_category',
                    'value' => Tools::getValue('id_jxblog_category')
                ),
                array(
                    'type' => 'radio',
                    'name' => 'deleteAction',
                    'label' => '',
                    'col'  => 12,
                    'values' => array(
                        array(
                            'id' => 'deleteAction',
                            'value' => 1,
                            'label' => $this->l('Remove the category and all children categories and leave their posts without main category')
                        ),
                        array(
                            'id' => 'deleteAction',
                            'value' => 2,
                            'label' => $this->l('Remove the category and all children categories and all their posts')
                        ),
                        array(
                            'id' => 'deleteAction',
                            'value' => 3,
                            'label' => $this->l('Remove the category and only its posts but leave children categories')
                        ),
                        array(
                            'id' => 'deleteAction',
                            'value' => 4,
                            'label' => $this->l('Select new main category from the list below')
                        )
                    )
                ),
                array(
                    'type' => 'select',
                    'name' => 'newDefaultCategory',
                    'label' => '',
                    'col' => 12,
                    'options' => array(
                        'query' => $options,
                        'id'    => 'id',
                        'name'  => 'type'
                    )
                )
            ),
            'buttons' => array(
                array(
                    'title' => $this->l('Delete'),
                    'class' => 'button pull-right btn btn-danger',
                    'name' => 'confirmDelete',
                    'type' => 'submit'
                )
            )
        );

        $this->fields_value['deleteAction'] = 1;
        $this->submit_action = 'confirmDelete';
        return parent::renderForm();
    }

    public function renderForm()
    {
        $categoriesTree = $this->helper->buildTree();
        $id_category = Tools::getValue('id_jxblog_category');
        $unidentified = new Group(Configuration::get('PS_UNIDENTIFIED_GROUP'));
        $guest = new Group(Configuration::get('PS_GUEST_GROUP'));
        $default = new Group(Configuration::get('PS_CUSTOMER_GROUP'));
        $unidentified_group_information = sprintf($this->l('%s - All people without a valid customer account.'), '<b>'.$unidentified->name[$this->context->language->id].'</b>');
        $guest_group_information = sprintf($this->l('%s - Customer who placed an order with the guest checkout.'), '<b>'.$guest->name[$this->context->language->id].'</b>');
        $default_group_information = sprintf($this->l('%s - All people who have created an account on this site.'), '<b>'.$default->name[$this->context->language->id].'</b>');
        $image = false;
        $thumb = false;
        if (Tools::getIsset('id_jxblog_category') && Tools::getValue('id_jxblog_category')) {
            if (file_exists($this->module->modulePath.'img/c/'.Tools::getValue('id_jxblog_category').'.jpg')) {
                $image = '<img class="imgm img-thumbnail" src="'.$this->module->_link.'img/c/'.Tools::getValue('id_jxblog_category').'.jpg" width="300" />';
            }
            if (file_exists($this->module->modulePath.'img/ct/'.Tools::getValue('id_jxblog_category').'.jpg')) {
                $thumb = '<img class="imgm img-thumbnail" src="'.$this->module->_link.'img/ct/'.Tools::getValue('id_jxblog_category').'.jpg" width="150" />';
            }
        }
        $selected_categories = array();
        if (Tools::getIsset('id_parent') && Tools::getValue('id_parent')) {
            $selected_categories[] = Tools::getValue('id_parent');
        } elseif ($this->_category->id_parent_category) {
            $selected_categories[] = $this->_category->id_parent_category;
        } else {
            $selected_categories[] = 2;
        }
        $this->fields_form = array(
            'input'  => array(
                array(
                    'type'     => 'text',
                    'class'    => 'copy2friendlyUrl',
                    'hint'     => $this->l('Invalid characters: <>;=#{}'),
                    'label'    => $this->l('Name'),
                    'name'     => 'name',
                    'required' => true,
                    'desc'     => $this->l('Enter the blog category name'),
                    'lang'     => true,
                    'col'      => 3
                ),
                array(
                    'type'     => 'text',
                    'hint'     => $this->l('Only letters, numbers, underscore (_) and the minus (-) character are allowed.'),
                    'label'    => $this->l('Friendly URL'),
                    'name'     => 'link_rewrite',
                    'required' => true,
                    'desc'     => $this->l('Enter the blog category friendly URL. Will be used as a link to the category in the "Friendly URL" mode'),
                    'lang'     => true,
                    'col'      => 3
                ),
                array(
                    'type' => 'categories',
                    'label' => $this->l('Parent category'),
                    'name' => 'id_parent_category',
                    'tree' => array(
                        'id' => 'blog-categories-tree',
                        'selected_categories' => $selected_categories,
                        'disabled_categories' => (!Tools::isSubmit('add' . $this->table) && !Tools::isSubmit('submitAdd' . $this->table)) ? array($id_category) : null,
                        'root_category' => 1,
                        'set_data' => $categoriesTree,
                        'use_search' => true,
                        'use_checkbox' => false
                    ),
                ),
                array(
                    'type'         => 'textarea',
                    'label'        => $this->l('Short description'),
                    'name'         => 'short_description',
                    'desc'         => $this->l('Enter the category short description'),
                    'lang'         => true,
                    'col'          => 6,
                    'autoload_rte' => true
                ),
                array(
                    'type'         => 'textarea',
                    'label'        => $this->l('Full description'),
                    'name'         => 'description',
                    'desc'         => $this->l('Enter the category full description'),
                    'lang'         => true,
                    'col'          => 6,
                    'autoload_rte' => true
                ),
                array(
                    'type'     => 'text',
                    'hint'     => $this->l('Only letters, numbers, underscore (_) and the minus (-) character are allowed.'),
                    'label'    => $this->l('Meta Keywords'),
                    'name'     => 'meta_keyword',
                    'desc'     => $this->l('Enter Your Category Meta Keywords. Separated by comma(,) '),
                    'lang'     => true,
                    'col'      => 6
                ),
                array(
                    'type'         => 'textarea',
                    'label'        => $this->l('Meta Description'),
                    'name'         => 'meta_description',
                    'desc'         => $this->l('Enter the category meta description'),
                    'lang'         => true,
                    'col'          => 6,
                    'autoload_rte' => false
                ),
                array(
                    'type' => 'file',
                    'label' => $this->l('Image'),
                    'name' => 'image',
                    'value' => true,
                    'display_image' => false,
                    'image' => $image,
                    'desc'  => $this->l('Only .jpg images are allowed')
                ),
                array(
                    'type' => 'file',
                    'label' => $this->l('Image thumbnail'),
                    'name' => 'thumbnail',
                    'value' => true,
                    'display_image' => false,
                    'image' => $thumb,
                    'desc'  => $this->l('Only .jpg images are allowed')
                ),
                array(
                    'type' => 'group',
                    'label' => $this->l('Group access'),
                    'name' => 'groupBox',
                    'values' => Group::getGroups(Context::getContext()->language->id),
                    'info_introduction' => $this->l('You now have three default customer groups.'),
                    'unidentified' => $unidentified_group_information,
                    'guest' => $guest_group_information,
                    'customer' => $default_group_information,
                    'hint' => $this->l('Mark all of the customer groups which you would like to have access to this category.')
                ),
                array(
                    'type'     => 'text',
                    'hint'     => $this->l('Only letters, numbers, underscore (_) and the minus (-) character are allowed.'),
                    'label'    => $this->l('Badge'),
                    'name'     => 'badge',
                    'desc'     => $this->l('Enter the badge which will unify  the category on the list'),
                    'lang'     => true,
                    'col'      => 6
                ),
                array(
                    'type'             => 'switch',
                    'label'            => $this->l('Status'),
                    'name'             => 'active',
                    'values'           => array(
                        array(
                            'id'    => 'active_on',
                            'value' => 1,
                            'label' => $this->l('Enabled'),
                        ),
                        array(
                            'id'    => 'active_off',
                            'value' => 0,
                            'label' => $this->l('Disabled'),
                        )
                    )
                )
            ),
            'submit' => array(
                'title' => $this->l('Save'),
                'class' => 'button pull-right btn btn-default'
            )
        );

        $this->tpl_form_vars['PS_ALLOW_ACCENTED_CHARS_URL'] = (int)Configuration::get('PS_ALLOW_ACCENTED_CHARS_URL');
        if (Shop::isFeatureActive()) {
            $this->fields_form['input'][] = array(
                'type' => 'shop',
                'label' => $this->l('Shop association:'),
                'name' => 'checkBoxShopAsso'
            );
        }

        $category_groups_ids = array();
        if ($id_category) {
            $category = new JXBlogCategory($id_category);
            $category_groups_ids = $category->getGroups();
        }

        $groups = Group::getGroups($this->context->language->id);
        if (!count($category_groups_ids)) {
            $preselected = array(Configuration::get('PS_UNIDENTIFIED_GROUP'), Configuration::get('PS_GUEST_GROUP'), Configuration::get('PS_CUSTOMER_GROUP'));
            $category_groups_ids = array_merge($category_groups_ids, $preselected);
        }
        foreach ($groups as $group) {
            $this->fields_value['groupBox_'.$group['id_group']] = Tools::getValue('groupBox_'.$group['id_group'], (in_array($group['id_group'], $category_groups_ids)));
        }

        if (!($JXBlogCategory = $this->loadObject(true))) {
            return;
        }

        return parent::renderForm();
    }

    public function validateRules($class_name = false)
    {
        parent::validateRules();
    }

    public function postProcess()
    {
        $this->helper = new HelperBlog();
        if (Tools::isSubmit('submitAddjxblog_category') && !Tools::getIsset('confirmDelete')) {
            $this->validateRules();
            if (count($this->errors)) {
                return false;
            }
            $id_category = (int)Tools::getValue('id_jxblog_category');
            if (!$id_category) {
                $category = new JXBlogCategory();
            } else {
                $category = new JXBlogCategory($id_category);
            }
            if (!$id_category) {
                $category->date_add = date('y-m-d H:i:s');
                $category->position = (int)$category->getNewPosition(Tools::getValue('id_parent_category'));
            } else {
                $category->date_upd = date('y-m-d H:i:s');
                if ($category->id_parent_category != Tools::getValue('id_parent_category')) {
                    $category->position = $category->getNewPosition(Tools::getValue('id_parent_category'));
                }
            }
            if (!$parent = Tools::getValue('id_parent_category')) {
                $category->id_parent_category = $category->id_parent_category ? $category->id_parent_category : 0;
            } else {
                $category->id_parent_category = (int)$parent;
            }
            $category->active = Tools::getValue('active');
            foreach ($this->languages as $lang) {
                $category->name[$lang['id_lang']] = Tools::getValue('name_'.$lang['id_lang']);
                $category->link_rewrite[$lang['id_lang']] = Tools::getValue('link_rewrite_'.$lang['id_lang']);
                if (!$category->link_rewrite[$lang['id_lang']]) {
                    $category->link_rewrite[$lang['id_lang']] = Tools::getValue(
                        'link_rewrite_'.$this->default_language
                    );
                }
                if (!$category->link_rewrite[$lang['id_lang']]) {
                    $category->link_rewrite[$lang['id_lang']] = Tools::getValue(
                        'link_rewrite_'.$this->default_language
                    );
                }
                if ($category->checkCategoryNameExistence(
                    $category->id,
                    $category->name[$lang['id_lang']],
                    $lang['id_lang']
                )
                ) {
                    $this->errors[] = sprintf(
                        $this->l('The category with such name already exists!. Name: %s, Language: %s'),
                        $category->name[$lang['id_lang']],
                        $lang['iso_code']
                    );
                }
                if ($category->checkFriendlyUrlNameExistence(
                    $category->id,
                    $category->link_rewrite[$lang['id_lang']],
                    $lang['id_lang']
                )
                ) {
                    $this->errors[] = sprintf(
                        $this->l('The category with such Friendly Url already exists!. Name: %s, Language: %s'),
                        $category->link_rewrite[$lang['id_lang']],
                        $lang['iso_code']
                    );
                }
                $category->description[$lang['id_lang']] = Tools::getValue('description_'.$lang['id_lang']);
                $category->short_description[$lang['id_lang']] = Tools::getValue('short_description_'.$lang['id_lang']);
                $category->meta_keyword[$lang['id_lang']] = Tools::getValue('meta_keyword_'.$lang['id_lang']);
                $category->meta_description[$lang['id_lang']] = Tools::getValue('meta_description_'.$lang['id_lang']);
                $category->badge[$lang['id_lang']] = Tools::getValue('badge_'.$lang['id_lang']);
            }
            if ($this->errors) {
                return false;
            }
            if (!$category->save()) {
                $this->errors[] = Tools::displayError('An error has occurred: Can\'t save the current object');
            }
            // upload category images after successful saving
            $imageManger = new JXBlogImageManager($this->module);
            if (!Tools::isEmpty(Tools::getValue('image')) && Tools::getValue('image')) {
                if ($error = $imageManger->uploadImage($category->id, $_FILES['image'], 'category')) {
                    $this->errors[] = $error;
                }
            }
            if (!Tools::isEmpty(Tools::getValue('thumbnail')) && Tools::getValue('thumbnail')) {
                if ($error = $imageManger->uploadImage($category->id, $_FILES['thumbnail'], 'category_thumb')) {
                    $this->errors[] = $error;
                }
            }
            // redirect to the categories list page if no errors occurred
            if (!$this->errors) {
                if (Tools::getIsset('id_parent_category') && Tools::getValue('id_parent_category') > 2) {
                    //redirent to the parent category listing and avoid wrong redirection if parent category is one of the default
                    Tools::redirectAdmin($this->context->link->getAdminLink('AdminJXBlogCategories').'&conf=4&id_jxblog_category='.Tools::getValue('id_parent_category').'&view'.$this->table);
                }
                // redirect to default category listing
                Tools::redirectAdmin($this->context->link->getAdminLink('AdminJXBlogCategories').'&conf=4');
            }
        } elseif (Tools::isSubmit('confirmDelete') && $id_jxblog_category = Tools::getValue('id_jxblog_category')) {
            $post = new JXBlogPost();
            $category = new JXBlogCategory($id_jxblog_category);
            switch (Tools::getValue('deleteAction')) {
                case 1:
                    $this->removeCategoryWithChildrenAction($this->helper->buildTree($id_jxblog_category));
                    $post->resetDefaultCategory($id_jxblog_category);
                    break;
                case 2:
                    $this->removeCategoryWithChildrenAction($this->helper->buildTree($id_jxblog_category), 'remove');
                    $posts = $post->getPostsByDefaultCategory($id_jxblog_category);
                    if ($posts) {
                        foreach ($posts as $post) {
                            $post = new JXBlogPost($post['id_jxblog_post']);
                            $post->delete();
                        }
                    }
                    break;
                case 3:
                    // remove category's posts
                    $posts = $post->getPostsByDefaultCategory($id_jxblog_category);
                    if ($posts) {
                        foreach ($posts as $post) {
                            $post = new JXBlogPost($post['id_jxblog_post']);
                            $post->delete();
                        }
                    }
                    $childrenCategories = JXBlogCategory::getChildrenCategories($id_jxblog_category);
                    // set all related categories to the home category
                    if ($childrenCategories) {
                        foreach ($childrenCategories as $childrenCategory) {
                            $chCategory = new JXBlogCategory($childrenCategory['id_category']);
                            $chCategory->id_parent_category = 2;
                            $chCategory->position = $chCategory->getNewPosition();
                            $chCategory->update();
                        }
                    }
                    break;
                case 4:
                    $post->resetDefaultCategory($id_jxblog_category, Tools::getValue('newDefaultCategory'));
                    $childrenCategories = JXBlogCategory::getChildrenCategories($id_jxblog_category);
                    if ($childrenCategories) {
                        foreach ($childrenCategories as $childrenCategory) {
                            $chCategory = new JXBlogCategory($childrenCategory['id_category']);
                            $chCategory->id_parent_category = Tools::getValue('newDefaultCategory');
                            $chCategory->position = $chCategory->getNewPosition();
                            $chCategory->update();
                        }
                    }
                    break;
            }
            $category->delete();
            if (!$this->errors) {
                if (Tools::getValue('deleteAction') == 4 && Tools::getValue('newDefaultCategory')) {
                    //redirent to the parent category listing and avoid wrong redirection if parent category is one of the default
                    Tools::redirectAdmin($this->context->link->getAdminLink('AdminJXBlogCategories').'&conf=1&id_jxblog_category='.Tools::getValue('newDefaultCategory').'&view'.$this->table);
                }
                // redirect to default category listing
                Tools::redirectAdmin($this->context->link->getAdminLink('AdminJXBlogCategories').'&conf=1');
            }
        } elseif (!Tools::getIsset('delete'.$this->table)) {
            parent::postProcess();
        }
    }

    public function ajaxProcessStatusjxblogCategory()
    {
        if (!$id_category = (int)Tools::getValue('id_jxblog_category')) {
            die(json_encode(array('success' => false, 'error' => true, 'text' => $this->l('Failed to update the status'))));
        } else {
            $category = new JXBlogCategory((int)$id_category);
            if (Validate::isLoadedObject($category)) {
                $category->active = $category->active == 1 ? 0 : 1;
                $category->save() ?
                    die(json_encode(array('success' => true, 'text' => $this->l('The status has been updated successfully')))) :
                    die(json_encode(array('success' => false, 'error' => true, 'text' => $this->l('Failed to update the status'))));
            }
        }
    }

    public function ajaxProcessUpdatePositions()
    {
        $id_category_to_move = (int)Tools::getValue('id');
        $way = (int)Tools::getValue('way');
        $positions = Tools::getValue('jxblog_category');
        if (is_array($positions)) {
            foreach ($positions as $key => $value) {
                $pos = explode('_', $value);
                if (isset($pos[2]) && $pos[2] == $id_category_to_move) {
                    $position = $key;
                    break;
                }
            }
        }

        $category = new JXBlogCategory($id_category_to_move);
        if (Validate::isLoadedObject($category)) {
            if (isset($position) && $category->updatePosition($way, $position)) {
                die(true);
            } else {
                die('{"hasError" : true, errors : "Cannot update categories position"}');
            }
        } else {
            die('{"hasError" : true, "errors" : "This category cannot be loaded"}');
        }
    }

    /**
     * Remove category and manage related data depending on the selected action
     *
     * @param        $list
     * @param string $action
     *
     * @return bool
     */
    private function removeCategoryWithChildrenAction($list, $action = 'reset')
    {
        $result = true;
        $post = new JXBlogPost();
        if (is_array($list) && count($list)) {
            foreach ($list as $item) {
                if (isset($item['children']) && is_array($item['children'])) {
                    $this->removeCategoryWithChildrenAction($item['children'], $action);
                }
                $category = new JXBlogCategory($item['id_category']);
                // if we want to delete children categories but want to save all post that are related we need to set posts to default category
                if ($action == 'reset') {
                    $result &= $post->resetDefaultCategory($category->id_jxblog_category);
                //if we want to remove categories with related posts
                } elseif ($action == 'remove') {
                    $posts = $post->getPostsByDefaultCategory($category->id_jxblog_category);
                    if ($posts) {
                        foreach ($posts as $post) {
                            $post = new JXBlogPost($post['id_jxblog_post']);
                            $result &= $post->delete();
                        }
                    }
                }
                $result &= $category->delete();
            }
        }

        return $result;
    }
}
