/**
 * @license Copyright (c) 2003-2021, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see https://ckeditor.com/legal/ckeditor-oss-license
 */

CKEDITOR.editorConfig = function( config ) {
    // Define changes to default configuration here.
    // For complete reference see:
    // https://ckeditor.com/docs/ckeditor4/latest/api/CKEDITOR_config.html

    // The toolbar groups arrangement, optimized for a single toolbar row.
    // config.toolbarGroups = [
    //     // { name: 'document',	   groups: [ 'mode', 'document', 'doctools' ] },
    //     // { name: 'clipboard',   groups: [ 'clipboard', 'undo' ] },
    //     // { name: 'editing',     groups: [ 'find', 'selection', 'spellchecker' ] },
    //     // { name: 'forms' },
    //     { name: 'basicstyles', groups: [ 'basicstyles', 'cleanup' ] },
    //     { name: 'paragraph',   groups: [ 'list', 'indent', 'blocks', 'align', 'bidi' ] },
    //     { name: 'links' },
    //     { name: 'insert' },
    //     { name: 'styles' },
    //     { name: 'colors' },
    //     { name: 'tools' },
    //     { name: 'others' },
    //     { name: 'about' }
    // ];
    //
    // // The default plugins included in the basic setup define some buttons that
    // // are not needed in a basic editor. They are removed here.
    // config.removeButtons = 'Cut,Copy,Paste,Undo,Redo,Anchor,Underline,Strike,Subscript,Superscript';
    //
    // // Dialog windows are also simplified.
    // config.removeDialogTabs = 'link:advanced';

    config.uiColor = '#FAFAFA';
    config.enterMode = CKEDITOR.ENTER_DIV;
    config.toolbar =[
        ['Bold','Italic','Underline','Strike', 'Subscript','Superscript'],
        ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
        ['NumberedList','BulletedList','Outdent','Indent','Blockquote'],
        ['HorizontalRule','Smiley','SpecialChar','Image','Table'],
        ['Styles','Format','Font','FontSize','TextColor','BGColor','Maximize']
    ];

    config.font_names = '맑은 고딕; 굴림; 돋움; 궁서; HY견고딕; HY견명조; 휴먼둥근헤드라인;'
        + '휴먼매직체; 휴먼모음T; 휴먼아미체; 휴먼엑스포; 휴먼옛체; 휴먼편지체;'
        +  CKEDITOR.config.font_names;
    config.removePlugins = 'magicline,elementspath';
    //config.forcePasteAsPlainText = true;

    config.pasteFromWordRemoveFontStyles = false;
    config.pasteFromWordRemoveStyles = false;
    config.allowedContent = true;

    // 이미지 추가 관련 플러그인
    config.extraPlugins = 'popup,filetools,filebrowser,uploadimage,image2,tableresize,dialogadvtab';
    config.filebrowserUploadUrl = '/editor/imageUpload/json?type=ck';
    config.filebrowserBrowseUrl = '/editor/viewImg';
};
