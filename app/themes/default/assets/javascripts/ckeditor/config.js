CKEDITOR.editorConfig = function( config )
{
    config.toolbar_Custom =
    [
        { name: 'document', items : [ 'Source','Preview', 'Print' ] },
        { name: 'insert', items : [ 'Image','Flash','Smiley', 'Table'] },
                '/',
        { name: 'basicstyles', items : [ 'Bold','Italic','-','RemoveFormat' ] },
        { name: 'paragraph', items : [ 'NumberedList','BulletedList','Blockquote' ] },
        { name: 'links', items : [ 'Link','Unlink','Anchor' ] },
    ];

    config.toolbar = 'Custom';
}
