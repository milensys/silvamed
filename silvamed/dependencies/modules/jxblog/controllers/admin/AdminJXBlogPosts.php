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

class AdminJXBlogPostsController extends ModuleAdminController
{
    public $categories = false;
    protected $helper;

    public function __construct()
    {
        $this->table = 'jxblog_post';
        $this->list_id = $this->table;
        $this->identifier = 'id_jxblog_post';
        $this->className = 'JXBlogPost';
        $this->module = $this;
        $this->lang = true;
        $this->bootstrap = true;
        $this->languages = Language::getLanguages(false);
        $this->default_language = Configuration::get('PS_LANG_DEFAULT');
        $this->context = Context::getContext();
        $this->_defaultOrderBy = 'a.id_jxblog_post';
        $this->_defaultOrderWay = 'ASC';
        $this->_default_pagination = 10;
        $this->_pagination = array(10, 20, 50, 100);
        $this->_orderBy = Tools::getValue($this->table.'Orderby');
        $this->_orderWay = Tools::getValue($this->table.'Orderway');
        $this->imageDir = '../modules/jxblog/img/p/';
        $this->translator = Context::getContext()->getTranslator();
        $this->bulk_actions = array(
            'delete' => array(
                'text'    => $this->l('Delete selected'),
                'icon'    => 'icon-trash',
                'confirm' => $this->l('Delete selected items?')
            )
        );
        $this->fields_list = array(
            'id_jxblog_post' => array(
                'title'   => $this->l('ID Post'),
                'width'   => 50,
                'type'    => 'text',
                'search'  => true,
                'orderby' => true
            ),
            'image' => array(
                'title' => $this->l('Image'),
                'image' => $this->imageDir,
                'width' => 150,
                'align' => 'center',
                'orderby' => false,
                'filter' => false,
                'search' => false
            ),
            'name'           => array(
                'title'   => $this->l('Name'),
                'width'   => 300,
                'type'    => 'text',
                'search'  => true,
                'orderby' => true,
                'lang'    => true,
                'filter_key' => 'b!name'
            ),
            'category_name' => array(
                'title'   => $this->l('Default category'),
                'width'   => 300,
                'type'    => 'text',
                'search'  => true,
                'orderby' => true,
                'lang'    => true,
                'filter_key' => 'cl!name'
            ),
            'employee_last_name' => array(
                'title'   => $this->l('Author'),
                'width'   => 300,
                'type'    => 'text',
                'search'  => true,
                'orderby' => true,
                'lang'    => true,
                'filter_key' => 'e!firstname'
            ),
            'views'           => array(
                'title'   => $this->l('Views'),
                'type'    => 'text',
                'search'  => true,
                'orderby' => true,
                'lang'    => true
            ),
            'date_add' => array(
                'title'   => $this->l('Date added'),
                'width'   => 100,
                'type'    => 'datetime',
                'search'  => true,
                'orderby' => true
            ),
            'date_start' => array(
                'title'   => $this->l('Posted date'),
                'width'   => 100,
                'type'    => 'datetime',
                'search'  => true,
                'orderby' => true
            ),
            'active'         => array(
                'title'   => $this->l('Active'),
                'active'  => 'status',
                'type'    => 'bool',
                'class'   => 'fixed-width-xs',
                'align'   => 'center',
                'ajax'    => true,
                'orderby' => false
            )
        );
        $this->_join = 'LEFT JOIN `'._DB_PREFIX_.'jxblog_category_lang` cl ON(a.`id_jxblog_category_default` = cl.`id_jxblog_category` AND cl.`id_lang` = '.$this->context->language->id.')';
        $this->_join .= ' LEFT JOIN `'._DB_PREFIX_.'employee` e ON(a.`author` = e.`id_employee`)';
        $this->_select = 'cl.`name` as `category_name`, CONCAT(e.`lastname`," ",e.`firstname`)  as `employee_last_name`';
        parent::__construct();
        if (!$this->module->active) {
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminHome'));
        }
        $this->helper = new HelperBlog();
    }

    public function setMedia($isNewTheme = false)
    {
        $this->context->controller->addJquery();
        $this->context->controller->addJqueryUI('ui.widget');
        $this->context->controller->addJqueryPlugin(array('tagify'));
        $this->context->controller->addJs($this->module->modulePath.'views/js/jxblog_admin.js');
        $this->context->controller->addCss($this->module->modulePath.'views/css/jxblog_admin.css');

        parent::setMedia($isNewTheme);
    }

