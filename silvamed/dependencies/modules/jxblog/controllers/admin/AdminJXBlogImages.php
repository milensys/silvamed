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

class AdminJXBlogImagesController extends ModuleAdminController
{
    public $translator;
    public $imageTypes;
    public $imageManager;

    public function __construct()
    {
        $this->translator = Context::getContext()->getTranslator();
        $this->table = 'jxblog_image';
        $this->list_id = $this->table;
        $this->identifier = 'id_jxblog_image';
        $this->className = 'JXBlogImage';
        $this->module = $this;
        $this->lang = false;
        $this->bootstrap = true;
        $this->context = Context::getContext();
        $this->_defaultOrderBy = 'id_jxblog_image';
        $this->_defaultOrderWay = 'DESC';
        $this->_default_pagination = 10;
        $this->_pagination = array(10, 20, 50, 100);
        $this->_orderBy = Tools::getValue($this->table.'Orderby');
        $this->_orderWay = Tools::getValue($this->table.'Orderway');
        $this->bulk_actions = array(
            'delete' => array(
                'text' => $this->l('Delete selected'),
                'icon' => 'icon-trash',
                'confirm' => $this->l('Delete selected items?')
            )
        );
        $this->fields_list = array(
            'id_jxblog_image' => array(
                'title'   => $this->l('ID Image'),
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
            'width'        => array(
                'title'   => $this->l('Width'),
                'width'   => 150,
                'type'    => 'text',
                'search'  => true,
                'orderby' => true,
                'lang'    => true
            ),
            'height'        => array(
                'title'   => $this->l('Height'),
                'width'   => 150,
                'type'    => 'text',
                'search'  => true,
                'orderby' => true,
                'lang'    => true
            ),
            'category' => array(
                'title' => $this->l('Categories'),
                'active' => 'category',
                'type' => 'bool',
                'class' => 'fixed-width-xs',
                'align' => 'center',
                'ajax' => true,
                'orderby' => false
            ),
            'category_thumb' => array(
                'title' => $this->l('Categories Thumbnails'),
                'active' => 'category_thumb',
                'type' => 'bool',
                'class' => 'fixed-width-xs',
                'align' => 'center',
                'ajax' => true,
                'orderby' => false
            ),
            'post' => array(
                'title' => $this->l('Posts'),
                'active' => 'post',
                'type' => 'bool',
                'class' => 'fixed-width-xs',
                'align' => 'center',
                'ajax' => true,
                'orderby' => false
            ),
            'post_thumb' => array(
                'title' => $this->l('Posts Thumbnails'),
                'active' => 'post_thumb',
                'type' => 'bool',
                'class' => 'fixed-width-xs',
                'align' => 'center',
                'ajax' => true,
                'orderby' => false
            ),
            'user' => array(
                'title' => $this->l('Users'),
                'active' => 'user',
                'type' => 'bool',
                'class' => 'fixed-width-xs',
                'align' => 'center',
                'ajax' => true,
                'orderby' => false
            )
        );
        $this->languages = Language::getLanguages(false);
        $this->default_language = Configuration::get('PS_LANG_DEFAULT');
        parent::__construct();
        $this->imageManager = new JXBlogImageManager($this->module);
        if (!$this->module->active) {
            Tools::redirectAdmin($this->context->link->getAdminLink('AdminHome'));
        }
    }

    public function renderList()
    {
        $this->addRowAction('edit');
        $this->addRowAction('delete');

        return parent::renderList();
    }

    public function initContent()
    {
        $this->content = '';
        if (Tools::isSubmit('updateDefaultImages')) {
            $this->updateDefaultImages();
            $this->regenerateImages('default');
        }
        if (Tools::isSubmit('regenerateImages')) {
            $this->regenerateImages(Tools::getValue('regenerate_type'));
        }
        if (Tools::getIsset('ajax') && Tools::getValue('ajax')) {
            $action = str_replace($this->table, '', Tools::getValue('action'));
            $id_image_type = Tools::getValue('id_jxblog_image');
            if (!$id_image_type || !$action) {
                die(json_encode(array('success' => false, 'error' => true, 'text' => $this->l('Failed to update the status'))));
            }
            $this->ajaxUpdate($action, $id_image_type);
        } else {
            if ($this->display == 'edit' || $this->display == 'add') {
                $this->content .= $this->renderForm();
            } else {
                $this->content .= $this->renderList();
                $this->content .= $this->renderRegenerateForm();
                $this->content .= $this->renderDefaultImagesForm();
            }
            $this->context->smarty->assign(
                array(
                    'content'                   => $this->content,
                    'url_post'                  => self::$currentIndex.'&token='.$this->token,
                    'show_page_header_toolbar'  => $this->show_page_header_toolbar,
                    'page_header_toolbar_title' => $this->page_header_toolbar_title,
                    'page_header_toolbar_btn'   => $this->page_header_toolbar_btn
                )
            );
        }
    }

    public function renderForm()
    {
        $this->fields_form = array(
            'input'  => array(
                array(
                    'type'     => 'text',
                    'hint'     => $this->l('Letters, underscores and hyphens only (e.g. "small_custom", "post_medium", "large", "thickbox_extra-large").'),
                    'label'    => $this->l('Name'),
                    'name'     => 'name',
                    'required' => true,
                    'desc'     => $this->l('Enter the image type name'),
                    'col'      => 3
                ),
                array(
                    'type'     => 'text',
                    'label'    => $this->l('Width'),
                    'hint'    => $this->l('Maximum image width in pixels.'),
                    'name'     => 'width',
                    'required' => true,
                    'desc'     => $this->l('Enter the image type width'),
                    'col'      => 3,
                    'suffix' => $this->l('px')
                ),
                array(
                    'type'     => 'text',
                    'label'    => $this->l('Height'),
                    'hint'    => $this->l('Maximum image height in pixels.'),
                    'name'     => 'height',
                    'required' => true,
                    'desc'     => $this->l('Enter the image type height'),
                    'col'      => 3,
                    'suffix' => $this->l('px')
                ),
                array(
                    'type'             => 'switch',
                    'label'            => $this->l('Categories'),
                    'hint'            => $this->l('This type will be used for Blog categories images.'),
                    'name'             => 'category',
                    'values'           => array(
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
                    'type'             => 'switch',
                    'label'            => $this->l('Categories Thumbnails'),
                    'hint'             => $this->l('This type will be used for Blog categories thumbnails images.'),
                    'name'             => 'category_thumb',
                    'values'           => array(
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
                    'type'             => 'switch',
                    'label'            => $this->l('Posts'),
                    'hint'            => $this->l('This type will be used for Blog posts images.'),
                    'name'             => 'post',
                    'values'           => array(
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
                    'type'             => 'switch',
                    'label'            => $this->l('Posts Thumbnails'),
                    'hint'             => $this->l('This type will be used for Blog posts thumbnails.'),
                    'name'             => 'post_thumb',
                    'values'           => array(
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
                    'type'             => 'switch',
                    'label'            => $this->l('Blog users'),
                    'hint'             => $this->l('This type will be used for not registered Blog users.'),
                    'name'             => 'user',
                    'values'           => array(
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
                )
            ),
            'submit' => array(
                'title' => $this->l('Save'),
                'class' => 'button pull-right btn btn-default'
            )
        );

        return parent::renderForm();
    }

    public function renderDefaultImagesForm()
    {
        $defaultImages = $this->getDefaultImages();
        $this->fields_form = array(
            'legend' => array(
                'title' => $this->l('Default images')
            ),
            'input' => array(
                array(
                    'type' => 'multilingual_image',
                    'name' => 'image_default',
                    'label' => $this->l('Default image'),
                    'hint' => $this->l('Upload default image.'),
                    'folder' => false,
                    'images' => $defaultImages['image_default']
                ),
                array(
                    'type' => 'multilingual_image',
                    'name' => 'image_category',
                    'label' => $this->l('Categories default image'),
                    'hint' => $this->l('Upload default image for categories.'),
                    'folder' => 'c',
                    'images' => $defaultImages['image_category']
                ),
                array(
                    'type' => 'multilingual_image',
                    'name' => 'image_category_thumb',
                    'label' => $this->l('Categories thumbnails default image'),
                    'hint' => $this->l('Upload default image for categories thumbnails.'),
                    'folder' => 'ct',
                    'images' => $defaultImages['image_category_thumb']
                ),
                array(
                    'type' => 'multilingual_image',
                    'name' => 'image_post',
                    'label' => $this->l('Posts default image'),
                    'hint' => $this->l('Upload default image for posts.'),
                    'folder' => 'p',
                    'images' => $defaultImages['image_post']
                ),
                array(
                    'type' => 'multilingual_image',
                    'name' => 'image_post_thumb',
                    'label' => $this->l('Posts thumbnail default image'),
                    'hint' => $this->l('Upload default image for posts thumbnails.'),
                    'folder' => 'pt',
                    'images' => $defaultImages['image_post_thumb']
                ),
                array(
                    'type' => 'multilingual_image',
                    'name' => 'image_user',
                    'label' => $this->l('Users default image'),
                    'hint' => $this->l('Upload default image for users.'),
                    'folder' => 'u',
                    'images' => $defaultImages['image_user']
                )
            ),
            'submit' => array(
                'title' => $this->l('Save'),
                'class' => 'button pull-right btn btn-default',
                'name' => 'updateDefaultImages',
                'id' => ''
            )
        );

        // add extra fields from related modules
        $extraFields = array_values(Hook::exec('displayJxblogImageManagerExtra', array(), null, true));
        if ($extraFields) {
            foreach ($extraFields[0] as $filed) {
                $this->fields_form['input'][] = $filed;
            }
        }

        return parent::renderForm();
    }

    public function renderRegenerateForm()
    {
        $this->fields_form = array(
            'legend' => array(
                'title' => $this->l('Regenerate images')
            ),
            'input' => array(
                array(
                    'type' => 'select',
                    'name' => 'regenerate_type',
                    'label' => $this->l('Select images type to regenerate'),
                    'desc' => $this->l('All images will regenerated. All old images will be lost.'),
                    'options' => array(
                        'query' => array(
                            array(
                                'id'   => 'all',
                                'type' => $this->l('All')
                            ),
                            array(
                                'id'   => 'category',
                                'type' => $this->l('Categories')
                            ),
                            array(
                                'id'   => 'category_thumb',
                                'type' => $this->l('Categories thumbnails')
                            ),
                            array(
                                'id'   => 'post',
                                'type' => $this->l('Posts')
                            ),
                            array(
                                'id'   => 'post_thumb',
                                'type' => $this->l('Posts thumbnails')
                            ),
                            array(
                                'id'   => 'user',
                                'type' => $this->l('Users')
                            )
                        ),
                        'id'    => 'id',
                        'name'  => 'type'
                    )
                )
            ),
            'submit' => array(
                'title' => $this->l('Regenerate'),
                'class' => 'button pull-right btn btn-default',
                'id' => 'regenerate-images',
                'name' => 'regenerateImages'
            )
        );

        return parent::renderForm();
    }

    public function validateRules($class_name = false)
    {
        // check if this image type name is not already used
        if (!Tools::isEmpty(Tools::getValue('name')) && JXBlogImage::checkIfNameExists(Tools::getValue('name'), Tools::getValue('id_jxblog_image'))) {
            $this->errors[] = $this->l('The image type with this name already exists, you can\'t use the same name more than once.');
        }
        parent::validateRules();
    }

    public function postProcess()
    {
        $id_jxblog_image = Tools::getValue('id_jxblog_image');
        if (!Tools::isSubmit('updateDefaultImages') && !Tools::isSubmit('regenerateImages') && Tools::isSubmit('submitAddjxblog_image')) {
            // remove all old images related to current image type in order to delete images if they are no more related to this type after saving
            if ($this->module->imagesAutoRegenerate && $id_jxblog_image && !$this->imageManager->removeImageTypeImages($id_jxblog_image)) {
                $this->errors[] = $this->lang('Fail to remove old images', array(), 'Modules.JXBlog.Admin');
            }
            $this->validateRules(false);
            if (count($this->errors)) {
                parent::postProcess();
                return false;
            }
            if ($id_jxblog_image = Tools::getValue('id_jxblog_image')) {
                $blogimage = new JXBlogImage($id_jxblog_image);
            } else {
                $blogimage = new JXBlogImage();
            }
            $blogimage->name = Tools::getValue('name');
            $blogimage->width = Tools::getValue('width');
            $blogimage->height = Tools::getValue('height');
            $blogimage->category = Tools::getValue('category');
            $blogimage->category_thumb = Tools::getValue('category_thumb');
            $blogimage->post = Tools::getValue('post');
            $blogimage->post_thumb = Tools::getValue('post_thumb');
            $blogimage->user = Tools::getValue('user');
            if (!$blogimage->save()) {
                $this->errors[] = $this->lang('An error occurred during object regeneration', array(), 'Modules.JXBlog.Admin');
            } else {
                $result = true;
                // check if images auto regeneration option is enabled
                if ($this->module->imagesAutoRegenerate) {
                    foreach (array_keys($this->module->imageTypes) as $imageType) {
                        if ($imageType == 'default' || ($imageType != 'default' && $blogimage->$imageType)) {
                            $result &= $this->imageManager->regenerateTypeImages($imageType, false, $blogimage->name);
                        }
                    }
                }
                if (!$result) {
                    $this->errors[] = $this->lang('An error occurred during images regeneration', array(), 'Modules.JXBlog.Admin');
                } else {
                    Tools::redirectAdmin($this->context->link->getAdminLink('AdminJXBlogImages').'&conf=4');
                }
            }
        } elseif (!Tools::isSubmit('updateDefaultImages') && !Tools::isSubmit('regenerateImages')) {
            parent::postProcess();
        }
    }

    /**
     * Update status for image content type
     *
     * @param $action
     * @param $id_image_type
     */
    public function ajaxUpdate($action, $id_image_type)
    {
        $image = new JXBlogImage((int)$id_image_type);
        if (Validate::isLoadedObject($image)) {
            $image->$action = $image->$action == 1 ? 0 : 1;
            if ($image->save()) {
                // check if images auto regeneration option is enabled
                if ($this->module->imagesAutoRegenerate) {
                    if ($image->$action) {
                        if (!$this->imageManager->regenerateTypeImages($action, false, $image->name)) {
                            die(json_encode(
                                array(
                                    'success' => false,
                                    'text' => $this->l('The status has been updated successfully but images were not generated properly. Please, regenerate it manually.')
                                )
                            ));
                        }
                    } else {
                        if (!$this->imageManager->removeImageTypeImages($image->id, $action)) {
                            die(json_encode(
                                array(
                                    'success' => false,
                                    'text' => $this->l('The status has been updated successfully but images were not removed properly. Please, regenerate it manually.')
                                )
                            ));
                        }
                    }
                }
                die(json_encode(
                    array(
                        'success' => true,
                        'text' => $this->l('The status has been updated successfully')
                    )
                ));
            } else {
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

    public function updateDefaultImages()
    {
        $errors = array();
        foreach ($this->module->imageTypes as $key => $type) {
            foreach ($this->languages as $language) {
                if (Tools::getValue('image_'.$key.'_'.$language['id_lang'])) {
                    if ($error = $this->imageManager->uploadImage($language['iso_code'], $_FILES['image_'.$key.'_'.$language['id_lang']], $key)) {
                        $errors[] = $error;
                    }
                }
            }
        }

        Hook::exec('actionUpdateJxblogImages', array('values' => Tools::getAllValues(), 'images' => $_FILES));

        if (count($errors)) {
            $this->errors[] = $errors;
        }
        $this->confirmations[] = $this->l('Everything is cool!');
    }

    public function getDefaultImages()
    {
        $defaultImages = array();
        foreach ($this->module->imageTypes as $key => $type) {
            foreach ($this->languages as $language) {
                $defaultImages['image_'.$key][$language['id_lang']] = false;
                if ($key == 'default') {
                    if (file_exists($this->module->modulePath.'img/'.$language['iso_code'].'.jpg')) {
                        $defaultImages['image_'.$key][$language['id_lang']] = $this->module->_link.'img/'.$language['iso_code'].'.jpg';
                    }
                } else {
                    if (file_exists($this->module->modulePath.'img/'.$type[0].$language['iso_code'].'.jpg')) {
                        $defaultImages['image_'.$key][$language['id_lang']] = $this->module->_link.'img/'.$type[0].$language['iso_code'].'.jpg';
                    }
                }
            }
        }

        return $defaultImages;
    }

    /**
     * Launch images regeneration
     *
     * @param $type
     */
    public function regenerateImages($type)
    {
        $result = true;
        if ($type == 'all') {
            $result &= $this->imageManager->regenerateTypeImages('default');
            $result &= $this->imageManager->regenerateTypeImages('category');
            $result &= $this->imageManager->regenerateTypeImages('category_thumb');
            $result &= $this->imageManager->regenerateTypeImages('post');
            $result &= $this->imageManager->regenerateTypeImages('post_thumb');
            $result &= $this->imageManager->regenerateTypeImages('user');
        } else {
            $result &= $this->imageManager->regenerateTypeImages($type);
        }
        if (!$result) {
            $this->errors[] = $this->l('An error occurred during the images regeneration');
        } else {
            $this->confirmations[] = $this->l('All images are regenerated successfully');
        }
    }
}
