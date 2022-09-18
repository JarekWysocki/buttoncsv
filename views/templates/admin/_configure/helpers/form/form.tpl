{extends file="helpers/form/form.tpl"}
{block name="field"}
    {if $input.type == 'swap-custom'}
        <div class="col-lg-{if isset($input.col)}{$input.col|intval}{else}9{/if}{if !isset($input.label)} col-lg-offset-3{/if} bootstrap margin-group panel swap-custom">
            <div class="swap-custom-container row">
                <div class="col-lg-12">
                    <div class="form-control-static row">
                        <div class="col-xs-6">
                            <label for="{$input.name|escape:'html':'UTF-8'}_available[]">{l s='Unselected items' mod='groupinc'}</label>
                            {if isset($input.search)}
                                <div class="input-group">
                                    <span class="input-group-addon">{l s='Search' mod='groupinc'}</span>
                                    <input type="text" class="search_select" id="{$input.name|escape:'html':'UTF-8'}_available_search" autocomplete="off">
                                </div>
                            {/if}

                            <select {if isset($input.size)}size="{$input.size|escape:'html':'UTF-8'}"{/if}{if isset($input.onchange)} onchange="{$input.onchange|escape:'html':'UTF-8'}"{/if} class="{if isset($input.class)}{$input.class|escape:'html':'UTF-8'}{/if} availableSwap" name="{$input.name|escape:'html':'UTF-8'}_available[]" multiple="multiple">
                                {foreach $input.options.query AS $option}
                                    {if is_object($option)}
                                        {assign var=option value=$option->arrContent}
                                    {/if}
                                    {if !is_array($fields_value[$input.name]) || !in_array($option[$input.options.id|escape:'html':'UTF-8'], $fields_value[$input.name])}
                                        <option {if isset($input.sort) && isset($option[$input.sort])}data-sort="{$option[$input.sort|escape:'html':'UTF-8']}"{/if} value="{$option[$input.options.id|escape:'html':'UTF-8']}">{$option[$input.options.name|escape:'html':'UTF-8']}</option>
                                    {elseif $option == "-"}
                                        <option value="">-</option>
                                    {/if}
                                {/foreach}
                            </select>

                            {if isset($input.search)}
                                <script type="text/javascript">
                                    $(document).ready(function() {
                                        $('[name="{$input.name|escape:'html':'UTF-8'}_available[]"]').filterByText('#{$input.name|escape:'html':'UTF-8'}_available_search', true);
                                    });
                                </script>
                            {/if}
                            <a href="#" class="btn btn-default btn-block addSwap">{l s='Add' d='Admin.Actions'} <i class="icon-arrow-right"></i></a>
                        </div>
                        <div class="col-xs-6">
                            <label for="{$input.name|escape:'html':'UTF-8'}_selected[]">{l s='Selected items' mod='groupinc'}</label>
                            {if isset($input.search)}
                                <div class="input-group">
                                    <span class="input-group-addon">{l s='Search' mod='groupinc'}</span>
                                    <input type="text" class="search_select" id="{$input.name|escape:'html':'UTF-8'}_selected_search" autocomplete="off">
                                </div>
                            {/if}
                            <select {if isset($input.size)}size="{$input.size|escape:'html':'UTF-8'}"{/if}{if isset($input.onchange)} onchange="{$input.onchange|escape:'html':'UTF-8'}"{/if} class="{if isset($input.class)}{$input.class|escape:'html':'UTF-8'}{/if} selectedSwap" name="{$input.name|escape:'html':'UTF-8'}_selected[]" multiple="multiple">
                                {foreach $input.options.query AS $option}
                                    {if is_object($option)}
                                        {assign var=option value=$option->arrContent}
                                    {/if}

                                    {if is_array($fields_value[$input.name]) && in_array($option[$input.options.id|escape:'html':'UTF-8'], $fields_value[$input.name])}
                                        <option {if isset($input.sort) && isset($option[$input.sort])}data-sort="{$option[$input.sort|escape:'html':'UTF-8']}"{/if} value="{$option[$input.options.id|escape:'html':'UTF-8']}">{$option[$input.options.name|escape:'html':'UTF-8']}</option>
                                    {elseif $option == "-"}
                                        <option value="">-</option>
                                    {/if}
                                {/foreach}
                            </select>
                            {if isset($input.search)}
                                <script type="text/javascript">
                                    $(document).ready(function() {
                                        $('[name="{$input.name|escape:'html':'UTF-8'}_selected[]"]').filterByText('#{$input.name|escape:'html':'UTF-8'}_selected_search', true);
                                    });
                                </script>
                            {/if}
                            <a href="#" class="btn btn-default btn-block removeSwap"><i class="icon-arrow-left"></i> {l s='Remove' mod='groupinc'}</a>
                        </div>
                    </div>
                </div>
                {if isset($input['desc']) && !empty($input['desc'])}
                    <div class="col-lg-12">
                        <div class="help-block">
                            {if is_array($input['desc'])}
                                {foreach $input['desc'] as $p}
                                    {if is_array($p)}
                                        <span id="{$p.id|intval}">{$p.text nofilter}</span><br /> {* May contain JS code *}
                                    {else}
                                        {$p nofilter}<br /> {* May contain JS code *}
                                    {/if}
                                {/foreach}
                            {else}
                                {$input['desc'] nofilter} {* May contain JS code *}
                            {/if}
                        </div>
                    </div>
                {/if}
            </div>
        </div>
        {if version_compare($smarty.const._PS_VERSION_,'1.6','<')}
            <div class="clear">&nbsp;</div>
        {/if}
    {else}
        {$smarty.block.parent}
    {/if}
{/block}