    public function renderList()
    {
        $this->addRowAction('edit');
        $this->addRowAction('delete');

        return parent::renderList();
    }

    public function initContent()
    {
        if (!$this->categories = JXBlogCategory::getAllCategoriesWithInfo()) {
            return $this->errors[] = $this->l('There are no categories in the blog. To create a post you need to create at least one category before.');
        }

        return parent::initContent();
    }

    public function renderForm()
    {
        $categoriesTree = $this->helper->buildTree();
        $image = false;
        $thumb = false;
        if (Tools::getIsset('id_jxblog_post') && $id_jxblog_post = Tools::getValue('id_jxblog_post')) {
            if (file_exists($this->module->modulePath.'img/p/'.$id_jxblog_post.'.jpg')) {
                $image = '<img class="imgm img-thumbnail" src="'.$this->module->_link.'img/p/'.$id_jxblog_post.'.jpg" width="300" />';
            }
        }
        if (isset($id_jxblog_post)) {
            if (file_exists($this->module->modulePath.'img/pt/'.$id_jxblog_post.'.jpg')) {
                $thumb = '<img class="imgm img-thumbnail" src="'.$this->module->_link.'img/pt/'.$id_jxblog_post.'.jpg" width="300" />';
            }
        }

        if (Tools::getIsset('id_jxblog_post') && $id_jxblog_post = Tools::getValue('id_jxblog_post')) {
            $post = new JXBlogPost($id_jxblog_post);
        }
        $defaultList = array();
        foreach ($this->categories as $key => $category) {
            if ($category['id_jxblog_category'] > 1) {
                $defaultList[$key]['id'] = $category['id_jxblog_category'];
                $defaultList[$key]['name'] = $category['name'];
            }
        }

        $this->fields_form = array(
            'input'  => array(
                array(
                    'type'     => 'text',
                    'required' => true,
                    'class'    => 'copy2friendlyUrl',
                    'label'    => $this->l('Post name'),
                    'hint'     => $this->l('Invalid characters: &lt;&gt;;=#{}'),
                    'desc'     => $this->l('Enter the blog post name'),
                    'name'     => 'name',
                    'lang'     => true,
                    'col'      => 4
                ),
                array(
                    'type'     => 'text',
                    'hint'     => $this->l('Only letters, numbers, underscore (_) and the minus (-) character are allowed.'),
                    'label'    => $this->l('Friendly URL'),
                    'name'     => 'link_rewrite',
                    'required' => true,
                    'desc'     => $this->l('Enter the blog post friendly URL. Will be used as a link to the post in the "Friendly URL" mode'),
                    'lang'     => true,
                    'col'      => 3
                ),
                array(
                    'type'         => 'textarea',
                    'label'        => $this->l('Short description'),
                    'name'         => 'short_description',
                    'desc'         => $this->l('Enter the post short description'),
                    'lang'         => true,
                    'col'          => 6,
                    'autoload_rte' => true
                ),
                array(
                    'type'         => 'textarea',
                    'label'        => $this->l('Full description'),
                    'name'         => 'description',
                    'desc'         => $this->l('Enter the post full description'),
                    'lang'         => true,
                    'col'          => 6,
                    'autoload_rte' => true
                ),
                array(
                    'type'  => 'text',
                    'hint'  => $this->l('Only letters, numbers, underscore (_) and the minus (-) character are allowed.'),
                    'label' => $this->l('Meta Keywords'),
                    'name'  => 'meta_keyword',
                    'desc'  => $this->l('Enter Your Post Meta Keywords. Separated by comma(,)'),
                    'lang'  => true,
                    'col'   => 6
                ),
                array(
                    'type'         => 'textarea',
                    'label'        => $this->l('Meta Description'),
                    'name'         => 'meta_description',
                    'desc'         => $this->l('Enter the post meta description'),
                    'lang'         => true,
                    'col'          => 6,
                    'autoload_rte' => false
                ),
                array(
                    'type'          => 'file',
                    'label'         => $this->l('Post image'),
                    'name'          => 'image',
                    'display_image' => true,
                    'image'         => $image ? $image : false,
                    'desc'          => $this->l('Only .jpg images are allowed')
                ),
                array(
                    'type'          => 'file',
                    'label'         => $this->l('Post thumb'),
                    'name'          => 'thumbnail',
                    'display_image' => true,
                    'image'         => $thumb ? $thumb : false,
                    'desc'          => $this->l('Only .jpg images are allowed')
                ),
                array(
                    'type'   => 'switch',
                    'label'  => $this->l('Status'),
                    'name'   => 'active',
                    'values' => array(
                        array(
                            'id'    => 'active_on',
                            'value' => 1,
                            'label' => $this->l('Enabled')
                        ),
                        array(
                            'id'    => 'active_off',
                            'value' => 0,
                            'label' => $this->l('Disabled')
                        )
                    )
                ),
                array(
                    'type' => 'select',
                    'label' => $this->l('Default category'),
                    'name' => 'id_jxblog_category_default',
                    'required' => true,
                    'options' => array(
                        'query' => $defaultList,
                        'id'    => 'id',
                        'name'  => 'name'
                    )
                ),
                array(
                    'type' => 'categories',
                    'label' => $this->l('Associated categories'),
                    'name' => 'jxcategoryBox',
                    'tree' => array(
                        'id' => 'blog-categories-tree',
                        'selected_categories' => isset($post) ? $post->getAssociatedCategories() : array(),
                        'root_category' => 1,
                        'set_data' => $categoriesTree,
                        'use_search' => true,
                        'use_checkbox' => true
                    )
                ),
                array(
                    'type' => 'tags',
                    'name' => 'tags',
                    'label' => $this->l('Post tags'),
                    'lang' => true,
                    'hint' => $this->l('To add "tags," click in the field, write something, and then press "Enter."').'&nbsp;'.$this->l('Forbidden characters:').' <>;=#{}'
                ),
                array(
                    'type' => 'datetime',
                    'name' => 'date_start',
                    'label' => $this->l('Publishing date'),
                    'desc' => $this->l('Set the date if you want to delay the article publishing.')
                )
            ),
            'submit' => array(
                'title' => $this->l('Save'),
                'class' => 'button pull-right btn btn-default'
            )
        );

        $extraData = array_values(Hook::exec('displayJxblogPostExtra', array('post' => isset($post) ? $post : false), null, true));
        // add all necessary data from related modules
        if ($extraData) {
            foreach ($extraData as $extra) {
                $extraFields = $extra['fields'];
                $extraValues = $extra['values'];
                foreach ($extraFields as $filed) {
                    $this->fields_form['input'][] = $filed;
                }
                foreach ($extraValues as $key => $filed) {
                    $this->fields_value[$key] = $filed;
                }
            }
        }

        $this->fields_value['tags'] = isset($post) ? $post->getAdminPostTags() : false;

        if (!($JXBlogPost = $this->loadObject(true))) {
            return;
        }
        return parent::renderForm();
    }

