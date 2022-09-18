<?php
/**
 * 2007-2021 PrestaShop
 *
 * NOTICE OF LICENSE
 *
 * This source file is subject to the Academic Free License (AFL 3.0)
 * that is bundled with this package in the file LICENSE.txt.
 * It is also available through the world-wide-web at this URL:
 * http://opensource.org/licenses/afl-3.0.php
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
 * @copyright 2007-2021 PrestaShop SA
 * @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
 *  International Registered Trademark & Property of PrestaShop SA
 */

if (!defined('_PS_VERSION_')) {
    exit;
}

class WebixaButtonCsv extends Module
{
    public function __construct()
    {
        $this->name = 'webixabuttoncsv';
        $this->tab = 'administration';
        $this->version = '1.0.0';
        $this->author = 'Webixa';
        $this->need_instance = true;

        parent::__construct();

        $this->displayName = $this->l('Pobieranie pliku csv');
        $this->description = $this->l('Pozwala na pobranie pliku CSV zawierającego produkty wraz z ich załącznikami');

        $this->ps_versions_compliancy = [
            'min' => '1.7.3',
            'max' => _PS_VERSION_
        ];
    }

    public function getContent()
    {
        return '<a class="button-get-csv" href="' . $this->saveCsvFileGeneral() . '" download>Pobierz csv ogólny</a>
        <a class="button-get-csv" href="' . $this->saveCsvFileLanguage() . '" download>Pobierz csv językowy</a>';
    }

    protected function saveCsvFileGeneral()
    {
        $data = $this->getGeneralRecords();
        $fileName = date('Y-m-d-h-i-s') . '-webixalanguage.csv';

        $csvFields = [
            'ID produktu',
            'Nazwa Produktu',
            'Zalacznik',
        ];

        $this->storeDataIntoCSV($fileName, $csvFields, $data);

        return $fileName;
    }

    protected function saveCsvFileLanguage()
    {
        $data = $this->getLanguageRecords();
        $fileName = date('Y-m-d-h-i-s') . '-webixalanguageitems.csv';

        $csvFields = [
            'ID produktu',
            'Nazwa Produktu',
            'Zalacznik Polski z PL',
            'Zalacznik Angielski z PL',
            'Zalacznik Polski z EN',
            'Zalacznik Angielski z EN',
        ];

        $this->storeDataIntoCSV($fileName, $csvFields, $data);

        return $fileName;
    }

    protected function getLanguageRecords()
    {
        return Db::getInstance()->executeS('
        SELECT 
        ps_product_lang.id_product, 
        ps_product_lang.name, 
        COUNT(CASE WHEN ps_attachment_lang.id_lang = 1 AND ps_attachment_lang.name LIKE "%(PL)%" OR ps_attachment_lang.name LIKE "%[PL]%" THEN ps_product_attachment.id_product ELSE null END) as pl_with_PL,
        COUNT(CASE WHEN ps_attachment_lang.id_lang = 2 AND ps_attachment_lang.name LIKE "%(PL)%" OR ps_attachment_lang.name LIKE "%[PL]%" THEN ps_product_attachment.id_product ELSE null END) as en_with_PL,
        COUNT(CASE WHEN ps_attachment_lang.id_lang = 1 AND ps_attachment_lang.name LIKE "%(EN)%" OR ps_attachment_lang.name LIKE "%[EN]%" THEN ps_product_attachment.id_product ELSE null END) as pl_with_EN,
        COUNT(CASE WHEN ps_attachment_lang.id_lang = 2 AND ps_attachment_lang.name LIKE "%(EN)%" OR ps_attachment_lang.name LIKE "%[EN]%" THEN ps_product_attachment.id_product ELSE null END) as en_with_EN
        FROM ' . _DB_PREFIX_ . 'product_lang
        LEFT JOIN ' . _DB_PREFIX_ . 'product_attachment 
            ON (ps_product_lang.id_product = ps_product_attachment.id_product)
        LEFT JOIN ' . _DB_PREFIX_ . 'attachment_lang
            ON (ps_product_attachment.id_attachment = ps_attachment_lang.id_attachment)
        WHERE ps_product_lang.id_lang = 1
        GROUP BY ps_product_lang.id_product;
        ');
    }

    protected function getGeneralRecords()
    {
        return Db::getInstance()->executeS('
        SELECT ps_product_lang.id_product, ps_product_lang.name, ps_attachment_lang.name as attachment_name
        FROM ' . _DB_PREFIX_ . 'product_lang
        LEFT JOIN ' . _DB_PREFIX_ . 'product_attachment 
            ON (ps_product_lang.id_product = ps_product_attachment.id_product)
        LEFT JOIN ' . _DB_PREFIX_ . 'attachment_lang
            ON (ps_product_attachment.id_attachment = ps_attachment_lang.id_attachment)
        WHERE ps_product_lang.id_lang = 1;
        ');
    }

    /**
     * @param string $fileName
     * @param array $csvFields
     * @param array $data
     * @return void
     */
    protected function storeDataIntoCSV(string $fileName, array $csvFields, array $data)
    {
        $file = fopen($fileName, 'w');

        fputcsv($file, $csvFields, ";");

        foreach ($data as $item) {
            fputcsv($file, $item, ";");
        }

        fclose($file);
    }
}