{block name="after"}
    <style>
        .swap-custom-container label {
            font-weight: normal;
        }

        #content.bootstrap .swap-custom.panel {
            padding: 10px 20px;
        }

        .swap-custom select[multiple] {
            height: 150px;
        }

        .swap-custom select option {
            white-space: normal;
        }
    </style>

    {if version_compare($smarty.const._PS_VERSION_,'1.6','<')}
        <style>
            .bootstrap .input-group {
                border-collapse: separate;
                display: table;
                position: relative
            }
            .bootstrap .input-group .form-control,
            .bootstrap .input-group input[type=password],
            .bootstrap .input-group input[type=search],
            .bootstrap .input-group input[type=text],
            .bootstrap .input-group select,
            .bootstrap .input-group textarea {
                float: left;
                margin-bottom: 0;
                position: relative;
                width: 100%;
                z-index: 2
            }
            .bootstrap .input-group-addon,
            .bootstrap .input-group-btn,
            .bootstrap .input-group .form-control,
            .bootstrap .input-group input[type=password],
            .bootstrap .input-group input[type=search],
            .bootstrap .input-group input[type=text],
            .bootstrap .input-group select,
            .bootstrap .input-group textarea {
                display: table-cell
            }
            .bootstrap .input-group-addon:not(:first-child):not(:last-child),
            .bootstrap .input-group-btn:not(:first-child):not(:last-child),
            .bootstrap .input-group .form-control:not(:first-child):not(:last-child),
            .bootstrap .input-group input:not(:first-child):not(:last-child)[type=password],
            .bootstrap .input-group input:not(:first-child):not(:last-child)[type=search],
            .bootstrap .input-group input:not(:first-child):not(:last-child)[type=text],
            .bootstrap .input-group select:not(:first-child):not(:last-child),
            .bootstrap .input-group textarea:not(:first-child):not(:last-child) {
                border-radius: 0
            }
            .bootstrap .input-group-addon {
                vertical-align: middle;
                white-space: nowrap;
                width: 1%
            }
            .bootstrap .input-group-addon {
                background-color: #f5f8f9;
                border: 1px solid #c7d6db;
                border-radius: 3px;
                color: #555;
                font-size: 12px;
                font-weight: 400;
                line-height: 1;
                padding: 6px 8px;
                text-align: center
            }

            .bootstrap .input-group-addon input[type=checkbox],
            .bootstrap .input-group-addon input[type=radio] {
                margin-top: 0
            }
            .bootstrap .input-group-addon:first-child,
            .bootstrap .input-group-btn:first-child > .btn,
            .bootstrap .input-group-btn:first-child > .btn-group > .btn,
            .bootstrap .input-group-btn:first-child > .dropdown-toggle,
            .bootstrap .input-group-btn:last-child > .btn-group:not(:last-child) > .btn,
            .bootstrap .input-group-btn:last-child > .btn:not(:last-child):not(.dropdown-toggle),
            .bootstrap .input-group .form-control:first-child,
            .bootstrap .input-group input:first-child[type=password],
            .bootstrap .input-group input:first-child[type=search],
            .bootstrap .input-group input:first-child[type=text],
            .bootstrap .input-group select:first-child,
            .bootstrap .input-group textarea:first-child {
                border-bottom-right-radius: 0;
                border-top-right-radius: 0
            }
            .bootstrap .input-group-addon:first-child {
                border-right: 0
            }
            .bootstrap .input-group-addon:last-child,
            .bootstrap .input-group-btn:first-child > .btn-group:not(:first-child) > .btn,
            .bootstrap .input-group-btn:first-child > .btn:not(:first-child),
            .bootstrap .input-group-btn:last-child > .btn,
            .bootstrap .input-group-btn:last-child > .btn-group > .btn,
            .bootstrap .input-group-btn:last-child > .dropdown-toggle,
            .bootstrap .input-group .form-control:last-child,
            .bootstrap .input-group input:last-child[type=password],
            .bootstrap .input-group input:last-child[type=search],
            .bootstrap .input-group input:last-child[type=text],
            .bootstrap .input-group select:last-child,
            .bootstrap .input-group textarea:last-child {
                border-bottom-left-radius: 0;
                border-top-left-radius: 0
            }
            .bootstrap .input-group-addon:last-child {
                border-left: 0
            }
            .bootstrap .input-group-btn {
                font-size: 0;
                position: relative;
                white-space: nowrap
            }
            .bootstrap .input-group-btn > .btn {
                position: relative
            }
            .bootstrap .input-group-btn > .btn + .btn {
                margin-left: -1px
            }
            .bootstrap .input-group-btn > .btn:active,
            .bootstrap .input-group-btn > .btn:focus,
            .bootstrap .input-group-btn > .btn:hover {
                z-index: 2
            }
            .bootstrap .input-group-btn:first-child > .btn,
            .bootstrap .input-group-btn:first-child > .btn-group {
                margin-right: -1px
            }
            .bootstrap .input-group-btn:last-child > .btn,
            .bootstrap .input-group-btn:last-child > .btn-group {
                margin-left: -1px
            }
            .bootstrap .btn-block {
                display: block;
                padding-left: 0;
                padding-right: 0;
                width: 100%;
            }
            .bootstrap .btn-default {
                background-color: #fff;
                border-color: #dedede;
                color: #363a41;
            }
            .bootstrap .btn {
                -moz-user-select: none;
                -ms-user-select: none;
                -webkit-user-select: none;
                background-image: none;
                border: 1px solid transparent;
                border-radius: 3px;
                cursor: pointer;
                display: inline-block;
                font-size: 12px;
                font-weight: 400;
                line-height: 1.42857;
                margin-bottom: 0;
                padding: 6px 8px;
                text-align: center;
                user-select: none;
                vertical-align: middle;
                white-space: nowrap;
            }

            .bootstrap select[multiple],
            .bootstrap select[size] {
                height: auto;
            }
            .bootstrap .form-control,
            .bootstrap input[type=password],
            .bootstrap input[type=search],
            .bootstrap input[type=text],
            .bootstrap select,
            .bootstrap textarea {
                -webkit-transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
                -webkit-transition: border-color .15s ease-in-out,-webkit-box-shadow .15s ease-in-out;
                background-color: #f5f8f9;
                background-image: none;
                border: 1px solid #c7d6db;
                border-radius: 3px;
                color: #555;
                display: block;
                font-size: 12px;
                height: 31px;
                line-height: 1.42857;
                padding: 6px 8px;
                transition: border-color .15s ease-in-out,-webkit-box-shadow .15s ease-in-out;
                transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out;
                transition: border-color .15s ease-in-out,box-shadow .15s ease-in-out,-webkit-box-shadow .15s ease-in-out;
                width: 100%;
            }
        </style>
    {/if}
{/block}