    public function ajaxProcessSearchPosts()
    {
        $excludeIds = array();
        $exclude = explode(',', Tools::getValue('excludeIds'));
        foreach ($exclude as $item) {
            if ($item) {
                $excludeIds[] = $item;
            }
        }

        $posts = JXBlogPost::searchPostsLive(Tools::getValue('q'), $this->context->language->id, Tools::getValue('limit'), $excludeIds);
        if ($posts) {
            die(implode("\n", $posts));
        }
    }

    public function ajaxProcessStatusjxblogPost()
    {
        if (!$id_post = (int)Tools::getValue('id_jxblog_post')) {
            die(json_encode(
                array(
                    'success' => false,
                    'error' => true,
                    'text' => $this->l('Failed to update the status')
                )
            ));
        } else {
            $post = new JXBlogPost((int)$id_post);
            if (Validate::isLoadedObject($post)) {
                $post->active = $post->active == 1 ? 0 : 1;
                $post->save() ?
                    die(json_encode(
                        array(
                            'success' => true,
                            'text' => $this->l('The status has been updated successfully')
                        )
                    )) :
                    die(json_encode(
                        array(
                            'success' => false,
                            'error' => true,
                            'text' => $this->l('Failed to update the status')
                        )
                    ));
            }
        }
    }
}