{block name="script"}
    $(document).ready(function() {
        $('.swap-custom-container').each(function () {
            /** make sure that all the swap id is present in the dom to prevent mistake **/
            if (typeof $('.addSwap', this) !== undefined && typeof $(".removeSwap", this) !== undefined &&
                typeof $('.selectedSwap', this) !== undefined && typeof $('.availableSwap', this) !== undefined) {
                bindSwapButtonCustom('add', 'available', 'remove', 'selected', this);
                bindSwapButtonCustom('remove', 'selected', 'add', 'available', this);
                doubleClickOptionCustom('add', 'available', this);
                doubleClickOptionCustom('remove', 'selected', this);
            }
        });
    });

    function doubleClickOptionCustom(from_button, prefix_select, context) {
        $('.' + prefix_select + 'Swap option', context).on('click', function() {
            $(this).dblclick(function() {
                $('.'+from_button+'Swap', context).click();
            })
        });
    }

    function bindSwapButtonCustom(from_button, from_select, to_button, to_select, context) {
        $('.'+from_button+'Swap', context).on('click', function(e) {
            e.preventDefault();
            $('.' + from_select + 'Swap option:selected', context).each(function() {
                var to = $('.' + to_select + 'Swap', context);
                var from = $('.' + from_select + 'Swap', context);

                var selected = from.find('option:selected');
                var selectedVal = [];
                selected.each(function(){
                    selectedVal.push($(this).val());
                });

                var options = from.data('options');
                var tempOption = [];

                var targetOptions = to.data('options');

                $.each(options, function(i) {
                    var option = options[i];
                    if($.inArray(option.value, selectedVal) == -1) {
                        tempOption.push(option);
                    } else {
                        targetOptions.push(option);
                    }
                });

                to.find('option:selected').prop('selected', false);
                from.find('option:selected').remove().appendTo(to).prop('selected', true);

                to.data('options', targetOptions);
                from.data('options', tempOption);

                //Sort select
                to.html(to.find('option').sort(function(x, y) {
                    // to change to descending order switch "<" for ">"
                    if (isNaN($(x).data('sort')) || isNaN($(y).data('sort'))) {
                        return $(x).data('sort') > $(y).data('sort') ? 1 : -1;
                    } else {
                        return $(x).data('sort') - $(y).data('sort');
                    }
                }));

                //Update results if a search is typed in the fields
                if ($('.search_select').val()) {
                    $('.search_select', context).keyup();
                }
            });

            $('.' + to_select + 'Swap option', context).on('click', function() {
                $(this)[0].ondblclick = function(){
                    $('.'+to_button+'Swap', context).click();
                };
            });
        });
    }

    // http://www.lessanvaezi.com/filter-select-list-options/
    jQuery.fn.filterByText = function(textbox, selectSingleMatch) {
        return this.each(function() {
            var select = $(this);
            var options = [];
            select.find('option').each(function() {
                options.push({ value: $(this).val(), text: $(this).text()});
            });
            select.data('options', options);
            textbox = textbox.replace( /(:|\.|\[|\]|,|=|@)/g, "\\$1" );
            $(textbox).bind('keyup', function(e) {
                var options = select.empty().scrollTop(0).data('options');
                var search = $.trim($(this).val());
                var regex = new RegExp(search,'gi');

                var new_options_html = '';
                $.each(options, function(i, option) {
                    if(option.text.match(regex) !== null) {
                        new_options_html += '<option value="' + option.value + '">' + option.text + '</option>';
                    }
                });

                select.append(new_options_html);

                if (selectSingleMatch === true &&
                    select.children().length === 1) {
                    select.children().get(0).selected = true;
                } else if (select.children().length > 0) {
                    select.children().get(0).selected = false;
                }
            })
        })
    };

    $('form').submit(function() {
        //Remove all values from search fields, because if don't the hidden values are not set
        $('.search_select').each(function() {
            $(this).val('').trigger('keyup');
        });

        $('.availableSwap').each(function() {
            $(this).find('option').each(function() {
                $(this).prop('selected', false);
            });
        });

        $('.selectedSwap').each(function() {
            $(this).find('option').each(function() {
                $(this).prop('selected', true);
            });
        });
    });
{/block}









